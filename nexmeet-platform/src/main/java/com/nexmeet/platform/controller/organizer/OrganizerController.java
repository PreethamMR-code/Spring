package com.nexmeet.platform.controller.organizer;

import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dto.ConferenceCreateDto;
import com.nexmeet.platform.entity.Attendance;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Organizer;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.AttendanceService;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.RegistrationService;
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
}
