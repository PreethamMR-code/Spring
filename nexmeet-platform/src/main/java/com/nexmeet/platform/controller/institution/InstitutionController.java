package com.nexmeet.platform.controller.institution;

import com.nexmeet.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/institution")
public class InstitutionController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        userService.findByEmail(auth.getName())
                .ifPresent(u -> model.addAttribute("currentUser", u));
        model.addAttribute("email", auth.getName());
        return "institution/dashboard";
    }

}
