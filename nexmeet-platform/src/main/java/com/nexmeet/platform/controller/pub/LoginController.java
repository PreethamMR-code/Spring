package com.nexmeet.platform.controller.pub;

import com.nexmeet.platform.service.PasswordResetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    @Autowired
    private PasswordResetService passwordResetService;

    @GetMapping("/login")
    public String loginPage() {
        return "pub/login";
    }

    /* ── FORGOT PASSWORD ─────────────────────────── */

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "pub/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(
            @RequestParam("email") String email,
            RedirectAttributes flash) {

        /*
         * Service is silent on unknown emails (security).
         * We ALWAYS show the same success message so
         * attackers cannot enumerate registered emails.
         */
        passwordResetService.initiateReset(email.trim());

        flash.addFlashAttribute("success",
                "If that email is registered, " +
                        "you'll receive a reset link shortly. " +
                        "Check your inbox (and spam folder).");

        return "redirect:/forgot-password";
    }

    /* ── RESET PASSWORD ──────────────────────────── */

    @GetMapping("/reset-password")
    public String resetPasswordPage(
            @RequestParam("token") String token,
            Model model,
            RedirectAttributes flash) {

        if (!passwordResetService.isTokenValid(token)) {
            flash.addFlashAttribute("error",
                    "This reset link is invalid or " +
                            "has expired. Please request " +
                            "a new one.");
            return "redirect:/forgot-password";
        }

        model.addAttribute("token", token);
        return "pub/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(
            @RequestParam("token") String token,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes flash) {

        // Client-side already checks this, but always
        // validate server-side too — never trust the browser
        if (!newPassword.equals(confirmPassword)) {
            flash.addFlashAttribute("error",
                    "Passwords do not match.");
            flash.addFlashAttribute("token", token);
            return "redirect:/reset-password?token=" + token;
        }

        if (newPassword.trim().length() < 8) {
            flash.addFlashAttribute("error",
                    "Password must be at least 8 characters.");
            flash.addFlashAttribute("token", token);
            return "redirect:/reset-password?token=" + token;
        }

        try {
            passwordResetService.resetPassword(
                    token, newPassword);
            flash.addFlashAttribute("success",
                    "✅ Password reset successful! " +
                            "You can now sign in with your new password.");
            return "redirect:/login";

        } catch (RuntimeException e) {
            flash.addFlashAttribute("error",
                    e.getMessage());
            return "redirect:/forgot-password";
        }
    }
}