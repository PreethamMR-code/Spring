package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.dao.*;
import com.nexmeet.platform.entity.BulkUpload;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.InstitutionalAdmin;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/*
 * Public conference pages — no login required.
 * /conferences       = list all approved conferences
 * /conference/{id}   = detail page for one conference
 */

@Controller
public class ConferenceController {

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private SpeakerService speakerService;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private InstitutionalAdminDao institutionalAdminDao;

    @Autowired
    private BulkUploadService bulkUploadService;

    @Autowired
    private RegistrationService registrationService;




    @GetMapping("/conferences")
    public String listConferences(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String mode,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String free,
            Model model) {

        List<Conference> all = conferenceService.getApprovedConferences();

        List<Conference> filtered = all.stream()
                .filter(c -> {
                    if (search != null && !search.trim().isEmpty()) {
                        String s = search.toLowerCase();
                        return c.getTitle().toLowerCase().contains(s)
                                || (c.getDescription() != null &&
                                c.getDescription().toLowerCase().contains(s))
                                || (c.getCity() != null &&
                                c.getCity().toLowerCase().contains(s));
                    }
                    return true;
                })
                .filter(c -> type == null || type.isEmpty()
                        || c.getConferenceType().name().equals(type))
                .filter(c -> mode == null || mode.isEmpty()
                        || c.getMode().name().equals(mode))
                .filter(c -> city == null || city.isEmpty()
                        || (c.getCity() != null &&
                        c.getCity().toLowerCase().contains(city.toLowerCase())))
                .filter(c -> {
                    if (free == null || free.isEmpty()) return true;
                    return "true".equals(free) ? c.isFree() : !c.isFree();
                })
                .collect(Collectors.toList());

        List<String> cities = all.stream()
                .map(Conference::getCity)
                .filter(ct -> ct != null && !ct.isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());

        model.addAttribute("conferences", filtered);
        model.addAttribute("cities", cities);
        model.addAttribute("totalCount", all.size());
        model.addAttribute("filteredCount", filtered.size());
        model.addAttribute("search", search != null ? search : "");
        model.addAttribute("selectedType", type != null ? type : "");
        model.addAttribute("selectedMode", mode != null ? mode : "");
        model.addAttribute("selectedCity", city != null ? city : "");
        model.addAttribute("selectedFree", free != null ? free : "");
        return "pub/conferences";
    }

    @GetMapping("/conference/{id}")
    public String conferenceDetail(
            @PathVariable Long id,
            Model model,
        Authentication auth) {

        conferenceService.findById(id).ifPresent(c -> {

            model.addAttribute("conference", c);
            model.addAttribute("feedbackList",
                    feedbackService.getPublicFeedback(id));
            model.addAttribute("avgRating",
                    feedbackService.getAverageRating(id));
            model.addAttribute("feedbackCount",
                    feedbackService.getFeedbackCount(id));
            model.addAttribute("speakers",
                    speakerService.getSpeakersByConference(id));
            model.addAttribute("sessions",
                    sessionService.getSessionsByConference(id));

            /*
             * Compute registration availability flags.
             * Passed to JSP so the button shows the
             * correct state without logic in the template.
             *
             * Professional apps (Eventbrite, Konfhub) do:
             *   - Deadline passed → "Registration Closed"
             *   - At capacity     → "Sold Out"
             *   - Open            → "Register Now"
             */
            java.time.LocalDateTime now =
                    java.time.LocalDateTime.now();

            boolean deadlinePassed =
                    c.getRegistrationDeadline()
                            .isBefore(now);

            boolean isFull =
                    c.getMaxDelegates() > 0
                            && c.getRegisteredCount()
                            >= c.getMaxDelegates();

            boolean registrationOpen =
                    !deadlinePassed
                            && !isFull
                            && c.getStatus().name()
                            .equals("APPROVED");

            model.addAttribute("deadlinePassed",
                    deadlinePassed);
            model.addAttribute("isFull", isFull);
            model.addAttribute("registrationOpen",
                    registrationOpen);

            // Default to false for anonymous and non-delegate users.
            // ── Bug B: already-registered check ──────────────────
            // Service method owns the transaction — no session
            // boundary issues. Safe to call from controller.
            model.addAttribute("alreadyRegistered", false);

            if (auth != null
                    && auth.isAuthenticated()
                    && auth.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority()
                            .equals("ROLE_DELEGATE"))) {

                boolean already =
                        registrationService.isAlreadyRegistered(
                                c.getId(), auth.getName());
                model.addAttribute("alreadyRegistered", already);

                if (already) {
                    registrationService
                            .findByConferenceAndUserEmail(
                                    c.getId(), auth.getName())
                            .ifPresent(reg ->
                                    model.addAttribute(
                                            "myRegistration", reg));
                }
            }
            // ─────────────────────────────────────────────────────
        });

        return "pub/conference-detail";
    }

    /*
     * GET — show bulk upload form for institutional admin
     * Only verified institutional admins can access this.
     */

    @GetMapping("/conference/{id}/institution-bulk-upload")
    public String showInstitutionBulkUpload(
            @PathVariable Long id,
            Model model,
            Authentication auth) {

        Conference conference = conferenceService
                .findById(id)
                .orElse(null);

        if (conference == null
                || !conference.isBulkUploadAllowed()) {
            return "redirect:/conferences";
        }

        // Must be a verified institutional admin
        InstitutionalAdmin ia = institutionalAdminDao
                .findByUserEmail(auth.getName())
                .orElse(null);

        if (ia == null || !ia.isVerified()) {
            return "redirect:/institution/dashboard";
        }

        model.addAttribute("conference", conference);
        model.addAttribute("instAdmin", ia);

        return "institution/institution-bulk-upload";
    }


    /*
     * POST — process the uploaded file
     * Reuses BulkUploadService — same logic as organizer upload.
     */

    @PostMapping(
            value = "/conference/{id}/institution-bulk-upload",
            consumes = "multipart/form-data")
    public String processInstitutionBulkUpload(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file,
            Authentication auth,
            RedirectAttributes flash) {

        try {
            Conference conference = conferenceService
                    .findById(id)
                    .orElseThrow(() ->
                            new RuntimeException(
                                    "Conference not found"));

            InstitutionalAdmin ia = institutionalAdminDao
                    .findByUserEmail(auth.getName())
                    .orElseThrow(() ->
                            new RuntimeException(
                                    "Institutional admin not found"));

            if (!ia.isVerified()) {
                flash.addFlashAttribute("error",
                        "Your account is not yet verified.");
                return "redirect:/institution/dashboard";
            }

            // Reuse the same BulkUploadService
            BulkUpload result = bulkUploadService.processBulkUpload(
                    conference.getId(),
                    auth.getName(),   // institutional admin email as uploader
                    file
            );


            flash.addFlashAttribute("success", result);
        } catch (Exception e) {
            flash.addFlashAttribute("error",
                    "Upload failed: " + e.getMessage());
        }

        return "redirect:/conference/" + id
                + "/institution-bulk-upload";
    }

    @GetMapping("/conference/{id}/institution-bulk-upload/template")
    public void downloadTemplate(
            HttpServletResponse response) throws Exception {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition",
                "attachment; filename=student_upload_template.csv");
        response.getWriter().write(
                "full_name,email,phone\n" +
                        "Ravi Kumar,ravi@college.ac.in,9876543210\n" +
                        "Priya Sharma,priya@college.ac.in,\n"
        );
    }
}
