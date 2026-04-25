package com.nexmeet.platform.service;

import com.nexmeet.platform.dto.SpeakerDto;
import com.nexmeet.platform.entity.Speaker;

import java.util.List;
import java.util.Optional;

public interface SpeakerService {

    /*
     * Add a speaker to a conference.
     * speakerDto contains all speaker details + conferenceId.
     * sessionId is optional — if null, speaker is conference-level.
     */
    Speaker addSpeaker(SpeakerDto dto, Long conferenceId);

    void deleteSpeaker(Long speakerId, String organizerEmail);

    List<Speaker> getSpeakersByConference(Long conferenceId);

    Optional<Speaker> findById(Long id);

}
