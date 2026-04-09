package com.nexmeet.platform.controller.pub;


/*
 * ProfileController handles view/edit profile for ALL roles.
 * GET  /profile       → show profile page with current data
 * POST /profile       → update name + phone
 * POST /profile/password → change password
 * POST /profile/organizer → update organizer-specific details
 *
 * One controller, three POST endpoints, one view.
 * The JSP shows/hides organizer section based on role.
 */

import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dto.ProfileDto;
import com.nexmeet.platform.entity.Organizer;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrganizerDao organizerDao;

    @GetMapping
    public String showProfile(Model model, Authentication auth) {
        String email = auth.getName();

        User user = userService.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Build ProfileDto pre-filled with current data
        ProfileDto dto = new ProfileDto();
        dto.setFullName(user.getFullName());
        dto.setPhone(user.getPhone());

        model.addAttribute("user", user);
        model.addAttribute("dto", dto);

        // Check if organizer and load org details
        Optional<Organizer> organizerOpt =
                organizerDao.findByUserEmail(email);

        if (organizerOpt.isPresent()) {
            Organizer org = organizerOpt.get();
            dto.setOrganizationName(org.getOrganizationName());
            dto.setOrganizationType(org.getOrganizationType());
            dto.setWebsiteUrl(org.getWebsiteUrl());
            dto.setAddress(org.getAddress());
            dto.setCity(org.getCity());
            dto.setState(org.getState());
            dto.setPincode(org.getPincode());
            model.addAttribute("organizer", org);
        }

        return "common/profile";
    }

    /*
     * Update basic profile — name and phone.
     * Works for ALL roles.
     */

    @PostMapping
    public String updateProfile(
            @ModelAttribute("dto") ProfileDto dto,
            Authentication auth,
            RedirectAttributes flash) {

        try {
            if (dto.getFullName() == null ||
                    dto.getFullName().trim().isEmpty()) {
                flash.addFlashAttribute("error",
                        "Full name cannot be empty.");
                return "redirect:/profile";
            }

            userService.updateProfile(
                    auth.getName(),
                    dto.getFullName().trim(),
                    dto.getPhone());

            flash.addFlashAttribute("success",
                    "Profile updated successfully!");

        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Update failed: " + e.getMessage());
        }
        return "redirect:/profile";
    }

    /*
     * Change password — requires current password verification.
     */

    @PostMapping("/password")
    public String changePassword(
            @ModelAttribute("dto") ProfileDto dto,
            Authentication auth,
            RedirectAttributes flash) {

        if (dto.getNewPassword() == null ||
                dto.getNewPassword().length() < 6) {
            flash.addFlashAttribute("pwError",
                    "New password must be at least 6 characters.");
            return "redirect:/profile";
        }

        if (!dto.getNewPassword()
                .equals(dto.getConfirmNewPassword())) {
            flash.addFlashAttribute("pwError",
                    "New passwords do not match.");
            return "redirect:/profile";
        }

        boolean changed = userService.changePassword(
                auth.getName(),
                dto.getCurrentPassword(),
                dto.getNewPassword());

        if (changed) {
            flash.addFlashAttribute("pwSuccess",
                    "Password changed successfully!");
        } else {
            flash.addFlashAttribute("pwError",
                    "Current password is incorrect.");
        }
        return "redirect:/profile";
    }

    /*
     * Update organizer org details — organizer role only.
     */

    @PostMapping("/organizer")
    public String updateOrganizerProfile(
            @ModelAttribute("dto") ProfileDto dto,
            Authentication auth,
            RedirectAttributes flash) {

        try {
            Optional<Organizer> organizerOpt =
                    organizerDao.findByUserEmail(auth.getName());

            if (!organizerOpt.isPresent()) {
                flash.addFlashAttribute("orgError",
                        "Organizer profile not found.");
                return "redirect:/profile";
            }

            Organizer org = organizerOpt.get();
            org.setOrganizationName(dto.getOrganizationName());
            org.setOrganizationType(dto.getOrganizationType());
            org.setWebsiteUrl(dto.getWebsiteUrl());
            org.setAddress(dto.getAddress());
            org.setCity(dto.getCity());
            org.setState(dto.getState());
            org.setPincode(dto.getPincode());
            organizerDao.update(org);

            flash.addFlashAttribute("orgSuccess",
                    "Organization details updated!");

        } catch (Exception e) {
            flash.addFlashAttribute("orgError",
                    "Update failed: " + e.getMessage());
        }
        return "redirect:/profile";
    }
}
