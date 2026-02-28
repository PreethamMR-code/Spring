package com.nexmeet.platform.controller.pub;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/home")
    public String home(){
        return "pub/home";
    }

    @GetMapping("/")
    public String root(){
        return "pub/home";
    }
}
