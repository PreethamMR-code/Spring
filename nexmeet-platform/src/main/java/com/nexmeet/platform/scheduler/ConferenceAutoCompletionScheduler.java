package com.nexmeet.platform.scheduler;

import com.nexmeet.platform.service.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class ConferenceAutoCompletionScheduler {

    @Autowired
    private ConferenceService conferenceService;

    @Scheduled(cron = "0 */15 * * * *")
    public void runAutoCompletion() {

        conferenceService
                .autoCompleteExpiredConferences();

    }
}
