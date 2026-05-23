package com.nexmeet.platform.service;


/*
 * Centralized email service for all transactional emails.
 *
 * JavaMailSender (Gmail SMTP) is already configured in spring-db-config.xml.
 * All methods are fire-and-forget — a failed email must NEVER break
 * the main operation (registration, etc.). Always try-catch internally.
 *
 * Emails sent:
 *  1. Welcome        — on new account creation
 *  2. Registration   — on conference registration, with QR code
 *  3. Outreach       — organizer invites institution to a conference
 */


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

    /*
     * Sent on new account creation for all roles.
     * roleName: "DELEGATE", "ORGANIZER", "INSTITUTIONAL_ADMIN"
     */
    void sendWelcomeEmail(
            String toEmail,
            String fullName,
            String roleName
    );

    /*
     * Organizer invites an institution to a conference.
     * toEmail = institution's contact email.
     */
    void sendOutreachEmail(
            String toEmail,
            String institutionName,
            String conferenceName,
            String startDate,
            String mode,
            String city,
            String targetAudience,
            boolean isFree,
            String delegateFee,
            Long conferenceId,
            String organizerName,
            String organizerEmail
    );

    /*
     * Emails the certificate PDF as an attachment.
     * Called by CertificateServiceImpl.issueCertificate()
     * when a conference is marked COMPLETED.
     *
     * pdfBytes — the raw PDF bytes to attach.
     * The delegate downloads directly from their email
     * OR from the dashboard download button.
     */
    void sendCertificateEmail(
            String toEmail,
            String delegateName,
            String conferenceName,
            String certificateNumber,
            byte[] pdfBytes
    );

    /*
     * Sends the ticket PDF as an email attachment when a
     * delegate successfully registers for a conference.
     *
     * Called from RegistrationServiceImpl after QR code
     * is generated — so the ticket PDF includes the QR.
     *
     * This is in ADDITION to sendRegistrationConfirmation()
     * which sends a plain-text summary email. This one
     * sends the actual downloadable ticket PDF.
     *
     * pdfBytes — raw bytes of the generated ticket PDF.
     */
    void sendTicketEmail(
            String toEmail,
            String delegateName,
            String conferenceName,
            String registrationNumber,
            String conferenceDate,
            String venueOrMode,
            byte[] pdfBytes
    );
}