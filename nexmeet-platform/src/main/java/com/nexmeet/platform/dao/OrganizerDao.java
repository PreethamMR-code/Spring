package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Organizer;

import java.util.List;
import java.util.Optional;

public interface OrganizerDao {

    Optional<Organizer> findByUserEmail(String email);

    void save(Organizer organizer);

    boolean existsByUserEmail(String email);

    void update(Organizer organizer);

    Optional<Organizer> findByOrganizerId(Long organizerId);

    List<Organizer> findByVerificationStatus(
            com.nexmeet.platform.enums.VerificationStatus status);
}
