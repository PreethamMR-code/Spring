package com.nexmeet.platform.controller.admin;


import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.VerificationStatus;
import com.nexmeet.platform.service.CommissionService;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.NotificationService;
import com.nexmeet.platform.service.UserService;
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

    @Autowired
    private UserService userService;

    @Autowired
    private OrganizerDao organizerDao;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private CommissionService commissionService;

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {

        // Auto-complete any expired conferences first
        conferenceService.autoCompleteExpiredConferences();

        List<Conference> pending =
                conferenceService.getPendingConferences();
        long totalUsers = userService.countAllUsers();
        long activeConferences = conferenceService
                .countByStatus(ConferenceStatus.APPROVED);

        // Add currentUser for welcome message
        userService.findByEmail(auth.getName())
                .ifPresent(u -> model.addAttribute("currentUser", u));

        long pendingOrganizersCount = organizerDao
                .findByVerificationStatus(VerificationStatus.PENDING).size();

        model.addAttribute("pendingOrganizersCount",
                pendingOrganizersCount);

        model.addAttribute("totalRevenue",
                commissionService.getTotalPlatformEarnings());

        model.addAttribute("pendingConferences", pending);
        model.addAttribute("pendingCount", pending.size());
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("activeConferences", activeConferences);
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
    public String viewConference(@PathVariable Long id,
                                 Model model) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Not found"));
        model.addAttribute("conf", conf);

        // Pass flag whether end date has passed
        boolean endDatePassed = conf.getEndDate()
                .isBefore(java.time.LocalDateTime.now());
        model.addAttribute("endDatePassed", endDatePassed);

        model.addAttribute("platformEarnings",
                commissionService.calculatePlatformEarnings(id));
        model.addAttribute("organizerPayout",
                commissionService.calculateOrganizerPayout(id));
        model.addAttribute("baseFee",
                commissionService.getBaseFee(conf.getConferenceType()));
        model.addAttribute("perDelegateFee",
                commissionService.getPerDelegateFee(
                        conf.getConferenceType()));

        return "admin/conference-detail";
    }


    @GetMapping("/conferences")
    public String allConferences(@RequestParam(required = false) String status,
                                 Model model) {
        List<Conference> conferences;
        if (status != null && !status.isEmpty()) {
            conferences = conferenceService.findByStatus(
                    ConferenceStatus.valueOf(status));
        } else {
            conferences = conferenceService.getAllConferences();
        }
        model.addAttribute("conferences", conferences);
        model.addAttribute("selectedStatus", status);
        return "admin/conferences";
    }

    @GetMapping("/users")
    public String allUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }



    @GetMapping("/organizers")
    public String allOrganizers(Model model) {
        model.addAttribute("pendingOrganizers",
                organizerDao.findByVerificationStatus(
                        VerificationStatus.PENDING));
        model.addAttribute("approvedOrganizers",
                organizerDao.findByVerificationStatus(
                        VerificationStatus.APPROVED));
        return "admin/organizers";
    }

    @PostMapping("/organizer/{id}/approve")
    public String approveOrganizer(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        organizerDao.findByOrganizerId(id).ifPresent(org -> {
            org.setVerificationStatus(VerificationStatus.APPROVED);
            org.setVerifiedAt(java.time.LocalDateTime.now());
            userService.findByEmail(auth.getName())
                    .ifPresent(org::setVerifiedBy);
            organizerDao.update(org);

            // Notify organizer
            notificationService.createNotification(
                    org.getUser().getEmail(),
                    "Account Verified",
                    "Your organizer account has been verified! " +
                            "You can now create and submit conferences.",
                    "IN_APP"
            );
        });
        flash.addFlashAttribute("success",
                "Organizer approved successfully!");
        return "redirect:/admin/organizers";
    }

    @PostMapping("/organizer/{id}/reject")
    public String rejectOrganizer(
            @PathVariable Long id,
            @RequestParam String reason,
            RedirectAttributes flash) {
        organizerDao.findByOrganizerId(id).ifPresent(org -> {
            org.setVerificationStatus(VerificationStatus.REJECTED);
            org.setRejectionReason(reason);
            organizerDao.update(org);

            notificationService.createNotification(
                    org.getUser().getEmail(),
                    "Account Verification Rejected",
                    "Your organizer account was not verified. " +
                            "Reason: " + reason,
                    "IN_APP"
            );
        });
        flash.addFlashAttribute("error",
                "Organizer rejected.");
        return "redirect:/admin/organizers";
    }

//    Update AdminController to auto-complete and add manual button     //auto complete done in dashboard method
//    Adding manual complete endpoint
    @PostMapping("/conference/{id}/complete")
    public String completeConference(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            conferenceService.markAsCompleted(id, auth.getName());
            flash.addFlashAttribute("success",
                    "Conference marked as completed. " +
                            "Delegates have been notified.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Could not complete: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }

    @PostMapping("/conference/{id}/cancel")
    public String cancelConference(
            @PathVariable Long id,
            @RequestParam String reason,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            conferenceService.cancelConference(
                    id, auth.getName(), reason);
            flash.addFlashAttribute("success",
                    "Conference cancelled. All delegates notified.");
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }
        return "redirect:/admin/conference/" + id;
    }

    @PostMapping("/user/{id}/toggle-active")
    public String toggleUserActive(
            @PathVariable Long id,
            Authentication auth,
            RedirectAttributes flash) {
        // Prevent admin from deactivating themselves
        userService.findById(id).ifPresent(user -> {
            if (user.getEmail().equals(auth.getName())) {
                flash.addFlashAttribute("error",
                        "You cannot deactivate your own account.");
                return;
            }
            userService.toggleUserActive(id);
            flash.addFlashAttribute("success",
                    user.isActive()
                            ? "User deactivated successfully."
                            : "User activated successfully.");
        });
        return "redirect:/admin/users";
    }

    @GetMapping("/commission")
    public String commissionSettings(Model model) {
        model.addAttribute("settings",
                commissionService.getAllCommissionSettings());
        model.addAttribute("totalRevenue",
                commissionService.getTotalPlatformEarnings());
        return "admin/commission";
    }
}
