package com.nexmeet.platform.controller.institution;

import com.nexmeet.platform.dao.InstitutionDao;
import com.nexmeet.platform.dao.InstitutionalAdminDao;
import com.nexmeet.platform.dto.InstitutionalAdminProfileDto;
import com.nexmeet.platform.entity.Institution;
import com.nexmeet.platform.entity.InstitutionalAdmin;
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

@Controller
@RequestMapping("/institution")
public class InstitutionController {

    @Autowired
    private UserService userService;

    @Autowired
    private InstitutionDao institutionDao;

    @Autowired
    private InstitutionalAdminDao institutionalAdminDao;

    @GetMapping("/dashboard")
    public String dashboard(Model model,
                            Authentication auth) {
        String email = auth.getName();

        // If no profile yet — redirect to setup
        if (!institutionalAdminDao
                .existsByUserEmail(email)) {
            return "redirect:/institution/profile/setup";
        }

        userService.findByEmail(email)
                .ifPresent(u ->
                        model.addAttribute("currentUser", u));

        institutionalAdminDao.findByUserEmail(email)
                .ifPresent(ia ->
                        model.addAttribute("instAdmin", ia));

        return "institution/dashboard";
    }

    /*
     * Profile setup page — shown on first login.
     * Institutional admin picks their institution
     * and enters their job details.
     */
    @GetMapping("/profile/setup")
    public String showProfileSetup(
            Model model,
            Authentication auth) {

        if (institutionalAdminDao.existsByUserEmail(
                auth.getName())) {
            return "redirect:/institution/dashboard";
        }

        model.addAttribute("dto",
                new InstitutionalAdminProfileDto());
        model.addAttribute("institutions",
                institutionDao.findByActive(true));
        return "institution/profile-setup";
    }

    @PostMapping("/profile/setup")
    public String saveProfileSetup(
            @ModelAttribute("dto")
            InstitutionalAdminProfileDto dto,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            if (!institutionalAdminDao
                    .existsByUserEmail(auth.getName())) {
                User user = userService
                        .findByEmail(auth.getName())
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "User not found"));

                Institution institution =
                        institutionDao
                                .findById(dto.getInstitutionId())
                                .orElseThrow(() ->
                                        new RuntimeException(
                                                "Institution not found"));

                InstitutionalAdmin ia =
                        new InstitutionalAdmin();
                ia.setUser(user);
                ia.setInstitution(institution);
                ia.setJobTitle(dto.getJobTitle());
                ia.setDepartment(dto.getDepartment());
                ia.setVerified(false);
                institutionalAdminDao.save(ia);
            }
            flash.addFlashAttribute("success",
                    "Profile saved! " +
                            "Awaiting admin verification.");
            return "redirect:/institution/dashboard";
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Error: " + e.getMessage());
            return "redirect:/institution/profile/setup";
        }
    }



}
