package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.SpeakerDao;
import com.nexmeet.platform.dto.SpeakerDto;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Speaker;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.SpeakerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class SpeakerServiceImpl implements SpeakerService {

    @Autowired
    private SpeakerDao speakerDao;

    @Autowired
    private ConferenceService conferenceService;

    @Override
    public Speaker addSpeaker(SpeakerDto dto, Long conferenceId) {
        Conference conf = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        Speaker speaker = new Speaker();
        speaker.setConference(conf);
        speaker.setFullName(dto.getFullName());
        speaker.setDesignation(dto.getDesignation());
        speaker.setOrganization(dto.getOrganization());
        speaker.setBio(dto.getBio());
        speaker.setEmail(dto.getEmail());
        speaker.setLinkedinUrl(dto.getLinkedinUrl()); // ← was missing
        // session = null (conference-level speaker until assigned)

        speakerDao.save(speaker);
        return speaker;
    }

    @Override
    public void deleteSpeaker(Long speakerId,
                              String organizerEmail) {
        speakerDao.findById(speakerId).ifPresent(s -> {
            /*
             * Security: verify the organizer owns
             * the conference this speaker belongs to.
             */
            String ownerEmail = s.getConference()
                    .getOrganizer().getUser().getEmail();
            if (!ownerEmail.equals(organizerEmail)) {
                throw new RuntimeException(
                        "Unauthorized — not your conference");
            }
            speakerDao.delete(speakerId);
        });
    }

    @Override
    @Transactional(readOnly = true)
    public List<Speaker> getSpeakersByConference(
            Long conferenceId) {
        return speakerDao.findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Speaker> findById(Long id) {
        return speakerDao.findById(id);
    }
}
