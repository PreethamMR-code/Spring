package com.nexmeet.platform.controller.institution;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/institution")
public class InstitutionController {

    @GetMapping("dashboard")
    public String dashboard(){
        return "institution/dashboard";
    }
}
