package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Speaker;

import java.util.List;
import java.util.Optional;

public interface SpeakerDao {

    void save(Speaker speaker);

    void update(Speaker speaker);

    void delete(Long id);

    Optional<Speaker> findById(Long id);

    List<Speaker> findByConferenceId(Long conferenceId);

    /*
     * Find speakers assigned to a specific session.
     * Used when building schedule view.
     */
    List<Speaker> findBySessionId(Long sessionId);

}
