package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.enums.ConferenceStatus;

import java.util.List;
import java.util.Optional;

public interface ConferenceDao {

    void save(Conference conference);

    void update(Conference conference);

    Optional<Conference> findById(Long id);

    // Public listing — only APPROVED conferences
    List<Conference> findAllApproved();

    // Admin view — conferences by status
    List<Conference> findByStatus(ConferenceStatus status);

    // Organizer's own conferences
    List<Conference> findByOrganizerId(Long organizerId);

    // For registration — check if conference is open
    boolean isRegistrationOpen(Long conferenceId);

    long countByOrganizer(Long organizerId);

    long countByOrganizerAndStatus(Long organizerId, ConferenceStatus status);
}
