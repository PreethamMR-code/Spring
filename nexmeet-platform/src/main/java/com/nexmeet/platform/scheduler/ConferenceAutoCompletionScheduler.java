package com.nexmeet.platform.scheduler;

import com.nexmeet.platform.service.ConferenceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

/**
 * Background scheduler that auto-completes expired conferences.
 *
 * Without this, conferences only auto-complete when someone
 * loads the admin or organizer dashboard — meaning a conference
 * that ends at midnight might not be marked COMPLETED (and
 * certificates not issued) until the next morning when someone
 * logs in.
 *
 * With this scheduler, completion runs every hour regardless
 * of whether any user is logged in.
 *
 * Spring wires this because:
 *   1. @Service makes it a Spring bean
 *   2. spring-db-config.xml scans com.nexmeet.platform.scheduler
 *   3. <task:annotation-driven/> in spring-db-config.xml
 *      activates @Scheduled processing
 *
 * The cron "0 0 * * * *" fires at the top of every hour
 * (second=0, minute=0, any hour, any day).
 * Changed from 15 minutes to hourly — conference completion
 * is not time-critical to the minute, and hourly reduces
 * unnecessary DB load in production.
 */
@Service
public class ConferenceAutoCompletionScheduler {

    private static final Logger log =
            LoggerFactory.getLogger(
                    ConferenceAutoCompletionScheduler.class);

    @Autowired
    private ConferenceService conferenceService;

    /**
     * Runs at the top of every hour.
     *
     * Finds all APPROVED conferences whose end date has
     * passed and runs the full completion flow for each:
     *   - Status → COMPLETED
     *   - In-app notifications to all confirmed delegates
     *   - Certificate issuance for attended delegates
     *   - Certificate PDF emailed as attachment
     *   - Completion email for non-certificate conferences
     *
     * Each conference is handled in its own try-catch inside
     * autoCompleteExpiredConferences() so one failure does
     * not prevent the others from completing.
     */
    @Scheduled(cron = "0 0 * * * *")
    public void runAutoCompletion() {
        log.info("[Scheduler] Running conference " +
                "auto-completion check");
        try {
            conferenceService
                    .autoCompleteExpiredConferences();
            log.info("[Scheduler] Auto-completion " +
                    "check finished");
        } catch (Exception e) {
            log.error("[Scheduler] Auto-completion " +
                    "check failed: {}", e.getMessage());
        }
    }
}