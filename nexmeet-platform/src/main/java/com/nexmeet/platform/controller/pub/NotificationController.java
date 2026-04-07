package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    /*
     * Full notifications page — shows all notifications
     * and marks them all as read on visit.
     */
    @GetMapping
    public String notifications(Model model,
                                Authentication auth) {
        String email = auth.getName();
        model.addAttribute("notifications",
                notificationService.getNotifications(email));

        // Auto mark all as read when page is opened
        notificationService.markAllAsRead(email);
        return "common/notifications";
    }

    /*
     * Mark a single notification as read via AJAX or form.
     */
    @PostMapping("/{id}/read")
    public String markRead(@PathVariable Long id,
                           Authentication auth,
                           RedirectAttributes flash) {
        notificationService.markAsRead(id, auth.getName());
        return "redirect:/notifications";
    }

    /*
     * Mark all as read explicitly.
     */
    @PostMapping("/read-all")
    public String markAllRead(Authentication auth) {
        notificationService.markAllAsRead(auth.getName());
        return "redirect:/notifications";
    }

}
