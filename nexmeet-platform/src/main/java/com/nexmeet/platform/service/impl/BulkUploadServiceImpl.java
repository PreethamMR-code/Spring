package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.BulkUploadDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.enums.RegistrationType;
import com.nexmeet.platform.service.*;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional
public class BulkUploadServiceImpl implements BulkUploadService {

    @Autowired private BulkUploadDao bulkUploadDao;
    @Autowired private UserDao userDao;
    @Autowired private RegistrationDao registrationDao;
    @Autowired private ConferenceService conferenceService;
    @Autowired private RegistrationService registrationService;
    @Autowired private NotificationService notificationService;
    @Autowired private EmailService emailService;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private PaymentService paymentService;

    /*
     * Finds or creates the DELEGATE role.
     * We store the role name without prefix internally.
     */
    @Autowired
    private org.hibernate.SessionFactory sessionFactory;

    @Override
    public com.nexmeet.platform.entity.BulkUpload
    processBulkUpload(
            Long conferenceId,
            String organizerEmail,
            MultipartFile file) {

        Conference conference = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        // Security: only owning organizer
        if (!conference.getOrganizer().getUser()
                .getEmail().equals(organizerEmail)) {
            throw new RuntimeException("Unauthorized");
        }

        // Verify conference allows bulk upload
        if (!conference.isBulkUploadAllowed()) {
            throw new RuntimeException(
                    "Bulk upload is not enabled " +
                            "for this conference.");
        }

        // Create the upload tracking record
        User organizer = userDao.findByEmail(organizerEmail)
                .orElseThrow(() ->
                        new RuntimeException("Organizer not found"));

        com.nexmeet.platform.entity.BulkUpload upload =
                new com.nexmeet.platform.entity.BulkUpload();
        upload.setConference(conference);
        upload.setUploadedBy(organizer);
        upload.setFileName(file.getOriginalFilename());
        upload.setFilePath("memory"); // no disk storage
        upload.setStatus("PROCESSING");
        bulkUploadDao.save(upload);

        int totalRows = 0;
        int successCount = 0;
        int failCount = 0;
        StringBuilder errorLog = new StringBuilder();


            /*
             * Parse CSV using Apache Commons CSV.
             * We use withFirstRecordAsHeader() so organizers
             * can use header names instead of column indices.
             * This makes the CSV format more forgiving.
             *
             * Expected columns (header names):
             * full_name, email, phone (phone optional)
             *
             * Also supports without headers:
             * Column 0 = name, Column 1 = email,
             * Column 2 = phone (optional)
             */
            try {
                String originalFilename = file.getOriginalFilename();

                if (isExcelFile(originalFilename)) {
                    // ── EXCEL PARSING PATH ──────────────────────
                    org.apache.poi.ss.usermodel.Workbook workbook;

                    String lower = originalFilename.toLowerCase();
                    if (lower.endsWith(".xlsx")) {
                        workbook = new org.apache.poi.xssf.usermodel
                                .XSSFWorkbook(file.getInputStream());
                    } else {
                        workbook = new org.apache.poi.hssf.usermodel
                                .HSSFWorkbook(file.getInputStream());
                    }

                    org.apache.poi.ss.usermodel.Sheet sheet =
                            workbook.getSheetAt(0);

                    /*
                     * Read header row to find column indices.
                     * Excel headers: full_name, email, phone
                     * (case-insensitive, same as CSV)
                     */
                    org.apache.poi.ss.usermodel.Row headerRow =
                            sheet.getRow(0);

                    int nameCol = -1, emailCol = -1, phoneCol = -1;

                    if (headerRow != null) {
                        for (int c = 0; c < headerRow.getLastCellNum();
                             c++) {
                            org.apache.poi.ss.usermodel.Cell cell =
                                    headerRow.getCell(c);
                            if (cell == null) continue;
                            String h = cell.getStringCellValue()
                                    .trim().toLowerCase();
                            if (h.equals("full_name") ||
                                    h.equals("fullname") ||
                                    h.equals("name")) {
                                nameCol = c;
                            } else if (h.equals("email") ||
                                    h.equals("email_address")) {
                                emailCol = c;
                            } else if (h.equals("phone") ||
                                    h.equals("mobile") ||
                                    h.equals("phone_number")) {
                                phoneCol = c;
                            }
                        }
                    }

                    // Default column positions if no header found
                    if (nameCol == -1) nameCol = 0;
                    if (emailCol == -1) emailCol = 1;
                    if (phoneCol == -1) phoneCol = 2;

                    /*
                     * Start from row index 1 to skip header row.
                     * getLastRowNum() is 0-indexed.
                     */
                    int startRow = (headerRow != null) ? 1 : 0;

                    for (int r = startRow;
                         r <= sheet.getLastRowNum(); r++) {
                        org.apache.poi.ss.usermodel.Row row =
                                sheet.getRow(r);

                        // Skip completely empty rows
                        if (row == null) continue;

                        totalRows++;
                        int rowNum = r + 1; // 1-based for error log

                        try {
                            String fullName = getCellString(
                                    row, nameCol);
                            String email   = getCellString(
                                    row, emailCol);
                            String phone   = getCellString(
                                    row, phoneCol);

                            // Reuse the same validation and
                            // registration logic as CSV path
                            String result = processOneRow(
                                    fullName, email, phone,
                                    rowNum, conference,
                                    conferenceId, errorLog);

                            if ("SUCCESS".equals(result)) {
                                successCount++;
                            } else {
                                failCount++;
                            }

                        } catch (Exception rowEx) {
                            errorLog.append("Row ").append(rowNum)
                                    .append(": Unexpected error: ")
                                    .append(rowEx.getMessage())
                                    .append("\n");
                            failCount++;
                        }
                    }

                    workbook.close();

                } else {
                    // ── CSV PARSING PATH ─────────────────────────
                    InputStreamReader reader =
                            new InputStreamReader(
                                    file.getInputStream(),
                                    StandardCharsets.UTF_8);

                    CSVParser parser = CSVFormat.DEFAULT
                            .withFirstRecordAsHeader()
                            .withIgnoreEmptyLines()
                            .withTrim()
                            .parse(reader);

                    Map<String, Integer> headerMap =
                            parser.getHeaderMap();
                    boolean hasHeaders = headerMap != null
                            && !headerMap.isEmpty();

                    for (CSVRecord record : parser) {
                        totalRows++;
                        int rowNum = (int) record.getRecordNumber();

                        try {
                            String fullName, email, phone;

                            if (hasHeaders) {
                                fullName = getColumnValue(record,
                                        headerMap, "full_name",
                                        "fullname", "name",
                                        "Full Name", "Name");
                                email = getColumnValue(record,
                                        headerMap, "email", "Email",
                                        "email_address");
                                phone = getColumnValue(record,
                                        headerMap, "phone", "Phone",
                                        "mobile", "phone_number");
                            } else {
                                fullName = record.get(0).trim();
                                email    = record.size() > 1
                                        ? record.get(1).trim() : "";
                                phone    = record.size() > 2
                                        ? record.get(2).trim() : "";
                            }

                            String result = processOneRow(
                                    fullName, email, phone,
                                    rowNum, conference,
                                    conferenceId, errorLog);

                            if ("SUCCESS".equals(result)) {
                                successCount++;
                            } else {
                                failCount++;
                            }

                        } catch (Exception rowEx) {
                            errorLog.append("Row ").append(rowNum)
                                    .append(": Unexpected error: ")
                                    .append(rowEx.getMessage())
                                    .append("\n");
                            failCount++;
                        }
                    }

                    parser.close();
                }

            } catch (Exception e) {
                upload.setStatus("FAILED");
                upload.setErrorLog(
                        "File parsing failed: " + e.getMessage());
                upload.setTotalRows(0);
                upload.setSuccessfulRows(0);
                upload.setFailedRows(0);
                upload.setCompletedAt(LocalDateTime.now());
                bulkUploadDao.update(upload);
                throw new RuntimeException(
                        "File parsing failed: " + e.getMessage());
            }

        // Update upload record with results
        upload.setTotalRows(totalRows);
        upload.setSuccessfulRows(successCount);
        upload.setFailedRows(failCount);
        upload.setStatus(failCount == 0 ?
                "COMPLETED" : "COMPLETED_WITH_ERRORS");
        upload.setErrorLog(
                errorLog.length() > 0
                        ? errorLog.toString() : null);
        upload.setCompletedAt(LocalDateTime.now());
        bulkUploadDao.update(upload);

        return upload;
    }

    /*
     * Flexible column lookup — tries multiple possible
     * column names for the same field.
     * This makes the CSV format forgiving for users.
     */
    private String getColumnValue(
            CSVRecord record,
            Map<String, Integer> headerMap,
            String... possibleNames) {
        for (String name : possibleNames) {
            if (headerMap.containsKey(name)) {
                try {
                    String val = record.get(name);
                    return val != null ? val.trim() : null;
                } catch (Exception e) {
                    // try next name
                }
            }
        }
        return null;
    }

    /*
     * Determines if the uploaded file is Excel based
     * on the original filename extension.
     */
    private boolean isExcelFile(String filename) {
        if (filename == null) return false;
        String lower = filename.toLowerCase();
        return lower.endsWith(".xlsx") || lower.endsWith(".xls");
    }



    private String generateRegistrationNumber() {
        return "NM-" + Long.toHexString(
                        System.currentTimeMillis()).toUpperCase()
                .substring(4);
    }

    /*
     * Generates a readable temp password.
     * Format: NexMeet + 4 random digits
     * e.g. NexMeet2847
     * Delegate is encouraged to change this on first login.
     */
    private String generateTempPassword() {
        int num = new Random().nextInt(9000) + 1000;
        return "NexMeet" + num;
    }

    /*
     * Reads a cell value as String regardless of cell type.
     * Excel cells can be NUMERIC, STRING, FORMULA, BLANK.
     * We handle all cases and return clean trimmed String.
     */
    private String getCellString(
            org.apache.poi.ss.usermodel.Row row,
            int colIndex) {
        if (colIndex < 0) return "";
        org.apache.poi.ss.usermodel.Cell cell =
                row.getCell(colIndex);
        if (cell == null) return "";

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                // Phone numbers stored as numbers in Excel
                // Convert to long to remove decimal point
                return String.valueOf(
                        (long) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    return cell.getStringCellValue().trim();
                } catch (Exception e) {
                    return String.valueOf(
                            (long) cell.getNumericCellValue());
                }
            default:
                return "";
        }
    }

    /*
     * Core per-row processing logic — shared between
     * CSV and Excel paths.
     *
     * Returns "SUCCESS" or an error reason string.
     * Appends error messages to errorLog.
     * Handles: validate → find/create user →
     *          check duplicate → register →
     *          notify → email
     */
    private String processOneRow(
            String fullName,
            String email,
            String phone,
            int rowNum,
            Conference conference,
            Long conferenceId,
            StringBuilder errorLog) {

        // Validate name
        if (fullName == null || fullName.isEmpty()) {
            errorLog.append("Row ").append(rowNum)
                    .append(": Full name is required\n");
            return "FAIL";
        }

        // Validate email
        if (email == null || email.isEmpty()
                || !email.contains("@")) {
            errorLog.append("Row ").append(rowNum)
                    .append(": Invalid email: ")
                    .append(email).append("\n");
            return "FAIL";
        }

        email = email.toLowerCase().trim();

        // Check seat capacity
        if (conference.getRegisteredCount()
                >= conference.getMaxDelegates()) {
            errorLog.append("Row ").append(rowNum)
                    .append(": Conference is full.\n");
            return "FAIL";
        }

        // Find or create user
        String tempPassword = null;
        boolean isNewUser = false;

        Optional<User> existingUser =
                userDao.findByEmail(email);
        User delegateUser;

        if (existingUser.isPresent()) {
            delegateUser = existingUser.get();
        } else {
            tempPassword = generateTempPassword();
            delegateUser = new User();
            delegateUser.setFullName(fullName);
            delegateUser.setEmail(email);
            delegateUser.setPhone(
                    phone != null && !phone.isEmpty()
                            ? phone : null);
            delegateUser.setPasswordHash(
                    passwordEncoder.encode(tempPassword));
            delegateUser.setActive(true);

            Role delegateRole = getDelegateRole();
            if (delegateRole != null) {
                delegateUser.setRoles(
                        new HashSet<>(Arrays.asList(
                                delegateRole)));
            }

            userDao.save(delegateUser);
            isNewUser = true;
        }

        // Check duplicate registration
        if (registrationDao.existsByConferenceAndUser(
                conferenceId, delegateUser.getId())) {
            errorLog.append("Row ").append(rowNum)
                    .append(": ").append(email)
                    .append(" already registered\n");
            return "FAIL";
        }

        // Create registration
        Registration reg = new Registration();
        reg.setConference(conference);
        reg.setUser(delegateUser);
        reg.setRegistrationNumber(
                generateRegistrationNumber());
        reg.setStatus(RegistrationStatus.CONFIRMED);
        reg.setRegistrationType(RegistrationType.BULK);
        registrationDao.save(reg);



        // Created simulated payment for paid conferences
        try {
            paymentService.createRegistrationPayment(
                    reg, delegateUser, conference);
        } catch (Exception e) {
            System.err.println(
                    "[BulkPayment] Failed for "
                            + email + ": " + e.getMessage());
        }

        // Update seat count
        conference.setRegisteredCount(
                conference.getRegisteredCount() + 1);
        conferenceService.update(conference);

        // In-app notification
        notificationService.createNotification(
                email,
                "Conference Registration",
                "You have been registered for: " +
                        conference.getTitle() +
                        ". Registration No: " +
                        reg.getRegistrationNumber(),
                "IN_APP"
        );

        // Email
        try {
            if (isNewUser) {
                sendBulkWelcomeEmail(
                        email, fullName,
                        conference.getTitle(),
                        reg.getRegistrationNumber(),
                        tempPassword);
            } else {
                emailService.sendRegistrationConfirmation(
                        email, fullName,
                        conference.getTitle(),
                        reg.getRegistrationNumber(),
                        conference.getStartDate()
                                .toString().substring(0, 10),
                        conference.getVenueName() != null
                                ? conference.getVenueName()
                                : conference.getMode().name());
            }
        } catch (Exception e) {
            // Email failure never fails registration
        }

        return "SUCCESS";
    }

    private Role getDelegateRole() {
        try {
            return (Role) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "FROM Role r WHERE r.name = 'DELEGATE'")
                    .uniqueResult();
        } catch (Exception e) {
            return null;
        }
    }

    /*
     * Special welcome email for newly created accounts.
     * Includes their auto-generated temporary password.
     */
    @Autowired(required = false)
    private JavaMailSender mailSender;

    private void sendBulkWelcomeEmail(
            String email,
            String fullName,
            String conferenceName,
            String registrationNumber,
            String tempPassword) {
        if (mailSender == null) return;
        try {
            javax.mail.internet.MimeMessage msg =
                    mailSender.createMimeMessage();
            org.springframework.mail.javamail.MimeMessageHelper
                    helper = new org.springframework.mail.javamail
                    .MimeMessageHelper(msg, true, "UTF-8");
            helper.setTo(email);
            helper.setFrom("noreply@nexmeet.com");
            helper.setSubject(
                    "Welcome to NexMeet - Registered for " +
                            conferenceName);

            String html =
                    "<div style='font-family:Inter,sans-serif;" +
                            "max-width:560px;margin:0 auto'>" +
                            "<div style='background:linear-gradient(" +
                            "135deg,#667eea,#764ba2);" +
                            "padding:28px 32px'>" +
                            "<div style='color:white;font-size:1.4rem;" +
                            "font-weight:800'>NexMeet</div></div>" +
                            "<div style='padding:32px;background:white'>" +
                            "<h2 style='color:#0f172a'>Welcome!</h2>" +
                            "<p style='color:#475569'>Hi <strong>" +
                            fullName + "</strong>,</p>" +
                            "<p style='color:#475569'>You've been " +
                            "registered for <strong>" +
                            conferenceName + "</strong>.</p>" +
                            "<div style='background:#f0f2ff;" +
                            "border:1px solid #c7d2fe;border-radius:8px;" +
                            "padding:16px;margin:12px 0'>" +
                            "<div style='font-size:0.72rem;color:#6366f1;" +
                            "font-weight:600'>REGISTRATION NO.</div>" +
                            "<div style='font-weight:700;color:#0f172a'>" +
                            registrationNumber + "</div></div>" +
                            "<div style='background:#f0fdf4;" +
                            "border:1px solid #bbf7d0;border-radius:8px;" +
                            "padding:16px;margin:12px 0'>" +
                            "<div style='font-size:0.72rem;color:#059669;" +
                            "font-weight:600'>YOUR LOGIN</div>" +
                            "<div style='color:#0f172a;font-size:0.9rem'>" +
                            "Email: <strong>" + email + "</strong><br/>" +
                            "Password: <strong>" + tempPassword +
                            "</strong><br/>" +
                            "<small style='color:#64748b'>Change your " +
                            "password after first login.</small>" +
                            "</div></div></div></div>";

            helper.setText(html, true);
            mailSender.send(msg);
        } catch (Exception e) {
            System.err.println("[BulkUpload] Email failed: "
                    + e.getMessage());
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<com.nexmeet.platform.entity.BulkUpload>
    getUploadHistory(Long conferenceId) {
        return bulkUploadDao.findByConferenceId(
                conferenceId);
    }
}