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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@org.springframework.transaction.annotation.Transactional
public class ConferenceServiceImpl implements ConferenceService {

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
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public Optional<Conference> findById(Long id) {
        return conferenceDao.findById(id);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getApprovedConferences() {
        return conferenceDao.findAllApproved();
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getPendingConferences() {
        return conferenceDao.findByStatus(ConferenceStatus.SUBMITTED);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getConferencesByOrganizer(Long organizerId) {
        return conferenceDao.findByOrganizerId(organizerId);
    }

    @Override
    public void approveConference(Long conferenceId, String adminEmail) {
        Conference conference = conferenceDao.findById(conferenceId)
                .orElseThrow(() -> new IllegalArgumentException("Conference not found"));

        User admin = userDao.findByEmail(adminEmail)
                .orElseThrow(() -> new IllegalArgumentException("Admin not found"));

        conference.setStatus(ConferenceStatus.APPROVED);
        conference.setApprovedBy(admin);
        conference.setApprovedAt(LocalDateTime.now());
        conference.setRejectionReason(null);

        notificationService.createNotification(
                conference.getOrganizer().getUser().getEmail(),
                "Conference Approved",
                "Your conference \"" + conference.getTitle() +
                        "\" has been approved and is now live!",
                "IN_APP"
        );


        emailService.sendConferenceApproved(
                conference.getOrganizer().getUser().getEmail(),
                conference.getOrganizer().getUser().getFullName(),
                conference.getTitle()
        );

        conferenceDao.update(conference);
    }

    @Override
    public void rejectConference(Long conferenceId, Long adminUserId, String reason) {
        Conference conference = conferenceDao.findById(conferenceId)
                .orElseThrow(() -> new IllegalArgumentException("Conference not found: " + conferenceId));

        conference.setStatus(ConferenceStatus.REJECTED);
        conference.setRejectionReason(reason);

        notificationService.createNotification(
                conference.getOrganizer().getUser().getEmail(),
                "Conference Rejected",
                "Your conference \"" + conference.getTitle() +
                        "\" was rejected. Reason: " + reason,
                "IN_APP"
        );

        emailService.sendConferenceRejected(
                conference.getOrganizer().getUser().getEmail(),
                conference.getOrganizer().getUser().getFullName(),
                conference.getTitle(),
                reason
        );

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
    public long countByOrganizerAndStatus(Long organizerId, ConferenceStatus status) {
        return conferenceDao.countByOrganizerAndStatus(organizerId, status);
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
    public List<Conference> findByStatus(ConferenceStatus conferenceStatus) {
        return conferenceDao.findByStatus(conferenceStatus);
    }

    @Override
    public void update(Conference conf) {
        conferenceDao.update(conf);
    }

    @Override
    public void markAsCompleted(Long conferenceId,
                                String userEmail) {
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
         * has already passed and run the full completion
         * logic for each — including certificate issuance
         * and email notifications.
         *
         * WHY NOT just call markAsCompleted() internally:
         * Internal calls bypass the Spring proxy, and if
         * one conference's Hibernate session gets marked
         * rollback-only, it can poison the whole batch.
         * We handle each conference independently with
         * its own try-catch to isolate failures.
         */
        List<Conference> expired = conferenceDao
                .findExpiredApproved();

        for (Conference conf : expired) {
            try {
                runCompletion(conf);
            } catch (Exception e) {
                System.err.println(
                        "[AutoComplete] Failed for conf "
                                + conf.getId() + " ("
                                + conf.getTitle() + "): "
                                + e.getMessage());
            }
        }
    }

    /*
     * Internal helper — runs the full completion flow
     * for one conference. Called by both
     * autoCompleteExpiredConferences() and
     * markAsCompleted() to avoid duplicating logic.
     */
    private void runCompletion(Conference conf) {
        conf.setStatus(ConferenceStatus.COMPLETED);
        conferenceDao.update(conf);

        List<Registration> registrations =
                registrationDao.findByConferenceId(
                        conf.getId());

        for (Registration reg : registrations) {
            if (reg.getStatus()
                    != RegistrationStatus.CONFIRMED) {
                continue;
            }

            // In-app notification
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
                        "IN_APP"
                );
            } catch (Exception e) {
                System.err.println(
                        "[AutoComplete] Notification "
                                + "failed: " + e.getMessage());
            }

            // Certificate — only for attended delegates
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
                    System.err.println(
                            "[AutoComplete] Certificate "
                                    + "failed for "
                                    + reg.getUser().getEmail()
                                    + ": " + e.getMessage());
                }
            } else if (!conf.isCertificateEnabled()) {
                // No certs — send completion email only
                try {
                    emailService.sendConferenceCompleted(
                            reg.getUser().getEmail(),
                            reg.getUser().getFullName(),
                            conf.getTitle()
                    );
                } catch (Exception e) {
                    System.err.println(
                            "[AutoComplete] Completion "
                                    + "email failed: "
                                    + e.getMessage());
                }
            }
        }
    }

    @Override
    public void cancelConference(Long conferenceId,
                                 String organizerEmail,
                                 String reason) {
        Conference conf = conferenceDao.findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        if (conf.getStatus() != ConferenceStatus.APPROVED &&
                conf.getStatus() != ConferenceStatus.SUBMITTED) {
            throw new RuntimeException(
                    "Only APPROVED or SUBMITTED conferences " +
                            "can be cancelled.");
        }

        conf.setStatus(ConferenceStatus.CANCELLED);
        conferenceDao.update(conf);

        List<Registration> registrations =
                registrationDao.findByConferenceId(conferenceId);

        for (Registration reg : registrations) {
            if (reg.getStatus() == RegistrationStatus.CONFIRMED) {
                reg.setStatus(RegistrationStatus.CANCELLED);
                reg.setCancelledAt(java.time.LocalDateTime.now());
                registrationDao.update(reg);

                notificationService.createNotification(
                        reg.getUser().getEmail(),
                        "Conference Cancelled",
                        "Unfortunately, \"" + conf.getTitle() +
                                "\" has been cancelled by the organizer." +
                                (reason != null && !reason.trim().isEmpty()
                                        ? " Reason: " + reason : ""),
                        "IN_APP"
                );
                // FIX: was registration.getUser() and conference.getTitle()
                emailService.sendConferenceCancelled(
                        reg.getUser().getEmail(),
                        reg.getUser().getFullName(),
                        conf.getTitle(),
                        reason
                );
            }
        }

        conf.setRegisteredCount(0);
        conferenceDao.update(conf);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getUpcomingConferences(int limit) {
        /*
         * Upcoming = APPROVED status + startDate in future.
         * Ordered by startDate ASC — soonest conference first.
         * Limit prevents loading all conferences on home page.
         */
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
                    "Certificate not enabled "
                            + "for this conference.");
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
                continue; // didn't attend
            }
            // issueCertificate() is idempotent —
            // returns existing cert if already issued
            try {
                com.nexmeet.platform.entity.Certificate
                        cert = certificateService
                        .issueCertificate(reg);
                if (cert != null) issued++;
            } catch (Exception e) {
                skipped++;
                System.err.println(
                        "[Reissue] Failed for "
                                + reg.getUser().getEmail()
                                + ": " + e.getMessage());
            }
        }

        System.out.println(
                "[Reissue] Conf " + conferenceId
                        + ": " + issued + " issued, "
                        + skipped + " failed.");
    }
}
