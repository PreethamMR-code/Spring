package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Conference;

import java.util.List;
import java.util.Optional;

public interface ConferenceService {

    Optional<Conference> findById(Long id);

    // Public listing page — only APPROVED
    List<Conference> getApprovedConferences();

    // Admin: get conferences pending review
    List<Conference> getPendingConferences();

    // Organizer: their own conferences
    List<Conference> getConferencesByOrganizer(Long organizerId);

    // Admin approves a conference
    void approveConference(Long conferenceId, Long adminUserId);

    // Admin rejects with reason
    void rejectConference(Long conferenceId, Long adminUserId, String reason);

    void save(Conference conference);
}
