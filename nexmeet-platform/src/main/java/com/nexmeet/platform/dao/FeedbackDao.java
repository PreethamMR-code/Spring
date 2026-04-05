package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Feedback;

import java.util.List;
import java.util.Optional;

public interface FeedbackDao {

    void save(Feedback feedback);

    // Check if delegate already submitted feedback for this conference
    boolean existsByConferenceAndUser(Long conferenceId, Long userId);

    // All public feedback for a conference (for public detail page)
    List<Feedback> findPublicByConferenceId(Long conferenceId);

    // All feedback for a conference (organizer view)
    List<Feedback> findAllByConferenceId(Long conferenceId);

    // Average overall rating for a conference
    Double getAverageRatingByConferenceId(Long conferenceId);

    // Average overall rating for an organizer (across all conferences)
    Double getAverageRatingByOrganizerId(Long organizerId);

    // Feedback count for a conference
    long countByConferenceId(Long conferenceId);

    // Find single feedback by conference and user
    Optional<Feedback> findByConferenceAndUser(Long conferenceId,
                                               Long userId);


}
