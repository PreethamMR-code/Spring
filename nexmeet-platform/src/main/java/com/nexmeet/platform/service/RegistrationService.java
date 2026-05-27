package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Registration;

import java.util.List;
import java.util.Optional;

public interface RegistrationService {


    String registerForConference(Long conferenceId, String userEmail);

    long countByUserEmail(String email);

    List<Registration> findByUserEmail(String email);

    String cancelRegistration(Long registrationId, String userEmail);

    Optional<Registration> findById(Long id);

    List<Registration> findByConferenceId(Long conferenceId);

    // Both methods are @Transactional in the impl.
    // Called from ConferenceController which has no transaction
    // of its own — the service layer owns the transaction boundary.

    boolean isAlreadyRegistered(Long conferenceId, String userEmail);

    Optional<Registration> findByConferenceAndUserEmail(
            Long conferenceId, String userEmail);
}
