package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.util.Collections;
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
        Conference conf = conferenceDao.findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        if (conf.getStatus() != ConferenceStatus.APPROVED) {
            throw new RuntimeException(
                    "Only APPROVED conferences can be completed.");
        }

        conf.setStatus(ConferenceStatus.COMPLETED);
        conferenceDao.update(conf);

        // Notify all confirmed registered delegates
        List<Registration> registrations =
                registrationDao.findByConferenceId(conferenceId);

        for (Registration reg : registrations) {
            if (reg.getStatus() == RegistrationStatus.CONFIRMED) {
                notificationService.createNotification(
                        reg.getUser().getEmail(),
                        "Conference Completed",
                        "\"" + conf.getTitle() + "\" has ended. " +
                                "You can now submit your feedback" +
                                (conf.isCertificateEnabled() ?
                                        " and download your certificate." : "."),
                        "IN_APP"
                );
            }
        }
    }

    @Override
    public void autoCompleteExpiredConferences() {
        /*
         * Find all APPROVED conferences whose end date
         * has already passed and mark them COMPLETED.
         * Called on dashboard load — lightweight check.
         */
        List<Conference> expired = conferenceDao
                .findExpiredApproved();

        for (Conference conf : expired) {
            conf.setStatus(ConferenceStatus.COMPLETED);
            conferenceDao.update(conf);
        }
    }

    @Override
    public void cancelConference(Long conferenceId,
                                 String organizerEmail,
                                 String reason) {
        Conference conf = conferenceDao.findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        // Only APPROVED or SUBMITTED can be cancelled
        if (conf.getStatus() != ConferenceStatus.APPROVED &&
                conf.getStatus() != ConferenceStatus.SUBMITTED) {
            throw new RuntimeException(
                    "Only APPROVED or SUBMITTED conferences " +
                            "can be cancelled.");
        }

        // Set cancelled status
        conf.setStatus(ConferenceStatus.CANCELLED);
        conferenceDao.update(conf);

        // Cancel all confirmed registrations and notify delegates
        List<Registration> registrations =
                registrationDao.findByConferenceId(conferenceId);

        for (Registration reg : registrations) {
            if (reg.getStatus() == RegistrationStatus.CONFIRMED) {
                // Cancel the registration
                reg.setStatus(RegistrationStatus.CANCELLED);
                reg.setCancelledAt(java.time.LocalDateTime.now());
                registrationDao.update(reg);

                // Notify each delegate
                notificationService.createNotification(
                        reg.getUser().getEmail(),
                        "Conference Cancelled",
                        "Unfortunately, \"" + conf.getTitle() +
                                "\" has been cancelled by the organizer." +
                                (reason != null && !reason.trim().isEmpty()
                                        ? " Reason: " + reason : ""),
                        "IN_APP"
                );
            }
        }

        // Reset registered count
        conf.setRegisteredCount(0);
        conferenceDao.update(conf);
    }
}
