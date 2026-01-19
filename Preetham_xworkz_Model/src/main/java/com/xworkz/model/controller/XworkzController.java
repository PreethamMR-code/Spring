package com.xworkz.model.controller;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class XworkzController {

    @Autowired
    private StudentService studentService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/signup")
    public String showSignup() {
        return "signup";
    }

    @GetMapping("/login")
    public String showLogin(){
        return "login";
    }


    @PostMapping("/signup")
    public ModelAndView signup(@Valid StudentDTO dto,
                               BindingResult bindingResult,
                               ModelAndView modelAndView) {

        // Field-level validation errors
        if (bindingResult.hasErrors()) {

            if (bindingResult.hasFieldErrors("name")) {
                modelAndView.addObject("nameError",
                        bindingResult.getFieldError("name").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("email")) {
                modelAndView.addObject("emailError",
                        bindingResult.getFieldError("email").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("phone")) {
                modelAndView.addObject("phoneError",
                        bindingResult.getFieldError("phone").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("age")) {
                modelAndView.addObject("ageError",
                        bindingResult.getFieldError("age").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("gender")) {
                modelAndView.addObject("genderError",
                        bindingResult.getFieldError("gender").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("address")) {
                modelAndView.addObject("addressError",
                        bindingResult.getFieldError("address").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("password")) {
                modelAndView.addObject("passwordError",
                        bindingResult.getFieldError("password").getDefaultMessage());
            }

            if (bindingResult.hasFieldErrors("confirmPassword")) {
                modelAndView.addObject("confirmPasswordError",
                        bindingResult.getFieldError("confirmPassword").getDefaultMessage());
            }

            modelAndView.setViewName("signup");
            return modelAndView;
        }

        // CUSTOM VALIDATION (password match)
        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            modelAndView.addObject("confirmPasswordError", "Passwords do not match");
            modelAndView.setViewName("signup");
            return modelAndView;
        }

        boolean saved = studentService.saveStudent(dto);

        if (saved) {
            modelAndView.addObject("msg", "Account created successfully");
            modelAndView.setViewName("login");
        } else {
            modelAndView.addObject("error", "Email already exists");
            modelAndView.setViewName("signup");
        }

        return modelAndView;
    }


    @PostMapping("login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        Model model,
                        HttpSession session) {

        Integer attempts = (Integer) session.getAttribute("loginAttempts");
        attempts = (attempts == null) ? 1 : attempts + 1;
        session.setAttribute("loginAttempts", attempts);

        boolean valid = studentService.validateLogin(email, password);

        if (valid) {
            session.removeAttribute("loginAttempts");
            session.setAttribute("studentEmail", email);
            return "dashboard";
        }

        // ❌ Invalid login
        if (attempts >= 3) {
            model.addAttribute("showOtp", true);
            model.addAttribute("error", "Too many failed attempts. Login with OTP.");
        } else {
            model.addAttribute("error", "Invalid email or password (" + attempts + "/3)");
        }

        return "login";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();   // clear session
        return "redirect:/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        if (session.getAttribute("studentEmail") == null) {
            return "redirect:/login";
        }
        return "dashboard";
    }


//    @PostMapping("send-otp")
//    public String sendOtp(@RequestParam String email, HttpSession session) {
//
//        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
//        session.setAttribute("otp", otp);
//
//        // simulate sending
//        System.out.println("OTP sent: " + otp);
//
//        return "login";
//    }

//    @PostMapping("login-otp")
//    public String loginWithOtp(@RequestParam String email,
//                               @RequestParam String otp,
//                               HttpSession session,
//                               Model model) {
//
//        String sessionOtp = (String) session.getAttribute("otp");
//
//        if (sessionOtp != null && sessionOtp.equals(otp)) {
//            session.removeAttribute("loginAttempts");
//            session.removeAttribute("otp");
//            session.setAttribute("studentEmail", email);
//            return "dashboard";
//        }
//
//        model.addAttribute("showOtp", true);
//        model.addAttribute("error", "Invalid OTP");
//        return "login";
//    }


}
