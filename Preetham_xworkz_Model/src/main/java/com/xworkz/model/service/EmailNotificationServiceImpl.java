package com.xworkz.model.service;

import com.xworkz.model.entity.EmailNotificationEntity;
import com.xworkz.model.repository.EmailNotificationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class EmailNotificationServiceImpl implements EmailNotificationService{



        @Autowired
        EmailNotificationDAO emailNotificationDAO;

        @Autowired
        JavaMailSender mailSender;

        @Override
        public boolean sendNotification(int batchId, int studentId, String studentName,
                                        String studentEmail, String subject,
                                        String emailMessage, String responsePageMessage,
                                        String sentBy, String appBaseUrl) {

            // ── Step 1: Generate a unique token for this notification ─────────
            // UUID = random 36-character string like "a3f2b1c4-..."
            // This token is embedded in the link so when student clicks it,
            // we know exactly WHICH notification they're responding to.
            String token = UUID.randomUUID().toString();

            // The link student will click: http://localhost:8080/App/respond?token=abc123
            String responseLink = appBaseUrl + "/respond?token=" + token;

            // ── Step 2: Build the HTML email body ─────────────────────────────
            String htmlBody = buildEmailHtml(studentName, emailMessage, responseLink);

            // ── Step 3: Send the actual email via JavaMail ────────────────────
            try {
                MimeMessage mimeMessage = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                helper.setTo(studentEmail);
                helper.setSubject(subject);
                helper.setText(htmlBody, true); // true = HTML content
                helper.setFrom("preethampreetham560@gmail.com");

                mailSender.send(mimeMessage);
                System.out.println("✅ Email sent to: " + studentEmail);

            } catch (Exception e) {
                System.err.println("❌ Failed to send email to: " + studentEmail);
                e.printStackTrace();
                return false;
            }

            // ── Step 4: Save notification record to DB ────────────────────────
            EmailNotificationEntity notification = new EmailNotificationEntity();
            notification.setBatchId(batchId);
            notification.setStudentId(studentId);
            notification.setStudentName(studentName);
            notification.setStudentEmail(studentEmail);
            notification.setSubject(subject);
            notification.setMessage(emailMessage);
            notification.setResponsePageMessage(responsePageMessage);
            notification.setResponseToken(token);
            notification.setSentAt(LocalDateTime.now());
            notification.setResponse(null); // null = not yet responded
            notification.setSentBy(sentBy);

            return emailNotificationDAO.save(notification);
        }

        @Override
        public EmailNotificationEntity getByToken(String token) {
            return emailNotificationDAO.findByToken(token);
        }

        @Override
        public boolean recordResponse(String token, String response) {
            // response must be "YES" or "NO"
            if (!response.equals("YES") && !response.equals("NO")) {
                return false;
            }
            return emailNotificationDAO.updateResponse(token, response);
        }

        @Override
        public List<EmailNotificationEntity> getByBatchId(int batchId) {
            return emailNotificationDAO.findByBatchId(batchId);
        }

        @Override
        public List<EmailNotificationEntity> getByStudentId(int studentId) {
            return emailNotificationDAO.findByStudentId(studentId);
        }

        // ── Private helper: builds the HTML email ─────────────────────────────
        private String buildEmailHtml(String studentName, String message, String responseLink) {
            return "<!DOCTYPE html><html><body style='font-family:Arial,sans-serif;background:#f4f6f8;padding:20px;'>" +
                    "<div style='max-width:600px;margin:0 auto;background:white;border-radius:12px;" +
                    "box-shadow:0 2px 10px rgba(0,0,0,0.1);overflow:hidden;'>" +

                    // Header
                    "<div style='background:#0d6efd;padding:30px;text-align:center;'>" +
                    "<h1 style='color:white;margin:0;font-size:24px;'>X-Workz Institute</h1>" +
                    "<p style='color:rgba(255,255,255,0.8);margin:8px 0 0;'>Learning Management System</p>" +
                    "</div>" +

                    // Body
                    "<div style='padding:30px;'>" +
                    "<h2 style='color:#1e293b;'>Hello, " + studentName + "!</h2>" +
                    "<p style='color:#475569;line-height:1.7;font-size:16px;'>" + message + "</p>" +

                    // CTA Button
                    "<div style='text-align:center;margin:30px 0;'>" +
                    "<a href='" + responseLink + "' style='background:#0d6efd;color:white;padding:14px 32px;" +
                    "border-radius:8px;text-decoration:none;font-size:16px;font-weight:bold;" +
                    "display:inline-block;'>Click Here to Respond</a>" +
                    "</div>" +

                    "<p style='color:#94a3b8;font-size:13px;'>If the button doesn't work, copy and paste this link:<br>" +
                    "<a href='" + responseLink + "' style='color:#0d6efd;'>" + responseLink + "</a></p>" +
                    "</div>" +

                    // Footer
                    "<div style='background:#f8fafc;padding:20px;text-align:center;border-top:1px solid #e2e8f0;'>" +
                    "<p style='color:#94a3b8;margin:0;font-size:12px;'>© 2026 X-Workz Training Institute</p>" +
                    "</div>" +
                    "</div></body></html>";
        }


}
