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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

@Controller
public class EmailController {

    @Autowired EmailNotificationService emailNotificationService;
    @Autowired BatchService batchService;
    @Autowired BatchStudentService batchStudentService;

    // ── SHOW the "Send Email" compose form ────────────────────────────────
    @GetMapping("/dashboard/sendEmail")
    public String showSendEmailForm(@RequestParam int studentId,
                                    @RequestParam int batchId,
                                    Model model) {
        BatchStudentEntity student = batchStudentService.getStudentById(studentId);
        BatchEntity batch = batchService.getBatchById(batchId);
        if (student == null || batch == null) return "redirect:/dashboard/viewBatches";
        model.addAttribute("student", student);
        model.addAttribute("batch", batch);
        return "sendEmail";
    }

    // ── PROCESS the email send form ───────────────────────────────────────
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

        // ✅ FIX 1: Use LAN IP instead of localhost so mobile devices can open the link
        String appBaseUrl = buildAccessibleBaseUrl(request);

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

    // ── STUDENT RESPONSE PAGE (student clicks link from email) ────────────
    @GetMapping("/respond")
    public String showResponsePage(@RequestParam String token, Model model) {
        EmailNotificationEntity notification = emailNotificationService.getByToken(token);

        if (notification == null) {
            model.addAttribute("error", "Invalid or expired link.");
            return "respondPage";
        }
        if (notification.getResponse() != null) {
            model.addAttribute("alreadyResponded", true);
            model.addAttribute("previousResponse", notification.getResponse());
            model.addAttribute("notification", notification);
            return "respondPage";
        }
        model.addAttribute("notification", notification);
        model.addAttribute("token", token);
        return "respondPage";
    }

    // ── RECORD STUDENT RESPONSE (Yes/No button click) ─────────────────────
    @PostMapping("/respond")
    public String recordResponse(@RequestParam String token,
                                 @RequestParam String response,
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

        boolean saved = emailNotificationService.recordResponse(token, response);
        model.addAttribute("responseSaved", saved);
        model.addAttribute("chosenResponse", response);
        model.addAttribute("notification", notification);
        return "respondPage";
    }

    // ── VIEW ALL RESPONSES FOR A BATCH ────────────────────────────────────
    @GetMapping("/dashboard/emailResponses")
    public String viewResponses(@RequestParam int batchId, Model model) {
        BatchEntity batch = batchService.getBatchById(batchId);
        model.addAttribute("batch", batch);
        model.addAttribute("notifications", emailNotificationService.getByBatchId(batchId));
        return "emailResponses";
    }

    // ── PRIVATE: Build a URL accessible from mobile on the same WiFi ──────
    // Problem: request.getServerName() returns "localhost" when you access the app
    //          from your own PC. "localhost" only works on THAT computer — when a
    //          mobile phone opens a link with "localhost" it tries to connect to
    //          itself, not your PC, and fails.
    // Solution: Detect the actual LAN IP (like 192.168.1.5) so any device on
    //           the same WiFi network can reach the server.
    private String buildAccessibleBaseUrl(HttpServletRequest request) {
        String host = request.getServerName();

        if ("localhost".equals(host) || "127.0.0.1".equals(host)) {
            try {
                Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
                outerLoop:
                while (interfaces.hasMoreElements()) {
                    NetworkInterface iface = interfaces.nextElement();
                    if (iface.isLoopback() || !iface.isUp()) continue;

                    Enumeration<InetAddress> addresses = iface.getInetAddresses();
                    while (addresses.hasMoreElements()) {
                        InetAddress addr = addresses.nextElement();
                        if (addr instanceof Inet4Address && !addr.isLoopbackAddress()) {
                            host = addr.getHostAddress(); // e.g. "192.168.1.5"
                            System.out.println("✅ Detected LAN IP: " + host);
                            break outerLoop;
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("⚠️ Could not detect LAN IP: " + e.getMessage());
            }
        }

        String url = request.getScheme() + "://" + host
                + ":" + request.getServerPort()
                + request.getContextPath();
        System.out.println("📧 Email links will use base URL: " + url);
        return url;
    }
}
