package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Organizer;

import java.util.Optional;

public interface OrganizerDao {

    Optional<Organizer> findByUserEmail(String email);

    void save(Organizer organizer);

    boolean existsByUserEmail(String email);

    void update(Organizer organizer);

    Optional<Organizer> findByOrganizerId(Long organizerId);
}
