package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.OutreachContact;
import java.util.List;

/*
 * OutreachService — organizer sends invitations to
 * institutions via NexMeet.
 *
 * Business rules enforced here (not in controller):
 * 1. Check for duplicate outreach (same conf + institution)
 * 2. Send email to institution contact email
 * 3. Record outreach in outreach_contacts table
 * 4. If institution has no email, record as NO_EMAIL
 *
 * Returns count of successfully sent emails.
 */
public interface OutreachService {

    /*
     * Send outreach for selected institution IDs.
     * organizerEmail = logged-in organizer's email.
     * Returns "X sent, Y skipped" summary string.
     */
    String sendOutreach(
            Long conferenceId,
            List<Long> institutionIds,
            String organizerEmail
    );

    List<OutreachContact> getHistory(Long conferenceId);

    /*
     * Organizer updates status after institution responds.
     * e.g. they replied → RESPONDED
     *      they're interested → INTERESTED
     */
    void updateStatus(Long outreachId,
                      String newStatus,
                      String notes);
}