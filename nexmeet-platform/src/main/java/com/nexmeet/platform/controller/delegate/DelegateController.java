package com.nexmeet.platform.controller.delegate;

import com.nexmeet.platform.dao.QrCodeDao;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.util.*;

@Controller
@RequestMapping("/delegate")
public class DelegateController {


    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private QrCodeDao qrCodeDao;

    @Autowired
    private CertificateService certificateService;

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private UserService userService;



    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        String email = auth.getName();
        List<Registration> registrations = registrationService.findByUserEmail(email);
        long confirmedCount = registrations.stream()
                .filter(r -> r.getStatus() == RegistrationStatus.CONFIRMED)
                .count();

        userService.findByEmail(email)
                .ifPresent(u -> model.addAttribute("currentUser", u));

        // Load QR codes mapped by registration id
        Map<Long, String> qrCodes = new HashMap<>();
        for (Registration reg : registrations) {
            if (reg.getStatus() == RegistrationStatus.CONFIRMED) {
                qrCodeDao.findByRegistrationId(reg.getId())
                        .ifPresent(qr -> qrCodes.put(reg.getId(), qr.getQrImageBase64()));
            }
        }

        // Inside dashboard() after building registrations list:
        Set<Long> attendedIds = new HashSet<>();
        for (Registration reg : registrations) {
            if (attendanceService.hasAttended(reg.getId())) {
                attendedIds.add(reg.getId());
            }
        }

        long attendedCount = attendedIds.size();
        long certificateCount = attendedIds.size(); // same — one cert per attendance

        // After building attendedIds set, add this:
        Set<Long> feedbackSubmitted = new HashSet<>();
        for (Registration reg : registrations) {
            if (reg.getStatus() == RegistrationStatus.CONFIRMED &&
                    attendanceService.hasAttended(reg.getId())) {
                if (feedbackService.hasSubmittedFeedback(
                        reg.getConference().getId(), email)) {
                    feedbackSubmitted.add(reg.getConference().getId());
                }
            }
        }
        model.addAttribute("feedbackSubmitted", feedbackSubmitted);

        model.addAttribute("attendedIds", attendedIds);
        model.addAttribute("attendedCount", attendedCount);
        model.addAttribute("certificateCount", certificateCount);

        model.addAttribute("myRegistrations", confirmedCount);
        model.addAttribute("registrations", registrations);
        model.addAttribute("qrCodes", qrCodes);
        model.addAttribute("email", email);

        return "delegate/dashboard";
    }

    @PostMapping("/registration/{id}/cancel")
    public String cancelRegistration(@PathVariable Long id,
                                     Authentication auth,
                                     RedirectAttributes flash) {
        String result = registrationService.cancelRegistration(id, auth.getName());

        switch (result) {
            case "CANCELLED":
                flash.addFlashAttribute("success", "Registration cancelled successfully.");
                break;
            case "CANCELLED_LATE":
                flash.addFlashAttribute("success",
                        "Registration cancelled. Note: deadline has passed — no seat can be filled.");
                break;
            case "ALREADY_CANCELLED":
                flash.addFlashAttribute("error", "This registration is already cancelled.");
                break;
            case "UNAUTHORIZED":
                flash.addFlashAttribute("error", "You are not authorized to cancel this registration.");
                break;
            default:
                flash.addFlashAttribute("error", "Registration not found.");
        }
        return "redirect:/delegate/dashboard";
    }

    @GetMapping("/registration/{id}/ticket")
    public void downloadTicket(@PathVariable Long id,
                               Authentication auth,
                               HttpServletResponse response) throws Exception {
        Optional<Registration> regOpt = registrationService.findById(id);

        if (!regOpt.isPresent() ||
                !regOpt.get().getUser().getEmail().equals(auth.getName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Registration reg = regOpt.get();
        String qrBase64 = qrCodeDao.findByRegistrationId(reg.getId())
                .map(qr -> qr.getQrImageBase64())
                .orElse(null);

        ByteArrayOutputStream baos = certificateService.generateTicket(reg, qrBase64);
        String filename = "Ticket_" + reg.getRegistrationNumber() + ".pdf";
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + filename + "\"");
        response.setContentLength(baos.size());
        response.getOutputStream().write(baos.toByteArray());
        response.getOutputStream().flush();
    }

    @GetMapping("/registration/{id}/certificate")
    public void downloadCertificate(@PathVariable Long id,
                                    Authentication auth,
                                    HttpServletResponse response) throws Exception {
        // Security: only own registrations
        Optional<Registration> regOpt = registrationService.findById(id);

        if (!regOpt.isPresent() ||
                !regOpt.get().getUser().getEmail().equals(auth.getName())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Registration reg = regOpt.get();

        // TODO Phase 15: Also check attendance record before allowing certificate

        if (reg.getStatus() != RegistrationStatus.CONFIRMED) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Certificate only available for confirmed registrations");
            return;
        }

        ByteArrayOutputStream baos = certificateService.generateCertificate(reg);

        String filename = "Certificate_" + reg.getRegistrationNumber() + ".pdf";
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setContentLength(baos.size());
        response.getOutputStream().write(baos.toByteArray());
        response.getOutputStream().flush();
    }
}
