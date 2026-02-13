package com.xworkz.model.controller;

import com.xworkz.model.DTO.RegistrationDTO;
import com.xworkz.model.entity.RegistrationEntity;
import com.xworkz.model.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;

@Controller
public class XworkzController {

    @Autowired
    private RegistrationService registrationService;

    // Home page
    @GetMapping("")
    public String home() {
        return "index";
    }

    // Show signup page
    @GetMapping("signUp")
    public String signUpPage() {
        return "signUp";
    }

    // Show sign in page
    @GetMapping("signIn")
    public String signInPage() {
        return "signIn";
    }

    // Show OTP sign in page
    @GetMapping("SignInWithOTP")
    public String signInWithOTPPage() {
        return "SignInWithOTP";
    }

    @PostMapping("signUp")
    public ModelAndView createAccount(@Valid RegistrationDTO registrationDTO, BindingResult bindingResult, ModelAndView mv) {
        mv.setViewName("signUp");
        mv.addObject("dto", registrationDTO);

        if (bindingResult.hasErrors()) {
            if (bindingResult.hasFieldErrors("name")) {
                mv.addObject("nameError", bindingResult.getFieldError("name").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("email")) {
                mv.addObject("emailError", bindingResult.getFieldError("email").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("phone")) {
                mv.addObject("phoneError", bindingResult.getFieldError("phone").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("age")) {
                mv.addObject("ageError", bindingResult.getFieldError("age").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("gender")) {
                mv.addObject("genderError", bindingResult.getFieldError("gender").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("address")) {
                mv.addObject("addressError", bindingResult.getFieldError("address").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("password")) {
                mv.addObject("passwordError", bindingResult.getFieldError("password").getDefaultMessage());
            }
            if (bindingResult.hasFieldErrors("confirmPassword")) {
                mv.addObject("confirmPasswordError", bindingResult.getFieldError("confirmPassword").getDefaultMessage());
            }
            return mv;
        }

        if (!registrationDTO.getPassword().equals(registrationDTO.getConfirmPassword())) {
            mv.addObject("confirmPasswordError", "Passwords do not match");
            return mv;
        }


        boolean saved = registrationService.validateAndSave(registrationDTO);

        if (saved) {
            mv.setViewName("signIn");
            mv.addObject("msg", "Account created successfully! Please login.");
            mv.addObject("dto", new RegistrationDTO());
        } else {
            mv.addObject("error", "Email already exists or registration failed");
        }
        return mv;
    }

    @GetMapping("checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam String email){

        boolean exists = registrationService.isEmailExists(email);
        System.out.println("Checking email: [" + email + "] | Exists in DB: " + exists);
        return exists? "exists" : "not_exists";
    }


//    using forEach we can di validation for all

//            bindingResult.getFieldErrors().forEach(error -> {
//                model.addAttribute(
//                        error.getField() + "Error",
//                        error.getDefaultMessage()
//                );
//            });
//
//            model.addAttribute("error", "Please fix the errors below");
//            return "signup";
//        }
//
//        // Password match validation
//        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
//            model.addAttribute("confirmPasswordError", "Passwords do not match");
//            model.addAttribute("error", "Please fix the errors below");
//            return "signup";
//        }
//
//        // Save student
//        boolean saved = registrationService.register(dto);
//
//        if (saved) {
//            model.addAttribute("msg", "Account created successfully");
//            return "login";
//        }
//
//        // Email already exists
//        model.addAttribute("error", "Email already exists");
//        return "signup";
//    }

    // ================= LOGIN =================


    @PostMapping("login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               Model model,
                               HttpSession session) {

        // check if email exists
//        RegistrationEntity entity = registrationService.findByEmail(email);

//        if (email == null || email.trim().isEmpty()) {
//            model.addAttribute("error", "Please enter your email");
//            return "login";
//        }

        boolean valid = registrationService.validateLogin(email, password);

        if (valid) {
            registrationService.setCountToZero(email);
            RegistrationEntity registration = registrationService.getUserByEmail(email);

            if (registration != null) {

            session.setAttribute("name",  registration.getName());
            session.setAttribute("email", registration.getEmail());

            if (registration.getProfileImage() != null) {
                session.setAttribute("fileId", registration.getProfileImage().getId());
            }

            model.addAttribute("name",  registration.getName());
            model.addAttribute("email", registration.getEmail());
        }

            return "Home";
        }else {
            // email exists but wrong credentials
            int count = registrationService.getCount(email);
            model.addAttribute("email", email);

            if (count >= 2) {
                model.addAttribute("disableLogin", true);
                model.addAttribute("showForgot", true);
                model.addAttribute("error", "Account locked due to multiple failed attempts. Please reset your password.");
            } else {
                registrationService.updateCount(email);
                model.addAttribute("error", "Invalid email or password. Attempt " + (count + 1) + " of 3");
            }
            return "signIn";
        }
    }


        // email exists but wrong credentials
      //  int count = registrationService.incrementLoginCount(email);

//        if (count >= 3) {
//            model.addAttribute("error", "Account blocked. Login using OTP.");
//            model.addAttribute("showOtp", true);
//            model.addAttribute("userEmail", email);
//            return "login";
//        }
//
//        model.addAttribute("error", "Invalid password (" + count + "/3)");
//        return "login";
//    }


    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Clears name, email, fileId — everything
        return "redirect:/signIn";
    }


    @PostMapping("sendOTP")
    public String sendOtp(@RequestParam String email, Model model) {


        System.out.println("Sending OTP to: " + email);


        boolean isSent = registrationService.sendOtp(email);
        model.addAttribute("email", email);

        if (isSent) {
            System.out.println("OTP sent successfully");
            model.addAttribute("msg", "OTP sent successfully to your email!");
        } else {
            model.addAttribute("msgUnsuccess", "Failed to send OTP. Please check your email address.");
        }
        return "SignInWithOTP";
    }

// ================= VERIFY OTP =================

@PostMapping("signInWithOTP")
public String validateOtpLogin(@RequestParam String email,
                               @RequestParam String otp,
                               Model model) {

    model.addAttribute("email", email);

    boolean isValid = registrationService.checkOptLogin(email, otp);

    if (isValid) {
        System.out.println("OTP validated Successfully");
        return "signInUpdatePassword";
    } else {
        System.out.println("OTP validation failed");
        model.addAttribute("wrongOTP", "Invalid OTP or Expired OTP. Please request a new one.");
        return "SignInWithOTP";
    }
}

    @PostMapping("resetPassword")
    public String resetPassword(
            @RequestParam String email,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            Model model) {

        model.addAttribute("email", email);

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("errorMsg", "Passwords do not match");
            return "signInUpdatePassword";
        }

        boolean updated = registrationService.resetPassword(email, newPassword, confirmPassword);

        if (updated) {
            model.addAttribute("msg", "Password updated successfully! Please login with your new password.");
            return "signIn";
        } else {
            model.addAttribute("errorMsg", "Failed to update password. Please try again.");
            return "signInUpdatePassword";
        }
    }

    @GetMapping("editProfile")
    public String showEditProfile(@RequestParam String email, Model model){

        // Fetch user details
        RegistrationEntity registrationEntity = registrationService.getUserByEmail(email);

        if (registrationEntity == null) {
            model.addAttribute("error", "User not found");
            return "signIn";
        }

        // Create DTO from entity (exclude password)
        RegistrationDTO registrationDTO = new RegistrationDTO();
        registrationDTO.setName(registrationEntity.getName());
        registrationDTO.setEmail(registrationEntity.getEmail());
        registrationDTO.setPhone(registrationEntity.getPhone());
        registrationDTO.setAge(registrationEntity.getAge());
        registrationDTO.setGender(registrationEntity.getGender());
        registrationDTO.setAddress(registrationEntity.getAddress());

        model.addAttribute("registrationEntity", registrationDTO);
        return "editProfile";
    }

    @PostMapping("updateProfile")
    public String updateProfile(
            @RequestParam String email,
            @RequestParam String name,
            @RequestParam String phone,
            @RequestParam Integer age,
            @RequestParam String address,
            Model model) {

        // Verify email belongs to logged-in user (add session check)
        RegistrationEntity registration = registrationService.getUserByEmail(email);
        if (registration == null) {
            return "signIn";
        }

        // Validation
        if (name == null || name.trim().isEmpty()) {
            model.addAttribute("error", "Name is required");
            return "editProfile";
        }

        // Update profile
        boolean updated = registrationService.updateProfile(email, name, phone, age, address);

        if (updated) {
            model.addAttribute("msg", "Profile updated successfully!");
            model.addAttribute("email", email);
            model.addAttribute("name", name);
            return "Home";
        } else {
            model.addAttribute("error", "Failed to update profile");
            return "editProfile";
        }
    }

    @PostMapping("/uploadProfilePhoto")
    public String uploadProfilePhoto(@RequestParam String email,
                                     @RequestParam MultipartFile profilePhoto,
                                     RedirectAttributes redirectAttributes,
                                     HttpSession session) {

        try {
            boolean success = registrationService.uploadProfilePhoto(email, profilePhoto);

            if (success) {
                // ✅ Re-fetch user from DB to get the FRESH fileId
                RegistrationEntity updated = registrationService.getUserByEmail(email);
                if (updated != null && updated.getProfileImage() != null) {
                    session.setAttribute("fileId", updated.getProfileImage().getId());
                    System.out.println("✅ Session updated with new fileId: " + updated.getProfileImage().getId());
                }
                // ✅ RedirectAttributes carry the message THROUGH the redirect
                redirectAttributes.addFlashAttribute("msg", "Profile photo updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to update photo. Please try again.");
            }

        } catch (IllegalArgumentException e) {
            // Validation errors (wrong type, too large)
            redirectAttributes.addFlashAttribute("error", e.getMessage());

        } catch (IOException e) {
            // Disk errors
            redirectAttributes.addFlashAttribute("error", "Disk error: " + e.getMessage());
        }

        return "redirect:/dashboard/Home";
    }
}