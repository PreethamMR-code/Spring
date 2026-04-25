package com.nexmeet.platform.service;

import com.nexmeet.platform.dto.SessionDto;
import com.nexmeet.platform.entity.Session;

import java.util.List;
import java.util.Optional;

public interface SessionService {

    /*
     * Add a session to a conference schedule.
     * Optionally link speakers to this session.
     */
    Session addSession(SessionDto dto, Long conferenceId,
                       String organizerEmail);

    void deleteSession(Long sessionId,
                       String organizerEmail);

    /*
     * Assign an existing conference speaker to a session.
     * This updates Speaker.session_id FK.
     */
    void assignSpeakerToSession(Long speakerId,
                                Long sessionId,
                                String organizerEmail);

    void unassignSpeakerFromSession(Long speakerId,
                                    String organizerEmail);

    List<Session> getSessionsByConference(Long conferenceId);

    Optional<Session> findById(Long id);

}
