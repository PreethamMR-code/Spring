package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.service.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/*
 * Public conference pages — no login required.
 * /conferences       = list all approved conferences
 * /conference/{id}   = detail page for one conference
 */

@Controller
public class ConferenceController {

    @Autowired
    private ConferenceService conferenceService;

    @GetMapping("/conferences")
    public String listConferences(Model model){
        model.addAttribute("conferences", conferenceService.getApprovedConferences());
        return "pub/conferences";
    }

    @GetMapping("/conference/{id}")
    public String conferenceDetail(@PathVariable Long id, Model model){
        conferenceService.findById(id).ifPresent(c -> model.addAttribute("conference", c));
        return "pub/conference-detail";
    }
}
