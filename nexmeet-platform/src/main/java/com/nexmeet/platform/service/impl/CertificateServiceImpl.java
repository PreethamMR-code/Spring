package com.nexmeet.platform.service.impl;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.nexmeet.platform.dao.CertificateDao;
import com.nexmeet.platform.entity.Certificate;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.service.AuditLogService;
import com.nexmeet.platform.service.CertificateService;
import com.nexmeet.platform.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.Random;

@Service
public class CertificateServiceImpl implements CertificateService {

    @Autowired
    private CertificateDao certificateDao;

    @Autowired
    private AuditLogService auditLogService;

    /*
     * required=false — if EmailService is unavailable
     * (e.g. SMTP misconfigured), certificate is still
     * issued and saved. Email failure never blocks this.
     */
    @Autowired(required = false)
    private EmailService emailService;

    // ────────────────────────────────────────────────
    // TICKET GENERATION — unchanged from original
    // ────────────────────────────────────────────────

    @Override
    public ByteArrayOutputStream generateTicket(
            Registration registration,
            String qrBase64) {
        ByteArrayOutputStream baos =
                new ByteArrayOutputStream();
        try {
            Document document =
                    new Document(PageSize.A5);
            PdfWriter writer =
                    PdfWriter.getInstance(
                            document, baos);
            document.open();

            PdfContentByte canvas =
                    writer.getDirectContent();

            canvas.setColorStroke(
                    new BaseColor(0, 102, 204));
            canvas.setLineWidth(6f);
            canvas.rectangle(15, 15,
                    document.getPageSize().getWidth()
                            - 30,
                    document.getPageSize().getHeight()
                            - 30);
            canvas.stroke();

            Font platformFont = new Font(
                    Font.FontFamily.HELVETICA, 10,
                    Font.BOLD,
                    new BaseColor(0, 102, 204));
            Font titleFont = new Font(
                    Font.FontFamily.HELVETICA, 16,
                    Font.BOLD, BaseColor.BLACK);
            Font labelFont = new Font(
                    Font.FontFamily.HELVETICA, 9,
                    Font.BOLD, BaseColor.GRAY);
            Font valueFont = new Font(
                    Font.FontFamily.HELVETICA, 11,
                    Font.NORMAL, BaseColor.BLACK);
            Font footerFont = new Font(
                    Font.FontFamily.HELVETICA, 8,
                    Font.ITALIC, BaseColor.GRAY);
            Font warningFont = new Font(
                    Font.FontFamily.HELVETICA, 9,
                    Font.BOLD,
                    new BaseColor(200, 0, 0));

            Paragraph platform = new Paragraph(
                    "NexMeet Conference Platform",
                    platformFont);
            platform.setAlignment(
                    Element.ALIGN_CENTER);
            platform.setSpacingBefore(15);
            document.add(platform);

            document.add(new Chunk(
                    new LineSeparator(1f, 100f,
                            new BaseColor(0, 102, 204),
                            Element.ALIGN_CENTER, -2)));

            Paragraph confTitle = new Paragraph(
                    registration.getConference()
                            .getTitle(),
                    titleFont);
            confTitle.setAlignment(
                    Element.ALIGN_CENTER);
            confTitle.setSpacingBefore(10);
            confTitle.setSpacingAfter(10);
            document.add(confTitle);

            if (qrBase64 != null
                    && !qrBase64.isEmpty()) {
                byte[] qrBytes =
                        java.util.Base64
                                .getDecoder()
                                .decode(qrBase64);
                Image qrImage =
                        Image.getInstance(qrBytes);
                qrImage.scaleAbsolute(180, 180);
                qrImage.setAlignment(
                        Element.ALIGN_CENTER);
                document.add(qrImage);
            }

            Paragraph regNo = new Paragraph(
                    registration.getRegistrationNumber(),
                    titleFont);
            regNo.setAlignment(Element.ALIGN_CENTER);
            regNo.setSpacingBefore(5);
            document.add(regNo);

            document.add(new Chunk(
                    new LineSeparator(1f, 90f,
                            BaseColor.LIGHT_GRAY,
                            Element.ALIGN_CENTER, -2)));

            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(90);
            table.setSpacingBefore(10);
            table.setWidths(new float[]{35f, 65f});

            addTicketRow(table, "Delegate",
                    registration.getUser()
                            .getFullName(),
                    labelFont, valueFont);
            addTicketRow(table, "Date",
                    registration.getConference()
                            .getStartDate().format(
                                    DateTimeFormatter.ofPattern(
                                            "dd MMM yyyy, hh:mm a")),
                    labelFont, valueFont);

            String venue =
                    registration.getConference()
                            .getVenueName() != null
                            ? registration.getConference()
                            .getVenueName()
                            : "Online";
            addTicketRow(table, "Venue",
                    venue, labelFont, valueFont);

            String address = "";
            if (registration.getConference()
                    .getVenueAddress() != null) {
                address = registration.getConference()
                        .getVenueAddress();
            }
            if (registration.getConference()
                    .getCity() != null) {
                address += ", "
                        + registration.getConference()
                        .getCity();
            }
            if (registration.getConference()
                    .getState() != null) {
                address += ", "
                        + registration.getConference()
                        .getState();
            }
            if (!address.isEmpty()) {
                addTicketRow(table, "Address",
                        address, labelFont,
                        valueFont);
            }

            addTicketRow(table, "Mode",
                    registration.getConference()
                            .getMode().toString(),
                    labelFont, valueFont);
            addTicketRow(table, "Organizer",
                    registration.getConference()
                            .getOrganizer()
                            .getOrganizationName(),
                    labelFont, valueFont);

            String fee =
                    registration.getConference()
                            .isFree()
                            ? "Free"
                            : "₹" + registration
                            .getConference()
                            .getDelegateFee();
            addTicketRow(table, "Entry Fee",
                    fee, labelFont, valueFont);

            document.add(table);

            Paragraph warning = new Paragraph(
                    "Valid for one entry only. " +
                            "Show this ticket at the entrance.",
                    warningFont);
            warning.setAlignment(
                    Element.ALIGN_CENTER);
            warning.setSpacingBefore(10);
            document.add(warning);

            Paragraph footer = new Paragraph(
                    "Generated by NexMeet · " +
                            "nexmeet.com", footerFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

        } catch (Exception e) {
            throw new RuntimeException(
                    "Ticket generation failed: "
                            + e.getMessage());
        }
        return baos;
    }

    private void addTicketRow(PdfPTable table,
                              String label, String value,
                              Font labelFont, Font valueFont) {
        PdfPCell labelCell = new PdfPCell(
                new Phrase(label, labelFont));
        labelCell.setBorder(Rectangle.BOTTOM);
        labelCell.setBorderColor(
                BaseColor.LIGHT_GRAY);
        labelCell.setPadding(5);
        table.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(
                new Phrase(value, valueFont));
        valueCell.setBorder(Rectangle.BOTTOM);
        valueCell.setBorderColor(
                BaseColor.LIGHT_GRAY);
        valueCell.setPadding(5);
        table.addCell(valueCell);
    }

    // ────────────────────────────────────────────────
    // CERTIFICATE GENERATION — now with cert number
    // ────────────────────────────────────────────────

    /*
     * Backward compatibility — called when no
     * certificate record exists yet (on-the-fly).
     */
    @Override
    public ByteArrayOutputStream generateCertificate(
            Registration registration) {
        return generateCertificate(
                registration, "NM-CERT-PREVIEW");
    }

    /*
     * Primary method — certificate number is printed
     * on the PDF so every download is consistent.
     */
    @Override
    public ByteArrayOutputStream generateCertificate(
            Registration registration,
            String certificateNumber) {
        ByteArrayOutputStream baos =
                new ByteArrayOutputStream();
        try {
            Document document = new Document(
                    PageSize.A4.rotate());
            PdfWriter writer =
                    PdfWriter.getInstance(
                            document, baos);
            document.open();

            PdfContentByte canvas =
                    writer.getDirectContent();

            canvas.setColorStroke(
                    new BaseColor(34, 139, 34));
            canvas.setLineWidth(8f);
            canvas.rectangle(20, 20,
                    document.getPageSize().getWidth()
                            - 40,
                    document.getPageSize().getHeight()
                            - 40);
            canvas.stroke();

            canvas.setColorStroke(
                    new BaseColor(144, 238, 144));
            canvas.setLineWidth(2f);
            canvas.rectangle(30, 30,
                    document.getPageSize().getWidth()
                            - 60,
                    document.getPageSize().getHeight()
                            - 60);
            canvas.stroke();

            Font titleFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 42,
                    Font.BOLD,
                    new BaseColor(34, 139, 34));
            Font subtitleFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 18,
                    Font.ITALIC, BaseColor.DARK_GRAY);
            Font nameFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 36,
                    Font.BOLD,
                    new BaseColor(0, 100, 0));
            Font bodyFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 16,
                    Font.NORMAL, BaseColor.BLACK);
            Font conferenceFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 20,
                    Font.BOLD | Font.ITALIC,
                    new BaseColor(34, 139, 34));
            Font smallFont = new Font(
                    Font.FontFamily.TIMES_ROMAN, 12,
                    Font.NORMAL, BaseColor.GRAY);
            Font certNumFont = new Font(
                    Font.FontFamily.HELVETICA, 10,
                    Font.BOLD,
                    new BaseColor(102, 126, 234));

            Paragraph title = new Paragraph(
                    "Certificate of Participation",
                    titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingBefore(50);
            document.add(title);

            Paragraph subtitle = new Paragraph(
                    "This is to certify that",
                    subtitleFont);
            subtitle.setAlignment(
                    Element.ALIGN_CENTER);
            subtitle.setSpacingBefore(20);
            document.add(subtitle);

            Paragraph name = new Paragraph(
                    registration.getUser()
                            .getFullName(),
                    nameFont);
            name.setAlignment(Element.ALIGN_CENTER);
            name.setSpacingBefore(15);
            document.add(name);

            LineSeparator line =
                    new LineSeparator();
            line.setLineColor(
                    new BaseColor(34, 139, 34));
            line.setLineWidth(1f);
            line.setPercentage(50f);
            document.add(new Chunk(line));

            Paragraph body = new Paragraph(
                    "has successfully participated " +
                            "in the conference",
                    bodyFont);
            body.setAlignment(Element.ALIGN_CENTER);
            body.setSpacingBefore(20);
            document.add(body);

            Paragraph confTitle = new Paragraph(
                    registration.getConference()
                            .getTitle(),
                    conferenceFont);
            confTitle.setAlignment(
                    Element.ALIGN_CENTER);
            confTitle.setSpacingBefore(10);
            document.add(confTitle);

            String startDate =
                    registration.getConference()
                            .getStartDate().format(
                                    DateTimeFormatter.ofPattern(
                                            "dd MMMM yyyy"));
            String city =
                    registration.getConference()
                            .getCity() != null
                            ? registration.getConference()
                            .getCity() : "";
            String state =
                    registration.getConference()
                            .getState() != null
                            ? registration.getConference()
                            .getState() : "";

            Paragraph datePlace = new Paragraph(
                    "Held on " + startDate +
                            (city.isEmpty() ? ""
                                    : "  |  " + city
                                    + (state.isEmpty() ? ""
                                    : ", " + state)),
                    bodyFont);
            datePlace.setAlignment(
                    Element.ALIGN_CENTER);
            datePlace.setSpacingBefore(10);
            document.add(datePlace);

            Paragraph organizer = new Paragraph(
                    "Organized by: " +
                            registration.getConference()
                                    .getOrganizer()
                                    .getOrganizationName(),
                    bodyFont);
            organizer.setAlignment(
                    Element.ALIGN_CENTER);
            organizer.setSpacingBefore(10);
            document.add(organizer);

            // Certificate number — unique ID
            Paragraph certNum = new Paragraph(
                    "Certificate No: "
                            + certificateNumber,
                    certNumFont);
            certNum.setAlignment(
                    Element.ALIGN_CENTER);
            certNum.setSpacingBefore(28);
            document.add(certNum);

            // Reg number in small text
            Paragraph regNum = new Paragraph(
                    "Registration No: " +
                            registration
                                    .getRegistrationNumber(),
                    smallFont);
            regNum.setAlignment(
                    Element.ALIGN_CENTER);
            regNum.setSpacingBefore(4);
            document.add(regNum);

            document.add(new Chunk(
                    new LineSeparator()));

            Paragraph footer = new Paragraph(
                    "NexMeet Conference Platform  " +
                            "· nexmeet.com",
                    smallFont);
            footer.setAlignment(
                    Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

        } catch (DocumentException e) {
            throw new RuntimeException(
                    "Certificate generation failed: "
                            + e.getMessage());
        }
        return baos;
    }

    // ────────────────────────────────────────────────
    // ISSUE CERTIFICATE — the main Phase 44 method
    // ────────────────────────────────────────────────

    @Override
    @Transactional
    public Certificate issueCertificate(
            Registration registration) {

        Long regId = registration.getId();

        /*
         * Idempotent — if already issued, return
         * existing record. Safe to call multiple times.
         */
        if (certificateDao
                .existsByRegistrationId(regId)) {
            return certificateDao
                    .findByRegistrationId(regId)
                    .orElse(null);
        }

        // Generate unique certificate number
        String certNumber = generateCertNumber();

        // Generate PDF with the cert number
        ByteArrayOutputStream pdf =
                generateCertificate(
                        registration, certNumber);

        // Save Certificate record to DB
        Certificate cert = new Certificate();
        cert.setRegistration(registration);
        cert.setConference(
                registration.getConference());
        cert.setUser(registration.getUser());
        cert.setCertificateNumber(certNumber);
        // file_path: null — in-memory generation
        cert.setFilePath(null);
        certificateDao.save(cert);

        try {
            auditLogService.logSystem(
                    "CERTIFICATE_ISSUED",
                    "Certificate",
                    cert.getId(),
                    "Cert#: " + certNumber
                            + " | Delegate: "
                            + registration.getUser().getEmail()
                            + " | Conf: "
                            + registration.getConference()
                            .getTitle());
        } catch (Exception ignored) {}



        // Email the PDF to the delegate
        if (emailService != null) {
            try {
                emailService.sendCertificateEmail(
                        registration.getUser()
                                .getEmail(),
                        registration.getUser()
                                .getFullName(),
                        registration.getConference()
                                .getTitle(),
                        certNumber,
                        pdf.toByteArray()
                );
            } catch (Exception e) {
                // Email failure never blocks issuance
                System.err.println(
                        "[Certificate] Email failed "
                                + "for "
                                + registration.getUser()
                                .getEmail()
                                + ": " + e.getMessage());
            }
        }

        return cert;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Certificate> getCertificateRecord(
            Long registrationId) {
        return certificateDao
                .findByRegistrationId(registrationId);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isCertificateIssued(
            Long registrationId) {
        return certificateDao
                .existsByRegistrationId(
                        registrationId);
    }

    /*
     * Unique certificate number.
     * Format: NM-CERT-2026-A3F7K2
     * Year + 6 random uppercase alphanumeric chars.
     */
    private String generateCertNumber() {
        int year = Year.now().getValue();
        String chars =
                "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            sb.append(
                    chars.charAt(
                            rnd.nextInt(chars.length())));
        }
        return "NM-CERT-" + year + "-"
                + sb.toString();
    }
}