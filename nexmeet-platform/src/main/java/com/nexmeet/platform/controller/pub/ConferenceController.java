package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.dao.SessionDao;
import com.nexmeet.platform.dao.SpeakerDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.service.ConferenceService;
import com.nexmeet.platform.service.FeedbackService;
import com.nexmeet.platform.service.SessionService;
import com.nexmeet.platform.service.SpeakerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String conferenceDetail(@PathVariable Long id, Model model){
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
        });
        return "pub/conference-detail";
    }
}
