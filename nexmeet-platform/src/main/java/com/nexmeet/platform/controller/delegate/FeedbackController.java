package com.nexmeet.platform.controller.delegate;


import com.nexmeet.platform.dto.FeedbackDto;
import com.nexmeet.platform.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    /*
     * Show feedback form for a specific conference.
     * Only accessible after conference has ended and
     * delegate has attended.
     */
    @GetMapping("/delegate/conference/{id}/feedback")
    public String showFeedbackForm(@PathVariable Long id,
                                   Model model,
                                   Authentication auth) {
        // Check if already submitted
        if (feedbackService.hasSubmittedFeedback(
                id, auth.getName())) {
            model.addAttribute("alreadySubmitted", true);
        }

        FeedbackDto dto = new FeedbackDto();
        dto.setConferenceId(id);
        model.addAttribute("dto", dto);
        model.addAttribute("conferenceId", id);
        return "delegate/feedback-form";
    }

    /*
     * Submit feedback.
     */

    @PostMapping("/delegate/conference/{id}/feedback")
    public String submitFeedback(
            @PathVariable Long id,
            @ModelAttribute("dto") FeedbackDto dto,
            Authentication auth,
            RedirectAttributes flash) {

        dto.setConferenceId(id);
        String result = feedbackService.submitFeedback(
                dto, auth.getName());

        switch (result) {
            case "SUCCESS":
                flash.addFlashAttribute("success",
                        "Thank you! Your feedback has been submitted.");
                return "redirect:/delegate/dashboard";
            case "ALREADY_SUBMITTED":
                flash.addFlashAttribute("error",
                        "You have already submitted feedback for this conference.");
                break;
            case "NOT_ATTENDED":
                flash.addFlashAttribute("error",
                        "Feedback is only available for delegates who attended.");
                break;
            case "CONFERENCE_NOT_ENDED":
                flash.addFlashAttribute("error",
                        "Feedback can only be submitted after the conference ends.");
                break;
            case "NOT_REGISTERED":
                flash.addFlashAttribute("error",
                        "You are not registered for this conference.");
                break;
            case "INVALID_RATING":
                flash.addFlashAttribute("error",
                        "Please select a valid rating (1-5).");
                break;
            default:
                flash.addFlashAttribute("error",
                        "Could not submit feedback: " + result);
        }
        return "redirect:/delegate/conference/" + id + "/feedback";
    }

}
