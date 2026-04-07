package com.nexmeet.platform.config;


/*
 * This interceptor runs after EVERY controller method.
 * It adds unreadCount to the model so navbar.jsp can
 * show the notification badge count on every page.
 *
 * Why interceptor instead of putting it in every controller?
 * Because we'd have to add the same code to 15+ controllers.
 * One interceptor = one place = always consistent.
 */

import com.nexmeet.platform.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NotificationInterceptor implements HandlerInterceptor {

    @Autowired
    private NotificationService notificationService;

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response,
                           Object handler,
                           ModelAndView modelAndView) {

        // Only add to page requests (not redirects or REST)
        if (modelAndView == null) return;
        if (modelAndView.getViewName() == null) return;
        if (modelAndView.getViewName().startsWith("redirect:")) return;

        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        if (auth != null && auth.isAuthenticated() &&
                !"anonymousUser".equals(auth.getPrincipal())) {
            try {
                long count = notificationService
                        .getUnreadCount(auth.getName());
                modelAndView.addObject("unreadCount", count);
            } catch (Exception e) {
                // Silently ignore — don't break pages
                // if notification service fails
                modelAndView.addObject("unreadCount", 0L);
            }
        }
    }
}
