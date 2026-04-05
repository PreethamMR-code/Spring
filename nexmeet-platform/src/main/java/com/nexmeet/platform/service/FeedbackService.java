package com.nexmeet.platform.service;

import com.nexmeet.platform.dto.FeedbackDto;
import com.nexmeet.platform.entity.Feedback;

import java.util.List;

public interface FeedbackService {

    // Delegate submits feedback
    String submitFeedback(FeedbackDto dto, String userEmail);

    // Check if delegate already submitted
    boolean hasSubmittedFeedback(Long conferenceId, String userEmail);

    // Public feedback for conference detail page
    List<Feedback> getPublicFeedback(Long conferenceId);

    // All feedback for organizer view
    List<Feedback> getAllFeedback(Long conferenceId);

    // Average rating for a conference
    Double getAverageRating(Long conferenceId);

    // Feedback count for a conference
    long getFeedbackCount(Long conferenceId);


}
