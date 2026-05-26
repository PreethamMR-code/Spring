package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.SessionDao;
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
    private SessionDao sessionDao;

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

        sessionDao.findById(sessionId)
                .ifPresent(s -> {

                    String ownerEmail =
                            s.getConference()
                                    .getOrganizer()
                                    .getUser()
                                    .getEmail();

                    if (!ownerEmail.equals(organizerEmail)) {
                        throw new RuntimeException(
                                "Unauthorized");
                    }

                    /*
                     * IMPORTANT:
                     * session_speakers table uses
                     * ON DELETE CASCADE.
                     *
                     * So deleting a session automatically
                     * removes join-table mappings.
                     *
                     * Speaker rows themselves remain safe.
                     */

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

        boolean alreadyAssigned =
                session.getSpeakers()
                        .stream()
                        .anyMatch(sp ->
                                sp.getId()
                                        .equals(speakerId));

        if (!alreadyAssigned) {

            session.getSpeakers()
                    .add(speaker);

            sessionDao.update(session);
        }
    }

    @Override
    public void unassignSpeakerFromSession(
            Long speakerId,
            Long sessionId,
            String organizerEmail) {

        Session session =
                sessionDao.findById(sessionId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Session not found"));

        /*
         * Security check:
         * Only conference owner can modify schedule.
         */
        if (!session.getConference()
                .getOrganizer()
                .getUser()
                .getEmail()
                .equals(organizerEmail)) {

            throw new RuntimeException(
                    "Unauthorized");
        }

        /*
         * Remove ONLY this session-speaker relationship.
         */
        session.getSpeakers()
                .removeIf(sp ->
                        sp.getId()
                                .equals(speakerId));

        sessionDao.update(session);
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
