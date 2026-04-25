package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.SpeakerDao;
import com.nexmeet.platform.dto.SessionDto;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Session;
import com.nexmeet.platform.entity.Speaker;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class SessionServiceImpl implements SessionService {

    @Autowired
    private SpeakerDao sessionDao;

    @Autowired
    private SpeakerDao speakerDao;

    @Autowired
    private ConferenceService conferenceService;

    @Override
    public Session addSession(SessionDto dto,
                              Long conferenceId,
                              String organizerEmail) {
        Conference conf = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        // Security check
        if (!conf.getOrganizer().getUser()
                .getEmail().equals(organizerEmail)) {
            throw new RuntimeException(
                    "Unauthorized — not your conference");
        }

        Session session = new Session();
        session.setConference(conf);
        session.setTitle(dto.getTitle());
        session.setDescription(dto.getDescription());
        session.setSessionType(dto.getSessionType() != null
                ? dto.getSessionType() : "PRESENTATION");
        session.setRoomOrLink(dto.getRoomOrLink());
        session.setCapacity(dto.getCapacity());

        // Parse datetime-local string format:
        // "2026-06-10T09:00" -> LocalDateTime
        if (dto.getStartTime() != null &&
                !dto.getStartTime().isEmpty()) {
            session.setStartTime(
                    LocalDateTime.parse(dto.getStartTime()));
        }
        if (dto.getEndTime() != null &&
                !dto.getEndTime().isEmpty()) {
            session.setEndTime(
                    LocalDateTime.parse(dto.getEndTime()));
        }

        sessionDao.save(session);
        return session;
    }

    @Override
    public void deleteSession(Long sessionId,
                              String organizerEmail) {
        sessionDao.findById(sessionId).ifPresent(s -> {
            String ownerEmail = s.getConference()
                    .getOrganizer().getUser().getEmail();
            if (!ownerEmail.equals(organizerEmail)) {
                throw new RuntimeException(
                        "Unauthorized");
            }
            /*
             * Before deleting session, unlink any speakers
             * that are assigned to it — set their session to null
             * so they remain as conference-level speakers.
             */
            List<Speaker> assigned =
                    speakerDao.findBySessionId(sessionId);
            for (Speaker sp : assigned) {
                sp.setSession(null);
                speakerDao.update(sp);
            }
            sessionDao.delete(sessionId);
        });
    }

    @Override
    public void assignSpeakerToSession(
            Long speakerId,
            Long sessionId,
            String organizerEmail) {
        /*
         * Links a conference speaker to a specific session.
         * Updates Speaker.session_id in the DB.
         * Validates speaker and session belong to same conference.
         */
        Speaker speaker = speakerDao.findById(speakerId)
                .orElseThrow(() ->
                        new RuntimeException("Speaker not found"));

        Session session = sessionDao.findById(sessionId)
                .orElseThrow(() ->
                        new RuntimeException("Session not found"));

        // Verify same conference
        if (!speaker.getConference().getId()
                .equals(session.getConference().getId())) {
            throw new RuntimeException(
                    "Speaker and session must belong " +
                            "to the same conference");
        }

        // Verify ownership
        if (!session.getConference().getOrganizer()
                .getUser().getEmail().equals(organizerEmail)) {
            throw new RuntimeException("Unauthorized");
        }

        speaker.setSession(session);
        speakerDao.update(speaker);
    }

    @Override
    public void unassignSpeakerFromSession(
            Long speakerId, String organizerEmail) {
        speakerDao.findById(speakerId).ifPresent(sp -> {
            if (!sp.getConference().getOrganizer()
                    .getUser().getEmail()
                    .equals(organizerEmail)) {
                throw new RuntimeException("Unauthorized");
            }
            sp.setSession(null);
            speakerDao.update(sp);
        });
    }

    @Override
    @Transactional(readOnly = true)
    public List<Session> getSessionsByConference(
            Long conferenceId) {
        return sessionDao.findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Session> findById(Long id) {
        return sessionDao.findById(id);
    }
}
