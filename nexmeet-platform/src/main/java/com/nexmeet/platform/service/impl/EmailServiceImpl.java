package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;

/*
 * Sends HTML transactional emails via Gmail SMTP.
 *
 * Each method builds an HTML email with:
 * - NexMeet brand header (purple gradient)
 * - Clear subject and body
 * - Call-to-action button
 * - Professional footer
 *
 * Emails are sent asynchronously by calling in a try-catch
 * so if email fails, the main operation (registration, etc.)
 * is NOT rolled back. Email failure is logged but silent.
 *
 * In production: replace with SendGrid or AWS SES for
 * better deliverability and higher volume.
 */
@Service
public class EmailServiceImpl implements EmailService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    /*
     * Base HTML email wrapper — consistent branding.
     * All emails share this header/footer template.
     */
    private String wrapInTemplate(
            String subject,
            String bodyContent) {
        return "<!DOCTYPE html><html><head>" +
                "<meta charset='UTF-8'/>" +
                "<style>" +
                "body{font-family:Inter,-apple-system," +
                "sans-serif;margin:0;padding:0;" +
                "background:#f8f9fc;}" +
                ".container{max-width:560px;margin:32px auto;" +
                "background:white;border-radius:12px;" +
                "overflow:hidden;" +
                "box-shadow:0 4px 16px rgba(0,0,0,0.08);}" +
                ".header{background:linear-gradient(" +
                "135deg,#667eea,#764ba2);" +
                "padding:28px 32px;}" +
                ".logo{color:white;font-size:1.4rem;" +
                "font-weight:800;}" +
                ".body{padding:32px;}" +
                "h2{font-size:1.2rem;font-weight:700;" +
                "color:#0f172a;margin:0 0 12px;}" +
                "p{color:#475569;line-height:1.7;" +
                "margin:0 0 16px;font-size:0.92rem;}" +
                ".highlight-box{background:#f0f2ff;" +
                "border:1px solid #c7d2fe;" +
                "border-radius:8px;padding:16px 20px;" +
                "margin:16px 0;}" +
                ".highlight-box .label{font-size:0.72rem;" +
                "text-transform:uppercase;letter-spacing:0.05em;" +
                "color:#6366f1;font-weight:600;margin-bottom:4px;}" +
                ".highlight-box .value{font-size:1rem;" +
                "font-weight:700;color:#0f172a;}" +
                ".btn{display:inline-block;" +
                "background:linear-gradient(" +
                "135deg,#667eea,#764ba2);" +
                "color:white;text-decoration:none;" +
                "padding:12px 28px;border-radius:8px;" +
                "font-weight:700;font-size:0.9rem;" +
                "margin:8px 0;}" +
                ".footer{background:#f8f9fc;" +
                "padding:20px 32px;border-top:1px solid #e8ecf0;" +
                "font-size:0.78rem;color:#94a3b8;" +
                "text-align:center;}" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<div class='logo'>NexMeet</div>" +
                "</div>" +
                "<div class='body'>" +
                bodyContent +
                "</div>" +
                "<div class='footer'>" +
                "NexMeet - Professional Conference Management" +
                "<br/>This is an automated message," +
                " please do not reply." +
                "</div>" +
                "</div>" +
                "</body></html>";
    }

    private void send(String to,
                      String subject,
                      String htmlBody) {
        try {
            MimeMessage msg = mailSender.createMimeMessage();
            MimeMessageHelper helper =
                    new MimeMessageHelper(msg, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true);
            helper.setFrom("noreply@nexmeet.com");
            mailSender.send(msg);
        } catch (Exception e) {
            /*
             * Log but don't throw — email failure should
             * never break the main business operation.
             * In production: use a proper logger and
             * consider a retry queue.
             */
            System.err.println(
                    "[EmailService] Failed to send email to "
                            + to + ": " + e.getMessage());
        }
    }

    @Override
    public void sendRegistrationConfirmation(
            String toEmail,
            String delegateName,
            String conferenceName,
            String registrationNumber,
            String conferenceDate,
            String conferenceVenue) {

        String body =
                "<h2>Registration Confirmed!</h2>" +
                        "<p>Hi <strong>" + delegateName +
                        "</strong>,</p>" +
                        "<p>You have successfully registered for " +
                        "<strong>" + conferenceName + "</strong>. " +
                        "Here are your registration details:</p>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Registration Number</div>" +
                        "<div class='value'>" + registrationNumber +
                        "</div></div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Conference</div>" +
                        "<div class='value'>" + conferenceName +
                        "</div></div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Date</div>" +
                        "<div class='value'>" + conferenceDate +
                        "</div></div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Venue</div>" +
                        "<div class='value'>" + conferenceVenue +
                        "</div></div>" +

                        "<p>Please save your registration number. " +
                        "You will need it for QR code check-in " +
                        "at the venue.</p>" +
                        "<p>See you at the conference!</p>";

        send(toEmail,
                "Registration Confirmed - " + conferenceName,
                wrapInTemplate("Registration Confirmed", body));
    }

    @Override
    public void sendConferenceApproved(
            String toEmail,
            String organizerName,
            String conferenceName) {

        String body =
                "<h2>Conference Approved!</h2>" +
                        "<p>Hi <strong>" + organizerName +
                        "</strong>,</p>" +
                        "<p>Great news! Your conference " +
                        "<strong>" + conferenceName + "</strong> " +
                        "has been approved by our admin team and " +
                        "is now live on NexMeet.</p>" +
                        "<p>Delegates can now discover and register " +
                        "for your conference.</p>" +
                        "<p><strong>Next steps:</strong></p>" +
                        "<ul style='color:#475569;font-size:0.92rem;" +
                        "line-height:1.8'>" +
                        "<li>Add speakers to your conference</li>" +
                        "<li>Build your session schedule</li>" +
                        "<li>Share the conference link with " +
                        "your network</li>" +
                        "</ul>";

        send(toEmail,
                "Conference Approved - " + conferenceName,
                wrapInTemplate("Conference Approved", body));
    }

    @Override
    public void sendConferenceRejected(
            String toEmail,
            String organizerName,
            String conferenceName,
            String reason) {

        String body =
                "<h2>Conference Not Approved</h2>" +
                        "<p>Hi <strong>" + organizerName +
                        "</strong>,</p>" +
                        "<p>Unfortunately, your conference " +
                        "<strong>" + conferenceName + "</strong> " +
                        "was not approved at this time.</p>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Reason</div>" +
                        "<div class='value' style='font-size:0.9rem;" +
                        "font-weight:400'>" + reason +
                        "</div></div>" +

                        "<p>You can edit your conference details and " +
                        "resubmit for review. Please address the " +
                        "feedback provided above.</p>";

        send(toEmail,
                "Conference Not Approved - " + conferenceName,
                wrapInTemplate("Conference Not Approved", body));
    }

    @Override
    public void sendConferenceCancelled(
            String toEmail,
            String delegateName,
            String conferenceName,
            String reason) {

        String body =
                "<h2>Conference Cancelled</h2>" +
                        "<p>Hi <strong>" + delegateName +
                        "</strong>,</p>" +
                        "<p>We regret to inform you that " +
                        "<strong>" + conferenceName + "</strong>, " +
                        "which you had registered for, has been " +
                        "cancelled.</p>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Reason</div>" +
                        "<div class='value' style='font-size:0.9rem;" +
                        "font-weight:400'>" + reason +
                        "</div></div>" +

                        "<p>We apologise for any inconvenience. " +
                        "Browse other conferences on NexMeet that " +
                        "may interest you.</p>";

        send(toEmail,
                "Conference Cancelled - " + conferenceName,
                wrapInTemplate("Conference Cancelled", body));
    }

    @Override
    public void sendConferenceCompleted(
            String toEmail,
            String delegateName,
            String conferenceName) {

        String body =
                "<h2>Conference Completed!</h2>" +
                        "<p>Hi <strong>" + delegateName +
                        "</strong>,</p>" +
                        "<p>Thank you for attending " +
                        "<strong>" + conferenceName + "</strong>. " +
                        "The conference has officially concluded.</p>" +
                        "<p>Your <strong>certificate of participation" +
                        "</strong> is now available for download. " +
                        "Log in to NexMeet and visit your " +
                        "dashboard to download it.</p>" +
                        "<p>We hope you found the conference " +
                        "valuable. Please take a moment to leave " +
                        "your feedback — it helps organizers " +
                        "improve future events.</p>";

        send(toEmail,
                "Certificate Ready - " + conferenceName,
                wrapInTemplate("Conference Completed", body));
    }

    @Override
    public void sendOrganizerVerified(
            String toEmail,
            String organizerName) {

        String body =
                "<h2>Account Verified!</h2>" +
                        "<p>Hi <strong>" + organizerName +
                        "</strong>,</p>" +
                        "<p>Your organizer account on NexMeet " +
                        "has been verified by our admin team.</p>" +
                        "<p>You can now:</p>" +
                        "<ul style='color:#475569;font-size:0.92rem;" +
                        "line-height:1.8'>" +
                        "<li>Create and submit conferences " +
                        "for approval</li>" +
                        "<li>Manage delegate registrations</li>" +
                        "<li>Use QR check-in and certificate " +
                        "generation</li>" +
                        "<li>Add speakers and build schedules</li>" +
                        "</ul>" +
                        "<p>Log in and start creating your " +
                        "first conference!</p>";

        send(toEmail,
                "Your NexMeet Organizer Account is Verified",
                wrapInTemplate("Account Verified", body));
    }

    @Override
    public void sendWelcomeEmail(
            String toEmail,
            String fullName,
            String roleName) {

        String roleDisplay =
                "ORGANIZER".equals(roleName)
                        ? "Conference Organizer"
                        : "INSTITUTIONAL_ADMIN".equals(roleName)
                        ? "Institutional Admin"
                        : "Delegate";

        String nextStep =
                "ORGANIZER".equals(roleName)
                        ? "Complete your organizer profile and create your first conference."
                        : "INSTITUTIONAL_ADMIN".equals(roleName)
                        ? "Complete your institutional admin profile and start registering your students."
                        : "Browse upcoming conferences and register for ones that interest you.";

        String body =
                "<h2>Welcome to NexMeet! 🎉</h2>" +
                        "<p>Hi <strong>" + fullName + "</strong>,</p>" +
                        "<p>Your account has been created successfully. " +
                        "You're registered as a <strong>" + roleDisplay +
                        "</strong> on NexMeet.</p>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Email</div>" +
                        "<div class='value'>" + toEmail + "</div>" +
                        "</div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Account Type</div>" +
                        "<div class='value'>" + roleDisplay + "</div>" +
                        "</div>" +

                        "<p><strong>What's next?</strong><br/>" +
                        nextStep + "</p>";

        send(toEmail,
                "Welcome to NexMeet! 🎉",
                wrapInTemplate("Welcome to NexMeet", body));
    }

    @Override
    public void sendOutreachEmail(
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
            String organizerEmail) {

        String feeInfo = isFree
                ? "This is a <strong>FREE</strong> event — no registration fee."
                : "Registration fee: <strong>₹" + delegateFee +
                "</strong> per delegate (collected at venue).";

        String locationInfo = (city != null && !city.isEmpty())
                ? city : mode;

        String body =
                "<h2>Conference Invitation</h2>" +
                        "<p>Dear <strong>" + institutionName +
                        "</strong> Team,</p>" +
                        "<p><strong>" + organizerName + "</strong> is organizing " +
                        "a conference on NexMeet and would like to invite your " +
                        "students and faculty to participate.</p>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Conference</div>" +
                        "<div class='value'>" + conferenceName + "</div>" +
                        "</div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Date</div>" +
                        "<div class='value'>" + startDate + "</div>" +
                        "</div>" +

                        "<div class='highlight-box'>" +
                        "<div class='label'>Mode / Location</div>" +
                        "<div class='value'>" + mode +
                        (city != null && !city.isEmpty()
                                ? " · " + city : "") +
                        "</div>" +
                        "</div>" +

                        (targetAudience != null && !targetAudience.isEmpty()
                                ? "<div class='highlight-box'>" +
                                "<div class='label'>Target Audience</div>" +
                                "<div class='value'>" + targetAudience +
                                "</div></div>"
                                : "") +

                        "<p>" + feeInfo + "</p>" +

                        "<p>Students can register individually, or your " +
                        "institutional admin on NexMeet can bulk-register them.</p>" +

                        "<p style='text-align:center;margin:24px 0'>" +
                        "<a class='btn' href='http://localhost:8080/nexmeet/conference/"
                        + conferenceId + "'>" +
                        "View Conference &amp; Register →</a>" +
                        "</p>" +

                        "<p style='font-size:0.85rem;color:#64748b'>" +
                        "For queries, contact the organizer:<br/>" +
                        "<strong>" + organizerName + "</strong> — " +
                        "<a href='mailto:" + organizerEmail + "' " +
                        "style='color:#667eea'>" + organizerEmail + "</a>" +
                        "</p>";

        send(toEmail,
                "Conference Invitation: " + conferenceName + " [NexMeet]",
                wrapInTemplate("Conference Invitation", body));
    }

    @Override
    public void sendCertificateEmail(
            String toEmail,
            String delegateName,
            String conferenceName,
            String certificateNumber,
            byte[] pdfBytes) {

        // Uses the private send() helper but needs
        // attachment — so we handle directly here
        if (mailSender == null) return;
        try {
            MimeMessage message =
                    mailSender.createMimeMessage();

            // true = multipart (needed for attachment)
            MimeMessageHelper helper =
                    new MimeMessageHelper(
                            message, true, "UTF-8");

            helper.setFrom(
                    "NexMeet <noreply@nexmeet.com>");
            helper.setTo(toEmail);
            helper.setSubject(
                    "🏆 Your Certificate — "
                            + conferenceName);

            String body =
                    "<h2>Your Certificate is Ready!</h2>" +
                            "<p>Hi <strong>" + delegateName +
                            "</strong>,</p>" +
                            "<p>Congratulations! Your certificate " +
                            "of participation for " +
                            "<strong>" + conferenceName +
                            "</strong> has been issued.</p>" +
                            "<div class='highlight-box'>" +
                            "<div class='label'>" +
                            "Certificate Number</div>" +
                            "<div class='value'>" +
                            certificateNumber + "</div>" +
                            "</div>" +
                            "<p>Your certificate is attached to " +
                            "this email as a PDF. You can also " +
                            "download it anytime from your " +
                            "NexMeet dashboard.</p>" +
                            "<p style='color:#64748b;" +
                            "font-size:0.85rem'>" +
                            "Keep your certificate number safe. " +
                            "It uniquely identifies your " +
                            "participation.</p>";

            helper.setText(
                    wrapInTemplate(
                            "Certificate Ready", body),
                    true);

            // Attach the PDF
            if (pdfBytes != null
                    && pdfBytes.length > 0) {
                helper.addAttachment(
                        "NexMeet_Certificate_"
                                + certificateNumber + ".pdf",
                        new org.springframework.core
                                .io.ByteArrayResource(pdfBytes),
                        "application/pdf");
            }

            mailSender.send(message);

        } catch (Exception e) {
            System.err.println(
                    "[EmailService] Certificate email " +
                            "failed to " + toEmail + ": "
                            + e.getMessage());
        }
    }
}