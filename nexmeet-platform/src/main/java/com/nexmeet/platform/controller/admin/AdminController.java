package com.nexmeet.platform.controller.admin;


import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.service.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ConferenceService conferenceService;


    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        List<Conference> pending = conferenceService.getPendingConferences();
        model.addAttribute("pendingConferences", pending);
        model.addAttribute("pendingCount", pending.size());
        return "admin/dashboard";
    }

    @PostMapping("/conference/{id}/approve")
    public String approve(@PathVariable Long id,
                          Authentication auth,
                          RedirectAttributes flash) {
        conferenceService.approveConference(id, auth.getName());
        flash.addFlashAttribute("success", "Conference approved!");
        return "redirect:/admin/dashboard";
    }

    @PostMapping("/conference/{id}/reject")
    public String reject(@PathVariable Long id,
                         @RequestParam String reason,
                         Authentication auth,
                         RedirectAttributes flash) {
        conferenceService.rejectConference(id, null, reason);
        flash.addFlashAttribute("error", "Conference rejected.");
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/conference/{id}")
    public String viewConference(@PathVariable Long id, Model model) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        model.addAttribute("conf", conf);
        return "admin/conference-detail";
    }
}
