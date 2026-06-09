package com.nexmeet.platform.controller.pub;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    /*
     * Shows the login page.
     * Note: We only need GET mapping here.
     * The POST (form submission) is handled automatically
     * by Spring Security at /login/process — we never write
     * code for that ourselves.
     */

    @GetMapping("/login")
    public String loginPage() {
        return "pub/login";
    }

}
