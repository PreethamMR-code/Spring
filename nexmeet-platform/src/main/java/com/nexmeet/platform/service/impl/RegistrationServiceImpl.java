package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.*;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.QrCode;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.enums.RegistrationType;
import com.nexmeet.platform.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class RegistrationServiceImpl implements RegistrationService {

    /*
     * SLF4J logger for this class.
     * Logback is the implementation (already on classpath
     * via logback-classic in pom.xml).
     * Replaces System.err.println — log entries are:
     *   - timestamped
     *   - level-tagged (ERROR, WARN, INFO, DEBUG)
     *   - filterable without code changes
     *   - writable to file via logback.xml if needed
     */
    private static final Logger log =
            LoggerFactory.getLogger(
                    RegistrationServiceImpl.class);

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private QrCodeDao qrCodeDao;

    @Autowired
    private QrCodeService qrCodeService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private DelegateDao delegateDao;

    @Autowired
    private AuditLogService auditLogService;

    /*
     * Needed to generate the ticket PDF with QR code
     * embedded, so the email attachment matches exactly
     * what the delegate would download from the dashboard.
     */
    @Autowired
    private CertificateService certificateService;

    @Override
    @Transactional
    public String registerForConference(
            Long conferenceId, String userEmail) {

        // 1. Load user and conference
        User user = userDao.findByEmail(userEmail)
                .orElseThrow(() ->
                        new RuntimeException("User not found"));

        Conference conference = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        // 2. Prevent duplicate registration
        if (registrationDao.existsByConferenceAndUser(
                conferenceId, user.getId())) {
            return "ALREADY_REGISTERED";
        }

        /*
         * Profile must be complete before delegate can
         * register for any conference. Delegates who
         * skipped profile setup are blocked here.
         */
        if (!delegateDao.existsByUserEmail(userEmail)) {
            return "PROFILE_INCOMPLETE";
        }

        // 3. Check if registration is open
        if (!conferenceDao.isRegistrationOpen(conferenceId)) {
            return "REGISTRATION_CLOSED";
        }

        // 4. Create registration
        Registration reg = new Registration();
        reg.setConference(conference);
        reg.setUser(user);
        reg.setRegistrationNumber(
                "NM-" + UUID.randomUUID()
                        .toString()
                        .substring(0, 8)
                        .toUpperCase());
        reg.setStatus(RegistrationStatus.CONFIRMED);
        reg.setRegistrationType(RegistrationType.INDIVIDUAL);
        registrationDao.save(reg);

        // Send confirmation email
        try {
            emailService.sendRegistrationConfirmation(
                    user.getEmail(),
                    user.getFullName(),
                    conference.getTitle(),
                    reg.getRegistrationNumber(),
                    conference.getStartDate()
                            .toString().substring(0, 10),
                    conference.getVenueName() != null
                            ? conference.getVenueName()
                            : conference.getMode().name());
        } catch (Exception e) {
            // Email failure never rolls back registration
        }

        try {
            paymentService.createRegistrationPayment(
                    reg, user, conference);
        } catch (Exception e) {
            /*
             * Payment failure never rolls back registration.
             * Logged at ERROR so it appears in logs/console
             * but does not surface to the delegate as a 500.
             */
            log.error("[Payment] Failed to create payment " +
                            "for user {} conference {}: {}",
                    userEmail, conferenceId, e.getMessage());
        }

        // 5. Increment registered count
        conference.setRegisteredCount(
                conference.getRegisteredCount() + 1);
        conferenceDao.update(conference);

        // Generate QR Code
        QrCode qr = new QrCode();
        qr.setRegistration(reg);
        qr.setQrToken(reg.getRegistrationNumber());
        qr.setQrImageBase64(
                qrCodeService.generateQrCodeBase64(
                        reg.getRegistrationNumber()));
        qrCodeDao.save(qr);

        /*
         * Generate ticket PDF with QR code embedded and
         * email as attachment. Must come AFTER QR generation.
         * Failure here must never roll back registration.
         */
        try {
            String qrBase64 = qr.getQrImageBase64();
            ByteArrayOutputStream ticketPdf =
                    certificateService.generateTicket(
                            reg, qrBase64);

            String venueOrMode =
                    conference.getVenueName() != null
                            && !conference.getVenueName().isEmpty()
                            ? conference.getVenueName()
                            : conference.getMode().name();

            emailService.sendTicketEmail(
                    user.getEmail(),
                    user.getFullName(),
                    conference.getTitle(),
                    reg.getRegistrationNumber(),
                    conference.getStartDate()
                            .toString().substring(0, 10),
                    venueOrMode,
                    ticketPdf.toByteArray());

        } catch (Exception e) {
            log.error("[Registration] Ticket email failed " +
                            "for {}: {}",
                    user.getEmail(), e.getMessage());
        }

        // Notify delegate
        notificationService.createNotification(
                userEmail,
                "Registration Confirmed",
                "You have successfully registered for: "
                        + conference.getTitle()
                        + ". Your registration number is "
                        + reg.getRegistrationNumber(),
                "IN_APP");

        // Notify organizer
        notificationService.createNotification(
                conference.getOrganizer()
                        .getUser().getEmail(),
                "New Registration",
                reg.getUser().getFullName()
                        + " has registered for your conference: "
                        + conference.getTitle(),
                "IN_APP");

        try {
            auditLogService.log(
                    userEmail,
                    "DELEGATE_REGISTERED",
                    "Conference",
                    conferenceId,
                    "Reg#: " + reg.getRegistrationNumber());
        } catch (Exception ignored) {}

        return "SUCCESS";
    }

    @Override
    @Transactional(readOnly = true)
    public long countByUserEmail(String email) {
        return registrationDao.countByUserEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Registration> findByUserEmail(String email) {
        return registrationDao.findByUserEmail(email);
    }

    @Override
    @Transactional
    public String cancelRegistration(
            Long registrationId, String userEmail) {

        Optional<Registration> regOpt =
                registrationDao.findById(registrationId);

        if (!regOpt.isPresent()) {
            return "NOT_FOUND";
        }

        Registration reg = regOpt.get();

        // Security check — delegate can only cancel their own
        if (!reg.getUser().getEmail().equals(userEmail)) {
            return "UNAUTHORIZED";
        }

        if (reg.getStatus() == RegistrationStatus.CANCELLED) {
            return "ALREADY_CANCELLED";
        }

        boolean afterDeadline = LocalDateTime.now()
                .isAfter(reg.getConference()
                        .getRegistrationDeadline());

        reg.setStatus(RegistrationStatus.CANCELLED);
        reg.setCancelledAt(LocalDateTime.now());
        registrationDao.cancel(reg);

        try {
            auditLogService.log(
                    userEmail,
                    "DELEGATE_CANCELLED",
                    "Registration",
                    registrationId,
                    "Reg#: " + reg.getRegistrationNumber());
        } catch (Exception ignored) {}

        // Free the seat
        Conference conf = reg.getConference();
        if (conf.getRegisteredCount() > 0) {
            conf.setRegisteredCount(
                    conf.getRegisteredCount() - 1);
            conferenceDao.update(conf);
        }

        return afterDeadline ? "CANCELLED_LATE" : "CANCELLED";
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Registration> findById(Long id) {
        return registrationDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Registration> findByConferenceId(
            Long conferenceId) {
        return registrationDao
                .findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isAlreadyRegistered(
            Long conferenceId, String userEmail) {
        return userDao.findByEmail(userEmail)
                .map(u -> registrationDao
                        .existsByConferenceAndUser(
                                conferenceId, u.getId()))
                .orElse(false);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Registration> findByConferenceAndUserEmail(
            Long conferenceId, String userEmail) {
        return userDao.findByEmail(userEmail)
                .flatMap(u -> registrationDao
                        .findByConferenceAndUser(
                                conferenceId, u.getId()));
    }

    @Override
    @Transactional
    public Registration registerDelegatePostPayment(
            Long conferenceId, String delegateEmail) {

        User user = userDao.findByEmail(delegateEmail)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found: "
                                        + delegateEmail));

        Conference conference = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found: "
                                        + conferenceId));

        /*
         * Duplicate check — idempotency.
         * If Razorpay calls back twice (rare but possible),
         * we must not create two registrations.
         */
        if (registrationDao.existsByConferenceAndUser(
                conferenceId, user.getId())) {
            throw new RuntimeException("ALREADY_REGISTERED");
        }

        if (!delegateDao.existsByUserEmail(delegateEmail)) {
            throw new RuntimeException("PROFILE_INCOMPLETE");
        }

        /*
         * Capacity check — seats may have filled between
         * order creation and payment completion.
         * Known limitation: if this throws, payment is
         * already COMPLETED and no refund is issued.
         * TODO: add Razorpay refund call here.
         */
        if (!conferenceDao.isRegistrationOpen(conferenceId)) {
            throw new RuntimeException("REGISTRATION_CLOSED");
        }

        Registration reg = new Registration();
        reg.setConference(conference);
        reg.setUser(user);
        reg.setRegistrationNumber(
                "NM-" + UUID.randomUUID()
                        .toString()
                        .substring(0, 8)
                        .toUpperCase());
        reg.setStatus(RegistrationStatus.CONFIRMED);
        reg.setRegistrationType(RegistrationType.INDIVIDUAL);
        registrationDao.save(reg);

        /*
         * NO paymentService.createRegistrationPayment() here.
         * The RAZORPAY payment row was already created
         * (status=INITIATED) in createRazorpayOrder() and
         * updated to COMPLETED in verifyAndCompleteRazorpayPayment()
         * before this method is called. Calling it here
         * would create a second SIMULATED payment row and
         * throw a unique constraint violation on transaction_ref.
         */

        // Increment registered count
        conference.setRegisteredCount(
                conference.getRegisteredCount() + 1);
        conferenceDao.update(conference);

        // Generate QR code
        QrCode qr = new QrCode();
        qr.setRegistration(reg);
        qr.setQrToken(reg.getRegistrationNumber());
        qr.setQrImageBase64(
                qrCodeService.generateQrCodeBase64(
                        reg.getRegistrationNumber()));
        qrCodeDao.save(qr);

        /*
         * Send ticket PDF. Must come after QR generation.
         * Failure must NOT roll back — delegate already paid.
         */
        try {
            String qrBase64 = qr.getQrImageBase64();
            ByteArrayOutputStream ticketPdf =
                    certificateService.generateTicket(
                            reg, qrBase64);

            String venueOrMode =
                    conference.getVenueName() != null
                            && !conference.getVenueName().isEmpty()
                            ? conference.getVenueName()
                            : conference.getMode().name();

            emailService.sendTicketEmail(
                    user.getEmail(),
                    user.getFullName(),
                    conference.getTitle(),
                    reg.getRegistrationNumber(),
                    conference.getStartDate()
                            .toString().substring(0, 10),
                    venueOrMode,
                    ticketPdf.toByteArray());

        } catch (Exception e) {
            log.error("[Razorpay] Ticket email failed " +
                            "for {}: {}",
                    user.getEmail(), e.getMessage());
        }

        // Backup text confirmation email
        try {
            emailService.sendRegistrationConfirmation(
                    user.getEmail(),
                    user.getFullName(),
                    conference.getTitle(),
                    reg.getRegistrationNumber(),
                    conference.getStartDate()
                            .toString().substring(0, 10),
                    conference.getVenueName() != null
                            && !conference.getVenueName().isEmpty()
                            ? conference.getVenueName()
                            : conference.getMode().name());
        } catch (Exception e) {
            // Never break registration for email failure
        }

        // In-app notification to delegate
        notificationService.createNotification(
                delegateEmail,
                "Registration Confirmed",
                "Payment received! You are registered for: "
                        + conference.getTitle()
                        + ". Your registration number is "
                        + reg.getRegistrationNumber(),
                "IN_APP");

        // In-app notification to organizer
        notificationService.createNotification(
                conference.getOrganizer()
                        .getUser().getEmail(),
                "New Registration",
                user.getFullName()
                        + " has registered for your conference: "
                        + conference.getTitle(),
                "IN_APP");

        try {
            auditLogService.log(
                    delegateEmail,
                    "DELEGATE_REGISTERED",
                    "Conference",
                    conferenceId,
                    "Reg#: " + reg.getRegistrationNumber()
                            + " | Via: RAZORPAY");
        } catch (Exception ignored) {}

        return reg;
    }
}