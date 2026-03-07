package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Organizer;

import java.util.Optional;

public interface OrganizerDao {

    Optional<Organizer> findByUserEmail(String email);
}
