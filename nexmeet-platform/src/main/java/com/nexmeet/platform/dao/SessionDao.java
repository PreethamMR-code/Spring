package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Session;

import java.util.List;
import java.util.Optional;

public interface SessionDao {

    void save(Session session);
    void update(Session session);
    void delete(Long id);
    Optional<Session> findById(Long id);
    List<Session> findByConferenceId(Long conferenceId);
}
