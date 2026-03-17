package com.nexmeet.platform.controller.delegate;

import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/delegate")
public class DelegateController {


    @Autowired
    private RegistrationService registrationService;

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        String email = auth.getName();
        List<Registration> registrations = registrationService.findByUserEmail(email);
        long confirmedCount = registrations.stream()
                .filter(r -> r.getStatus() == RegistrationStatus.CONFIRMED)
                .count();
        model.addAttribute("myRegistrations", confirmedCount);
        model.addAttribute("registrations", registrations);
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
}
