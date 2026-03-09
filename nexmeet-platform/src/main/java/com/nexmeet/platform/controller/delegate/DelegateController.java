package com.nexmeet.platform.controller.delegate;

import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
        model.addAttribute("myRegistrations", registrations.size());
        model.addAttribute("registrations", registrations);
        model.addAttribute("email", email);
        return "delegate/dashboard";
    }
}
