package com.nexmeet.platform.controller.delegate;

import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/*
 * Handles delegate conference registration POST.
 * Secured to ROLE_DELEGATE via spring-security.xml.
 *
 * This is the single controller for /conference/{id}/register POST.
 * ConferenceController handles the GET (detail page).
 * Keeping them separate: pub pages (GET) vs delegate actions (POST).
 */
@Controller
public class RegistrationController {

    @Autowired
    private RegistrationService registrationService;

    @PostMapping("/conference/{id}/register")
    public String register(
            @PathVariable Long id,
            Authentication authentication,
            RedirectAttributes flash) {

        String email = authentication.getName();
        String result = registrationService
                .registerForConference(id, email);

        switch (result) {
            case "SUCCESS":
                flash.addFlashAttribute("success",
                        "Registration confirmed! " +
                                "Check your email for your ticket.");
                return "redirect:/delegate/dashboard";

            case "ALREADY_REGISTERED":
                flash.addFlashAttribute("error",
                        "You are already registered " +
                                "for this conference.");
                return "redirect:/conference/" + id;

            case "REGISTRATION_CLOSED":
                flash.addFlashAttribute("error",
                        "Registration is closed " +
                                "for this conference.");
                return "redirect:/conference/" + id;

            case "PROFILE_INCOMPLETE":
                flash.addFlashAttribute("error",
                        "Please complete your delegate " +
                                "profile before registering " +
                                "for any conference.");
                return "redirect:/delegate/profile/setup";

            default:
                flash.addFlashAttribute("error",
                        "Registration failed: " + result);
                return "redirect:/conference/" + id;
        }
    }
}