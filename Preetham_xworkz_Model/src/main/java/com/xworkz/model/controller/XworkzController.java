package com.xworkz.model.controller;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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


    @PostMapping("signup")
    public String signup(StudentDTO dto, Model model) {

        boolean saved = studentService.saveStudent(dto);

        if (saved) {
            model.addAttribute("msg", "Account created successfully");
            return "login";
        } else {
            model.addAttribute("error", "Email already exists");
            return "signup";
        }
    }

    @PostMapping("login")
    public String login(String email, String password, Model model) {

        boolean valid = studentService.validateLogin(email, password);

        if (valid) {
            return "dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
    }




}
