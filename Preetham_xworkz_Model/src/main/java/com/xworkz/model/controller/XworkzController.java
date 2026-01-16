package com.xworkz.model.controller;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

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
    public String login(@RequestParam String email,@RequestParam String password, Model model, HttpSession session) {

        boolean valid = studentService.validateLogin(email, password);

        if (valid) {
            session.setAttribute("studentEmail",email);
            session.setAttribute("studentName",email);  //replace real name later
            return "dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
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






}
