package com.xworkz.model.controller;

import com.xworkz.model.entity.BatchEntity;
import com.xworkz.model.entity.BatchStudentEntity;
import com.xworkz.model.entity.EmailNotificationEntity;
import com.xworkz.model.service.BatchService;
import com.xworkz.model.service.BatchStudentService;
import com.xworkz.model.service.EmailNotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class EmailController {


        @Autowired
        EmailNotificationService emailNotificationService;

        @Autowired
        BatchService batchService;

        @Autowired
        BatchStudentService batchStudentService;

        // ── SHOW the "Send Email" form ────────────────────────────────────────
        // GET /dashboard/sendEmail?studentId=5&batchId=2
        @GetMapping("/dashboard/sendEmail")
        public String showSendEmailForm(@RequestParam int studentId,
                                        @RequestParam int batchId,
                                        Model model) {

            BatchStudentEntity student = batchStudentService.getStudentById(studentId);
            BatchEntity batch = batchService.getBatchById(batchId);

            if (student == null || batch == null) {
                return "redirect:/dashboard/viewBatches";
            }

            model.addAttribute("student", student);
            model.addAttribute("batch", batch);
            return "sendEmail";  // → sendEmail.jsp
        }

        // ── PROCESS the "Send Email" form submission ──────────────────────────
        // POST /dashboard/sendEmail
        @PostMapping("/dashboard/sendEmail")
        public String processSendEmail(
                @RequestParam int studentId,
                @RequestParam int batchId,
                @RequestParam String subject,
                @RequestParam String emailMessage,
                @RequestParam String responsePageMessage,
                HttpSession session,
                HttpServletRequest request,
                RedirectAttributes redirectAttributes) {

            BatchStudentEntity student = batchStudentService.getStudentById(studentId);
            if (student == null) {
                redirectAttributes.addFlashAttribute("error", "Student not found");
                return "redirect:/dashboard/batchDetails/" + batchId;
            }

            // Build the base URL dynamically from the request
            // e.g. "http://localhost:8080/Preetham_xworkz_Model"
            String appBaseUrl = request.getScheme() + "://" + request.getServerName()
                    + ":" + request.getServerPort()
                    + request.getContextPath();

            String sentBy = (String) session.getAttribute("name");
            if (sentBy == null) sentBy = "Admin";

            boolean sent = emailNotificationService.sendNotification(
                    batchId, studentId,
                    student.getName(), student.getEmail(),
                    subject, emailMessage, responsePageMessage,
                    sentBy, appBaseUrl
            );

            if (sent) {
                redirectAttributes.addFlashAttribute("msg",
                        "✅ Email sent successfully to " + student.getName() + " (" + student.getEmail() + ")");
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "❌ Failed to send email. Check your SMTP settings.");
            }

            return "redirect:/dashboard/batchDetails/" + batchId;
        }

        // ── STUDENT RESPONSE PAGE ─────────────────────────────────────────────
        // This is the page the student lands on after clicking the link in the email.
        // GET /respond?token=abc123
        @GetMapping("/respond")
        public String showResponsePage(@RequestParam String token, Model model) {

            EmailNotificationEntity notification = emailNotificationService.getByToken(token);

            if (notification == null) {
                model.addAttribute("error", "Invalid or expired link.");
                return "respondPage"; // show error on page
            }

            // If already responded, show a "you already responded" message
            if (notification.getResponse() != null) {
                model.addAttribute("alreadyResponded", true);
                model.addAttribute("previousResponse", notification.getResponse());
                model.addAttribute("notification", notification);
                return "respondPage";
            }

            model.addAttribute("notification", notification);
            model.addAttribute("token", token);
            return "respondPage"; // → respondPage.jsp
        }

        // ── RECORD STUDENT RESPONSE ───────────────────────────────────────────
        // POST /respond  (when student clicks YES or NO button)
        @PostMapping("/respond")
        public String recordResponse(@RequestParam String token,
                                     @RequestParam String response,  // "YES" or "NO"
                                     Model model) {

            EmailNotificationEntity notification = emailNotificationService.getByToken(token);

            if (notification == null) {
                model.addAttribute("error", "Invalid token.");
                return "respondPage";
            }

            if (notification.getResponse() != null) {
                model.addAttribute("alreadyResponded", true);
                model.addAttribute("previousResponse", notification.getResponse());
                model.addAttribute("notification", notification);
                return "respondPage";
            }

            // Save the response to DB
            boolean saved = emailNotificationService.recordResponse(token, response);

            model.addAttribute("responseSaved", saved);
            model.addAttribute("chosenResponse", response);
            model.addAttribute("notification", notification);
            return "respondPage";
        }

        // ── VIEW ALL RESPONSES FOR A BATCH ────────────────────────────────────
        // GET /dashboard/emailResponses?batchId=2
        @GetMapping("/dashboard/emailResponses")
        public String viewResponses(@RequestParam int batchId, Model model) {

            BatchEntity batch = batchService.getBatchById(batchId);
            model.addAttribute("batch", batch);
            model.addAttribute("notifications",
                    emailNotificationService.getByBatchId(batchId));
            return "emailResponses"; // → emailResponses.jsp
        }


}
