package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ConferenceServiceImpl
        implements ConferenceService {

    /*
     * SLF4J logger backed by Logback (already on classpath).
     * Replaces all System.out.println and System.err.println.
     * Log levels used:
     *   INFO  — normal flow events (scheduler ran, conf completed)
     *   WARN  — recoverable issues (notification failed)
     *   ERROR — failures that need investigation (cert failed)
     */
    private static final Logger log =
            LoggerFactory.getLogger(
                    ConferenceServiceImpl.class);

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private EmailService emailService;

    @Autowired
    private CertificateService certificateService;

    @Autowired
    private AttendanceService attendanceService;

    @Override
    @Transactional(readOnly = true)
    public Optional<Conference> findById(Long id) {
        return conferenceDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getApprovedConferences() {
        return conferenceDao.findAllApproved();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getPendingConferences() {
        return conferenceDao
                .findByStatus(ConferenceStatus.SUBMITTED);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getConferencesByOrganizer(
            Long organizerId) {
        return conferenceDao
                .findByOrganizerId(organizerId);
    }

    @Override
    public void approveConference(
            Long conferenceId, String adminEmail) {

        Conference conference = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Conference not found"));

        User admin = userDao.findByEmail(adminEmail)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Admin not found"));

        conference.setStatus(ConferenceStatus.APPROVED);
        conference.setApprovedBy(admin);
        conference.setApprovedAt(LocalDateTime.now());
        conference.setRejectionReason(null);

        notificationService.createNotification(
                conference.getOrganizer()
                        .getUser().getEmail(),
                "Conference Approved",
                "Your conference \""
                        + conference.getTitle()
                        + "\" has been approved and is now live!",
                "IN_APP");

        emailService.sendConferenceApproved(
                conference.getOrganizer()
                        .getUser().getEmail(),
                conference.getOrganizer()
                        .getUser().getFullName(),
                conference.getTitle());

        conferenceDao.update(conference);
    }

    @Override
    public void rejectConference(
            Long conferenceId,
            Long adminUserId,
            String reason) {

        Conference conference = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Conference not found: "
                                        + conferenceId));

        conference.setStatus(ConferenceStatus.REJECTED);
        conference.setRejectionReason(reason);

        notificationService.createNotification(
                conference.getOrganizer()
                        .getUser().getEmail(),
                "Conference Rejected",
                "Your conference \""
                        + conference.getTitle()
                        + "\" was rejected. Reason: " + reason,
                "IN_APP");

        emailService.sendConferenceRejected(
                conference.getOrganizer()
                        .getUser().getEmail(),
                conference.getOrganizer()
                        .getUser().getFullName(),
                conference.getTitle(),
                reason);

        conferenceDao.update(conference);
    }

    @Override
    @Transactional
    public void save(Conference conference) {
        conferenceDao.save(conference);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByOrganizer(Long organizerId) {
        return conferenceDao.countByOrganizer(organizerId);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByOrganizerAndStatus(
            Long organizerId, ConferenceStatus status) {
        return conferenceDao
                .countByOrganizerAndStatus(
                        organizerId, status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getAllConferences() {
        return conferenceDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countByStatus(ConferenceStatus status) {
        return conferenceDao.countByStatus(status);
    }

    @Override
    public List<Conference> findByStatus(
            ConferenceStatus conferenceStatus) {
        return conferenceDao.findByStatus(conferenceStatus);
    }

    @Override
    @Transactional
    public void update(Conference conf) {
        conferenceDao.update(conf);
    }

    @Override
    public void markAsCompleted(
            Long conferenceId, String userEmail) {

        Conference conf = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found"));

        if (conf.getStatus()
                != ConferenceStatus.APPROVED) {
            throw new RuntimeException(
                    "Only APPROVED conferences "
                            + "can be completed.");
        }

        /*
         * Delegate to the same helper used by
         * autoCompleteExpiredConferences() —
         * single place for all completion logic.
         */
        runCompletion(conf);
    }

    @Override
    public void autoCompleteExpiredConferences() {
        /*
         * Find all APPROVED conferences whose end date
         * has already passed. Each is completed in its
         * own try-catch so one failure doesn't abort
         * the rest of the batch.
         *
         * Called by:
         *   1. ConferenceAutoCompletionScheduler — hourly
         *   2. Admin/organizer dashboard load — on demand
         */
        List<Conference> expired =
                conferenceDao.findExpiredApproved();

        if (expired.isEmpty()) {
            log.info("[AutoComplete] No expired " +
                    "conferences to process");
            return;
        }

        log.info("[AutoComplete] Found {} expired " +
                        "conference(s) to complete",
                expired.size());

        for (Conference conf : expired) {
            try {
                runCompletion(conf);
                log.info("[AutoComplete] Completed " +
                                "conference {} ({})",
                        conf.getId(), conf.getTitle());
            } catch (Exception e) {
                log.error("[AutoComplete] Failed for " +
                                "conference {} ({}): {}",
                        conf.getId(),
                        conf.getTitle(),
                        e.getMessage());
            }
        }
    }

    /*
     * Internal helper — runs the full completion flow
     * for one conference. Called by both
     * autoCompleteExpiredConferences() and
     * markAsCompleted() to avoid duplicating logic.
     *
     * Completion flow per confirmed registration:
     *   1. In-app notification
     *   2. Certificate issuance (if enabled + attended)
     *   3. Completion email (if certificates not enabled)
     */
    private void runCompletion(Conference conf) {
        conf.setStatus(ConferenceStatus.COMPLETED);
        conf.setUpdatedAt(LocalDateTime.now());
        conferenceDao.update(conf);

        List<Registration> registrations =
                registrationDao.findByConferenceId(
                        conf.getId());

        for (Registration reg : registrations) {
            if (reg.getStatus()
                    != RegistrationStatus.CONFIRMED) {
                continue;
            }

            // In-app notification to each delegate
            try {
                notificationService.createNotification(
                        reg.getUser().getEmail(),
                        "Conference Completed",
                        "\"" + conf.getTitle()
                                + "\" has ended. "
                                + (conf.isCertificateEnabled()
                                ? "Your certificate is being "
                                + "issued and will arrive "
                                + "by email."
                                : "You can now submit "
                                + "feedback."),
                        "IN_APP");
            } catch (Exception e) {
                log.warn("[AutoComplete] Notification " +
                                "failed for {}: {}",
                        reg.getUser().getEmail(),
                        e.getMessage());
            }

            // Certificate issuance for attended delegates
            if (conf.isCertificateEnabled()
                    && attendanceService
                    .hasAttended(reg.getId())) {
                try {
                    certificateService
                            .issueCertificate(reg);
                    /*
                     * Email is sent inside
                     * issueCertificate() — do not
                     * send separately here.
                     */
                } catch (Exception e) {
                    log.error("[AutoComplete] Certificate " +
                                    "failed for {}: {}",
                            reg.getUser().getEmail(),
                            e.getMessage());
                }
            } else if (!conf.isCertificateEnabled()) {
                // No certs — send completion email only
                try {
                    emailService.sendConferenceCompleted(
                            reg.getUser().getEmail(),
                            reg.getUser().getFullName(),
                            conf.getTitle());
                } catch (Exception e) {
                    log.warn("[AutoComplete] Completion " +
                                    "email failed for {}: {}",
                            reg.getUser().getEmail(),
                            e.getMessage());
                }
            }
        }
    }

    @Override
    public void cancelConference(
            Long conferenceId,
            String organizerEmail,
            String reason) {

        Conference conf = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found"));

        if (conf.getStatus() != ConferenceStatus.APPROVED
                && conf.getStatus()
                != ConferenceStatus.SUBMITTED) {
            throw new RuntimeException(
                    "Only APPROVED or SUBMITTED " +
                            "conferences can be cancelled.");
        }

        conf.setStatus(ConferenceStatus.CANCELLED);
        conferenceDao.update(conf);

        List<Registration> registrations =
                registrationDao.findByConferenceId(
                        conferenceId);

        for (Registration reg : registrations) {
            if (reg.getStatus()
                    == RegistrationStatus.CONFIRMED) {

                reg.setStatus(
                        RegistrationStatus.CANCELLED);
                reg.setCancelledAt(LocalDateTime.now());
                registrationDao.update(reg);

                notificationService.createNotification(
                        reg.getUser().getEmail(),
                        "Conference Cancelled",
                        "Unfortunately, \""
                                + conf.getTitle()
                                + "\" has been cancelled by "
                                + "the organizer."
                                + (reason != null
                                && !reason.trim().isEmpty()
                                ? " Reason: " + reason
                                : ""),
                        "IN_APP");

                emailService.sendConferenceCancelled(
                        reg.getUser().getEmail(),
                        reg.getUser().getFullName(),
                        conf.getTitle(),
                        reason);
            }
        }

        conf.setRegisteredCount(0);
        conferenceDao.update(conf);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getUpcomingConferences(
            int limit) {
        return conferenceDao.findUpcoming(limit);
    }

    @Override
    @Transactional
    public void reissueMissingCertificates(
            Long conferenceId) {

        Conference conf = conferenceDao
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Conference not found"));

        if (!conf.isCertificateEnabled()) {
            throw new RuntimeException(
                    "Certificate not enabled " +
                            "for this conference.");
        }

        List<Registration> registrations =
                registrationDao.findByConferenceId(
                        conferenceId);

        int issued = 0;
        int skipped = 0;

        for (Registration reg : registrations) {
            if (reg.getStatus()
                    != RegistrationStatus.CONFIRMED) {
                continue;
            }
            if (!attendanceService
                    .hasAttended(reg.getId())) {
                continue;
            }
            /*
             * issueCertificate() is idempotent —
             * returns existing cert if already issued.
             */
            try {
                com.nexmeet.platform.entity.Certificate
                        cert = certificateService
                        .issueCertificate(reg);
                if (cert != null) issued++;
            } catch (Exception e) {
                skipped++;
                log.error("[Reissue] Failed for {}: {}",
                        reg.getUser().getEmail(),
                        e.getMessage());
            }
        }

        log.info("[Reissue] Conference {}: {} issued, " +
                        "{} failed",
                conferenceId, issued, skipped);
    }
}