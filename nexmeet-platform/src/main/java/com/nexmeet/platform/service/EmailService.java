package com.nexmeet.platform.service;

public interface EmailService {

    /*
     * Sends registration confirmation to delegate.
     * Called after successful conference registration.
     */
    void sendRegistrationConfirmation(
            String toEmail,
            String delegateName,
            String conferenceName,
            String registrationNumber,
            String conferenceDate,
            String conferenceVenue
    );

    /*
     * Notifies organizer that their conference was approved.
     */
    void sendConferenceApproved(
            String toEmail,
            String organizerName,
            String conferenceName
    );

    /*
     * Notifies organizer that their conference was rejected.
     */
    void sendConferenceRejected(
            String toEmail,
            String organizerName,
            String conferenceName,
            String reason
    );

    /*
     * Notifies delegate that their registered conference
     * has been cancelled.
     */
    void sendConferenceCancelled(
            String toEmail,
            String delegateName,
            String conferenceName,
            String reason
    );

    /*
     * Notifies delegates that conference is now complete
     * and their certificate is available.
     */
    void sendConferenceCompleted(
            String toEmail,
            String delegateName,
            String conferenceName
    );

    /*
     * Notifies organizer that their account was verified.
     */
    void sendOrganizerVerified(
            String toEmail,
            String organizerName
    );
}