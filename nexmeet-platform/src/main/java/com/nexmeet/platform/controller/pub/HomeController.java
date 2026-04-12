package com.nexmeet.platform.controller.pub;


import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private UserService userService;

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        // Real stats for hero section
        model.addAttribute("totalConferences",
                conferenceService.countByStatus(
                        ConferenceStatus.APPROVED));
        model.addAttribute("totalUsers",
                userService.countAllUsers());
        return "pub/home";
    }
}
