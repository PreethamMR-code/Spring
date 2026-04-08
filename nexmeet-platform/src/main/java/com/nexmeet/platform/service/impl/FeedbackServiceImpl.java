package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.*;
import com.nexmeet.platform.dto.FeedbackDto;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.FeedbackService;
import com.nexmeet.platform.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    private FeedbackDao feedbackDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private AttendanceDao attendanceDao;

    @Autowired
    private OrganizerDao organizerDao;

    @Autowired
    private NotificationService notificationService;


    @Override
    public String submitFeedback(FeedbackDto dto, String userEmail) {
        User user = userDao.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Conference conf = conferenceDao.findById(dto.getConferenceId())
                .orElseThrow(() -> new RuntimeException("Conference not found"));

        // Conference must be APPROVED or COMPLETED
        if (conf.getStatus() != ConferenceStatus.APPROVED &&
                conf.getStatus() != ConferenceStatus.COMPLETED) {
            return "CONFERENCE_NOT_ELIGIBLE";
        }

        // Conference end date must have passed
        if (conf.getEndDate().isAfter(LocalDateTime.now())) {
            return "CONFERENCE_NOT_ENDED";
        }

        // Delegate must have been registered
        if (!registrationDao.existsByConferenceAndUser(
                conf.getId(), user.getId())) {
            return "NOT_REGISTERED";
        }

        // Delegate must have attended
        Optional<Registration> regOpt = registrationDao
                .findByConferenceAndUser(conf.getId(), user.getId());

        if (!regOpt.isPresent() ||
                regOpt.get().getStatus() != RegistrationStatus.CONFIRMED) {
            return "NOT_CONFIRMED";
        }

        if (!attendanceDao.existsByRegistrationId(
                regOpt.get().getId())) {
            return "NOT_ATTENDED";
        }

        // Already submitted?
        if (feedbackDao.existsByConferenceAndUser(
                conf.getId(), user.getId())) {
            return "ALREADY_SUBMITTED";
        }

        // Validate rating range
        if (dto.getOverallRating() == null ||
                dto.getOverallRating() < 1 ||
                dto.getOverallRating() > 5) {
            return "INVALID_RATING";
        }


        // Save feedback
        Feedback feedback = new Feedback();
        feedback.setConference(conf);
        feedback.setUser(user);
        feedback.setOverallRating(dto.getOverallRating());
        feedback.setOrganizationRating(dto.getOrganizationRating());
        feedback.setContentRating(dto.getContentRating());
        feedback.setSpeakerRating(dto.getSpeakerRating());
        feedback.setComments(dto.getComments());
        feedback.setPublic(dto.isPublic());
        feedbackDao.save(feedback);

        // Update organizer average rating
        updateOrganizerRating(conf.getOrganizer().getId());

        notificationService.createNotification(
                conf.getOrganizer().getUser().getEmail(),
                "New Feedback Received",
                user.getFullName() + " submitted " +
                        dto.getOverallRating() + "-star feedback for: " +
                        conf.getTitle(),
                "IN_APP"
        );

        return "SUCCESS";
    }

    /*
     * Recalculates and saves the organizer's average rating.
     * Called every time new feedback is submitted.
     */

    private void updateOrganizerRating(Long organizerId) {
        Double avg = feedbackDao.getAverageRatingByOrganizerId(
                organizerId);

        Optional<Organizer> orgOpt = organizerDao
                .findByOrganizerId(organizerId);

        if (orgOpt.isPresent()) {
            Organizer org = orgOpt.get();
            org.setAverageRating(
                    BigDecimal.valueOf(avg)
                            .setScale(2, RoundingMode.HALF_UP));
            organizerDao.update(org);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasSubmittedFeedback(Long conferenceId, String userEmail) {
        User user = userDao.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return feedbackDao.existsByConferenceAndUser(
                conferenceId, user.getId());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Feedback> getPublicFeedback(Long conferenceId) {
        return feedbackDao.findPublicByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Feedback> getAllFeedback(Long conferenceId) {
        return feedbackDao.findAllByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public Double getAverageRating(Long conferenceId) {
        return feedbackDao.getAverageRatingByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public long getFeedbackCount(Long conferenceId) {
        return feedbackDao.countByConferenceId(conferenceId);
    }
}
