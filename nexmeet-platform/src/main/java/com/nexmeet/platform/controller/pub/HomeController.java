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
        /*
         * Real stats from DB — not hardcoded.
         * These power the hero section and trust bar.
         * What companies like Stripe do: show live numbers
         * to build social proof.
         */
        model.addAttribute("totalConferences",
                conferenceService.countByStatus(
                        ConferenceStatus.APPROVED)
                        + conferenceService.countByStatus(
                        ConferenceStatus.COMPLETED));

        model.addAttribute("totalUsers",
                userService.countAllUsers());

        model.addAttribute("totalOrganizers",
                userService.countByRole("ORGANIZER"));

        /*
         * Show up to 6 upcoming APPROVED conferences
         * sorted by start date ascending (soonest first).
         * Same pattern as Eventbrite's home page.
         */
        model.addAttribute("upcomingConferences",
                conferenceService.getUpcomingConferences(6));

        return "pub/home";
    }
}
