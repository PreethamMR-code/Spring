package com.nexmeet.platform.controller.organizer;

import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.dto.ConferenceCreateDto;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Organizer;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.service.ConferenceService;
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
}
