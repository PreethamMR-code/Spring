package com.nexmeet.platform.controller.organizer;

import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dto.ConferenceCreateDto;
import com.nexmeet.platform.dto.OrganizerProfileDto;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/organizer")
public class OrganizerController {

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private OrganizerDao organizerDao;

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private UserService userService;

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping("/dashboard")
    public String dashboard(Model model, Authentication auth) {
        String email = auth.getName();
        Optional<Organizer> organizerOpt = organizerDao.findByUserEmail(email);

        if (organizerOpt.isPresent()) {
            Organizer organizer = organizerOpt.get();
            long myConferences = conferenceService.countByOrganizer(organizer.getId());
            long pendingApproval = conferenceService.countByOrganizerAndStatus(
                    organizer.getId(), ConferenceStatus.SUBMITTED);
            model.addAttribute("myConferences", myConferences);
            model.addAttribute("pendingApproval", pendingApproval);
        }

        model.addAttribute("organizer", email);
        return "organizer/dashboard";
    }

    @GetMapping("/conferences")
    public String myConferences(Model model, Authentication auth) {
        String email = auth.getName();
        Optional<Organizer> organizerOpt = organizerDao.findByUserEmail(email);

        if (organizerOpt.isPresent()) {
            List<Conference> conferences = conferenceService
                    .getConferencesByOrganizer(organizerOpt.get().getId());
            model.addAttribute("conferences", conferences);
        }

        return "organizer/my-conferences";
    }

    @GetMapping("/conference/create")
    public String showCreateForm(Model model) {
        model.addAttribute("dto", new ConferenceCreateDto());
        return "organizer/create-conference";
    }

    @PostMapping("/conference/create")
    public String createConference(@ModelAttribute("dto") ConferenceCreateDto dto,
                                   @RequestParam("action") String action,
                                   Authentication auth,
                                   RedirectAttributes flash) {
        try {
            String email = auth.getName();
            Optional<Organizer> organizerOpt = organizerDao.findByUserEmail(email);

            if (!organizerOpt.isPresent()) {
                flash.addFlashAttribute("error", "Organizer profile not found.");
                return "redirect:/organizer/conference/create";
            }

            Organizer organizer = organizerOpt.get();

            Conference conf = new Conference();
            conf.setOrganizer(organizer);
            conf.setTitle(dto.getTitle());
            conf.setDescription(dto.getDescription());
            conf.setConferenceType(dto.getConferenceType());
            conf.setMode(dto.getMode());
            conf.setTargetAudience(dto.getTargetAudience());
            conf.setTargetDomains(dto.getTargetDomains());
            conf.setStartDate(dto.getStartDate());
            conf.setEndDate(dto.getEndDate());
            conf.setRegistrationDeadline(dto.getRegistrationDeadline());
            conf.setVenueName(dto.getVenueName());
            conf.setVenueAddress(dto.getVenueAddress());
            conf.setCity(dto.getCity());
            conf.setState(dto.getState());
            conf.setStreamingLink(dto.getStreamingLink());
            conf.setMaxDelegates(dto.getMaxDelegates());
            conf.setFree(dto.isFree());
            conf.setDelegateFee(dto.getDelegateFee());
            conf.setCertificateEnabled(dto.isCertificateEnabled());
            conf.setQrCheckinEnabled(dto.isQrCheckinEnabled());
            conf.setBulkUploadAllowed(dto.isBulkUploadAllowed());
            conf.setStatus("SUBMIT".equals(action)
                    ? ConferenceStatus.SUBMITTED : ConferenceStatus.DRAFT);

            conferenceService.save(conf);

            flash.addFlashAttribute("success", "SUBMIT".equals(action)
                    ? "Conference submitted for admin approval!"
                    : "Conference saved as draft.");
            return "redirect:/organizer/conferences";

        } catch (Exception e) {
            flash.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/organizer/conference/create";
        }
    }

    @GetMapping("/conference/{id}/attendance")
    public String attendancePage(@PathVariable Long id, Model model) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() -> new RuntimeException("Conference not found"));
        List<Attendance> attended = attendanceService.getAttendanceByConference(id);
        model.addAttribute("conf", conf);
        model.addAttribute("attended", attended);
        model.addAttribute("attendedCount", attended.size());
        return "organizer/attendance";
    }

    @PostMapping("/conference/{id}/attendance/mark")
    public String markAttendance(@PathVariable Long id,
                                 @RequestParam String registrationNumber,
                                 Authentication auth,
                                 RedirectAttributes flash) {
        String result = attendanceService.markAttendance(
                registrationNumber, id, auth.getName());

        switch (result) {
            case "SUCCESS":
                flash.addFlashAttribute("success",
                        "Delegate checked in successfully!");
                break;
            case "ALREADY_CHECKED_IN":
                flash.addFlashAttribute("error",
                        "This delegate is already checked in.");
                break;
            case "NOT_FOUND":
                flash.addFlashAttribute("error",
                        "Registration number not found.");
                break;
            case "WRONG_CONFERENCE":
                flash.addFlashAttribute("error",
                        "This ticket is for a different conference.");
                break;
            case "NOT_CONFIRMED":
                flash.addFlashAttribute("error",
                        "Registration is not confirmed.");
                break;
            default:
                flash.addFlashAttribute("error", "Unknown error.");
        }
        return "redirect:/organizer/conference/" + id + "/attendance";
    }

    @GetMapping("/conference/{id}/delegates")
    public String viewDelegates(@PathVariable Long id,
                                Model model,
                                Authentication auth) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() -> new RuntimeException("Conference not found"));

        // Security: only the organizer who owns this conference
        String email = auth.getName();
        if (!conf.getOrganizer().getUser().getEmail().equals(email)) {
            return "redirect:/organizer/conferences";
        }

        List<Registration> registrations = registrationService.findByConferenceId(id);

        long confirmedCount = registrations.stream()
                .filter(r -> r.getStatus() == RegistrationStatus.CONFIRMED)
                .count();
        long cancelledCount = registrations.stream()
                .filter(r -> r.getStatus() == RegistrationStatus.CANCELLED)
                .count();

        model.addAttribute("conf", conf);
        model.addAttribute("registrations", registrations);
        model.addAttribute("confirmedCount", confirmedCount);
        model.addAttribute("cancelledCount", cancelledCount);
        return "organizer/delegates";
    }

    @GetMapping("/conference/{id}/edit")
    public String showEditForm(@PathVariable Long id,
                               Model model,
                               Authentication auth) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));

        // Security: only owning organizer
        if (!conf.getOrganizer().getUser().getEmail().equals(auth.getName())) {
            return "redirect:/organizer/conferences";
        }

        // Only DRAFT or REJECTED can be edited
        if (conf.getStatus() != ConferenceStatus.DRAFT &&
                conf.getStatus() != ConferenceStatus.REJECTED) {
            return "redirect:/organizer/conferences";
        }

        // Map entity to DTO for form
        ConferenceCreateDto dto = new ConferenceCreateDto();
        dto.setTitle(conf.getTitle());
        dto.setDescription(conf.getDescription());
        dto.setConferenceType(conf.getConferenceType());
        dto.setMode(conf.getMode());
        dto.setTargetAudience(conf.getTargetAudience());
        dto.setTargetDomains(conf.getTargetDomains());
        dto.setStartDate(conf.getStartDate());
        dto.setEndDate(conf.getEndDate());
        dto.setRegistrationDeadline(conf.getRegistrationDeadline());
        dto.setVenueName(conf.getVenueName());
        dto.setVenueAddress(conf.getVenueAddress());
        dto.setCity(conf.getCity());
        dto.setState(conf.getState());
        dto.setStreamingLink(conf.getStreamingLink());
        dto.setMaxDelegates(conf.getMaxDelegates());
        dto.setFree(conf.isFree());
        dto.setDelegateFee(conf.getDelegateFee());
        dto.setCertificateEnabled(conf.isCertificateEnabled());
        dto.setQrCheckinEnabled(conf.isQrCheckinEnabled());
        dto.setBulkUploadAllowed(conf.isBulkUploadAllowed());

        model.addAttribute("dto", dto);
        model.addAttribute("confId", id);
        model.addAttribute("currentStatus", conf.getStatus());
        return "organizer/edit-conference";
    }

    @PostMapping("/conference/{id}/edit")
    public String updateConference(@PathVariable Long id,
                                   @ModelAttribute("dto") ConferenceCreateDto dto,
                                   @RequestParam String action,
                                   Authentication auth,
                                   RedirectAttributes flash) {
        try {
            Conference conf = conferenceService.findById(id)
                    .orElseThrow(() -> new RuntimeException("Not found"));

            // Security check
            if (!conf.getOrganizer().getUser().getEmail().equals(auth.getName())) {
                flash.addFlashAttribute("error", "Unauthorized.");
                return "redirect:/organizer/conferences";
            }

            // Only DRAFT or REJECTED can be edited
            if (conf.getStatus() != ConferenceStatus.DRAFT &&
                    conf.getStatus() != ConferenceStatus.REJECTED) {
                flash.addFlashAttribute("error", "This conference cannot be edited.");
                return "redirect:/organizer/conferences";
            }

            // Update all fields
            conf.setTitle(dto.getTitle());
            conf.setDescription(dto.getDescription());
            conf.setConferenceType(dto.getConferenceType());
            conf.setMode(dto.getMode());
            conf.setTargetAudience(dto.getTargetAudience());
            conf.setTargetDomains(dto.getTargetDomains());
            conf.setStartDate(dto.getStartDate());
            conf.setEndDate(dto.getEndDate());
            conf.setRegistrationDeadline(dto.getRegistrationDeadline());
            conf.setVenueName(dto.getVenueName());
            conf.setVenueAddress(dto.getVenueAddress());
            conf.setCity(dto.getCity());
            conf.setState(dto.getState());
            conf.setStreamingLink(dto.getStreamingLink());
            conf.setMaxDelegates(dto.getMaxDelegates());
            conf.setFree(dto.isFree());
            conf.setDelegateFee(dto.getDelegateFee());
            conf.setCertificateEnabled(dto.isCertificateEnabled());
            conf.setQrCheckinEnabled(dto.isQrCheckinEnabled());
            conf.setBulkUploadAllowed(dto.isBulkUploadAllowed());

            if ("SUBMIT".equals(action)) {
                conf.setStatus(ConferenceStatus.SUBMITTED);
                conf.setRejectionReason(null);
            } else {
                conf.setStatus(ConferenceStatus.DRAFT);
            }

            conferenceService.update(conf);

            flash.addFlashAttribute("success", "SUBMIT".equals(action)
                    ? "Conference resubmitted for approval!"
                    : "Conference saved as draft.");
            return "redirect:/organizer/conferences";

        } catch (Exception e) {
            flash.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/organizer/conference/" + id + "/edit";
        }
    }

    @GetMapping("/conference/{id}")
    public String viewConference(@PathVariable Long id,
                                 Model model,
                                 Authentication auth) {
        Conference conf = conferenceService.findById(id)
                .orElseThrow(() -> new RuntimeException("Conference not found"));

        // Security: only owning organizer
        if (!conf.getOrganizer().getUser().getEmail().equals(auth.getName())) {
            return "redirect:/organizer/conferences";
        }

        long registeredCount = conf.getRegisteredCount();
        long attendedCount = attendanceService.getAttendanceByConference(id).size();

        model.addAttribute("conf", conf);
        model.addAttribute("attendedCount", attendedCount);
        model.addAttribute("feedbackList",
                feedbackService.getAllFeedback(id));
        model.addAttribute("avgRating",
                feedbackService.getAverageRating(id));
        model.addAttribute("feedbackCount",
                feedbackService.getFeedbackCount(id));
        return "organizer/conference-detail";
    }

    @GetMapping("/profile/setup")
    public String showProfileSetup(Model model, Authentication auth) {
        // If profile already exists, skip to dashboard
        if (organizerDao.existsByUserEmail(auth.getName())) {
            return "redirect:/organizer/dashboard";
        }
        model.addAttribute("dto", new OrganizerProfileDto());
        return "organizer/profile-setup";
    }

    @PostMapping("/profile/setup")
    public String saveProfileSetup(
            @ModelAttribute("dto") OrganizerProfileDto dto,
            Authentication auth,
            RedirectAttributes flash) {
        try {
            if (!organizerDao.existsByUserEmail(auth.getName())) {
                // Get the logged-in user
                User user =
                        userService.findByEmail(auth.getName())
                                .orElseThrow(() -> new RuntimeException("User not found"));

                Organizer organizer = new Organizer();
                organizer.setUser(user);
                organizer.setOrganizationName(dto.getOrganizationName());
                organizer.setOrganizationType(dto.getOrganizationType());
                organizer.setWebsiteUrl(dto.getWebsiteUrl());
                organizer.setAddress(dto.getAddress());
                organizer.setCity(dto.getCity());
                organizer.setState(dto.getState());
                organizer.setPincode(dto.getPincode());
                organizer.setVerificationStatus(
                        com.nexmeet.platform.enums.VerificationStatus.PENDING);
                organizerDao.save(organizer);
            }
            flash.addFlashAttribute("success",
                    "Profile saved! Your account is pending admin verification.");
            return "redirect:/organizer/dashboard";
        } catch (Exception e) {
            flash.addFlashAttribute("error", "Error: " + e.getMessage());
            return "redirect:/organizer/profile/setup";
        }
    }
}
