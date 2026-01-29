package com.xworkz.model.controller;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.entity.StudentEntity;
import com.xworkz.model.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

@Controller
public class XworkzController {

    @Autowired
    private StudentService studentService;

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

    // Show signin page
    @GetMapping("signIn")
    public String signInPage() {
        return "signIn";
    }

    // Show OTP signin page
    @GetMapping("SignInWithOTP")
    public String signInWithOTPPage() {
        return "SignInWithOTP";
    }

    @PostMapping("signUp")
    public ModelAndView createAccount(@Valid StudentDTO studentDTO, BindingResult bindingResult, ModelAndView mv) {
        mv.setViewName("signUp");
        mv.addObject("dto", studentDTO);

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

        if (!studentDTO.getPassword().equals(studentDTO.getConfirmPassword())) {
            mv.addObject("confirmPasswordError", "Passwords do not match");
            return mv;
        }


        boolean saved = studentService.validateAndSave(studentDTO);

        if (saved) {
            mv.setViewName("signIn");
            mv.addObject("msg", "Account created successfully! Please login.");
            mv.addObject("dto", new StudentDTO());
        } else {
            mv.addObject("error", "Email already exists or registration failed");
        }
        return mv;
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
//        boolean saved = studentService.register(dto);
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
                               Model model) {

        // check if email exists
//        StudentEntity entity = studentService.findByEmail(email);

//        if (email == null || email.trim().isEmpty()) {
//            model.addAttribute("error", "Please enter your email");
//            return "login";
//        }

        //validate the password
        boolean valid = studentService.validateLogin(email, password);


        // reset failed attempts
        if (valid) {
            studentService.setCountToZero(email);

            // ✅ FETCH USER DETAILS TO GET NAME
            StudentEntity student = studentService.getUserByEmail(email);

            model.addAttribute("email", email);
            model.addAttribute("name", student != null ? student.getName() : "User");
            return "Home";
        }else {
            // email exists but wrong credentials
            int count = studentService.getCount(email);
            model.addAttribute("email", email);

            if (count >= 2) {
                model.addAttribute("disableLogin", true);
                model.addAttribute("showForgot", true);
                model.addAttribute("error", "Account locked due to multiple failed attempts. Please reset your password.");
            } else {
                studentService.updateCount(email);
                model.addAttribute("error", "Invalid email or password. Attempt " + (count + 1) + " of 3");
            }
            return "signIn";
        }
    }

        // email exists but wrong credentials
      //  int count = studentService.incrementLoginCount(email);

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


    @PostMapping("sendOTP")
    public String sendOtp(@RequestParam String email, Model model) {


        System.out.println("Sending OTP to: " + email);


        boolean isSent = studentService.sendOtp(email);
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

    boolean isValid = studentService.checkOptLogin(email, otp);

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

        boolean updated = studentService.resetPassword(email, newPassword, confirmPassword);

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
        StudentEntity student = studentService.getUserByEmail(email);

        if (student == null) {
            model.addAttribute("error", "User not found");
            return "signIn";
        }

        // Create DTO from entity (exclude password)
        StudentDTO studentDTO = new StudentDTO();
        studentDTO.setName(student.getName());
        studentDTO.setEmail(student.getEmail());
        studentDTO.setPhone(student.getPhone());
        studentDTO.setAge(student.getAge());
        studentDTO.setGender(student.getGender());
        studentDTO.setAddress(student.getAddress());

        model.addAttribute("student", studentDTO);
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
        StudentEntity student = studentService.getUserByEmail(email);
        if (student == null) {
            return "signIn";
        }

        // Validation
        if (name == null || name.trim().isEmpty()) {
            model.addAttribute("error", "Name is required");
            return "editProfile";
        }

        // Update profile
        boolean updated = studentService.updateProfile(email, name, phone, age, address);

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
}