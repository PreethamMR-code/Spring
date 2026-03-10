package com.nexmeet.platform.controller.pub;


/*
 * This controller handles the public registration page.
 * GET  /register → show the empty form
 * POST /register → process the form submission
 *
 * @Controller means this class handles HTTP requests and returns view names.
 * Spring MVC maps the view name to /WEB-INF/views/pub/register.jsp
 */

import com.nexmeet.platform.dto.RegisterDto;
import com.nexmeet.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RegisterController {

    @Autowired
    private UserService userService;

    /*
     * GET /register
     * Shows the registration form.
     *
     * We add an empty RegisterDto to the model so the JSP form
     * can bind to it using Spring's form tags.
     * th:object or spring:form needs an object pre-placed in model.
     */

    @GetMapping("/register")
    public String showRegisterForm(Model model){
        model.addAttribute("registerDto", new RegisterDto());
        return "pub/register";
    }

    /*
     * POST /register
     * Processes the form submission.
     *
     * @ModelAttribute maps the submitted form fields to the RegisterDto object.
     * Spring MVC matches form field names to DTO field names automatically.
     *
     * RedirectAttributes allows us to pass a one-time flash message
     * to the next page after a redirect.
     * Flash messages survive ONE redirect then disappear automatically.
     */

    @PostMapping("/register")
    public String processRegister(
            @ModelAttribute("registerDto") RegisterDto dto,
            RedirectAttributes redirectAttributes,
            Model model) {

        // Validation 1: Check email not empty
        if (dto.getEmail() == null || dto.getEmail().trim().isEmpty()) {
            model.addAttribute("error", "Email is required.");
            return "pub/register";
        }

        // Validation 2: Check passwords match
        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("registerDto", dto);
            return "pub/register";
        }

        // Validation 3: Password length
        if (dto.getPassword().length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters.");
            model.addAttribute("registerDto", dto);
            return "pub/register";
        }

        // Validation 4: Email already taken
        if (userService.isEmailTaken(dto.getEmail().trim())) {
            model.addAttribute("error", "This email is already registered. Please login.");
            model.addAttribute("registerDto", dto);
            return "pub/register";
        }

        try {
            // All checks passed — create the user in database
            userService.registerUser(dto.getFullName(), dto.getEmail().trim(), dto.getPassword());

            /*
             * PRG Pattern (Post-Redirect-Get):
             * After a successful form POST, always REDIRECT instead of
             * returning a view directly.
             * Why? If user refreshes the page, it won't resubmit the form.
             *
             * redirectAttributes.addFlashAttribute() stores a message
             * in the session for ONE redirect only, then clears itself.
             */
            redirectAttributes.addFlashAttribute("success",
                    "Registration successful! Please login.");
            return "redirect:/login";

        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("registerDto", dto);
            return "pub/register";
        }
    }

}
