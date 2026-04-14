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

/*
 * Adds unreadCount to every page model so navbar bell badge
 * always shows the correct number.
 *
 * NotificationService is injected via setter (not @Autowired)
 * because this interceptor is declared as a <bean> in XML,
 * not component-scanned. XML injection uses setter methods.
 */

public class NotificationInterceptor implements HandlerInterceptor {


    // Injected via XML setter injection — NOT @Autowired
    private NotificationService notificationService;

    public void setNotificationService(
            NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response,
                           Object handler,
                           ModelAndView modelAndView) {

        if (modelAndView == null) return;
        if (modelAndView.getViewName() == null) return;
        if (modelAndView.getViewName()
                .startsWith("redirect:")) return;

        Authentication auth = SecurityContextHolder
                .getContext().getAuthentication();

        if (auth != null && auth.isAuthenticated() &&
                !"anonymousUser".equals(
                        auth.getPrincipal().toString())) {
            try {
                long count = notificationService
                        .getUnreadCount(auth.getName());
                modelAndView.addObject("unreadCount", count);
            } catch (Exception e) {
                // Never crash pages due to notification error
                modelAndView.addObject("unreadCount", 0L);
            }
        } else {
            modelAndView.addObject("unreadCount", 0L);
        }
    }
}
