package com.nexmeet.platform.controller.delegate;

import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RegistrationController {

    @Autowired
    private RegistrationService registrationService;

    @PostMapping("/conference/{id}/register")
    public String register(@PathVariable Long id,
                           Authentication authentication,
                           RedirectAttributes flash) {

        String email = authentication.getName();
        String result = registrationService.registerForConference(id, email);

        switch (result) {
            case "SUCCESS":
                flash.addFlashAttribute("success", "Registration successful! Check your delegate dashboard.");
                break;
            case "ALREADY_REGISTERED":
                flash.addFlashAttribute("error", "You are already registered for this conference.");
                break;
            case "REGISTRATION_CLOSED":
                flash.addFlashAttribute("error", "Registration is closed for this conference.");
                break;
        }

        return "redirect:/conference/" + id;
    }
}
