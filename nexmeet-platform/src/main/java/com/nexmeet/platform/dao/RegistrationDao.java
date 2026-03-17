package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Registration;

import java.util.List;
import java.util.Optional;

public interface RegistrationDao {

    void save(Registration registration);

    void update(Registration registration);

    Optional<Registration> findById(Long id);

    Optional<Registration> findByRegistrationNumber(String registrationNumber);

    // Check if a user is already registered for a conference
    boolean existsByConferenceAndUser(Long conferenceId, Long userId);

    // All registrations for one conference (organizer view)
    List<Registration> findByConferenceId(Long conferenceId);

    // All registrations by one user (delegate dashboard)
    List<Registration> findByUserId(Long userId);

    long countByUserEmail(String email);

    List<Registration> findByUserEmail(String email);

    void cancel(Registration registration);
}
