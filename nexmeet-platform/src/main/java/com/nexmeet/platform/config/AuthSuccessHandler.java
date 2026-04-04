package com.nexmeet.platform.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

//No @Component annotation — because we declared it as a <beans:bean> in spring-security.xml directly,
// so Spring doesn't need to scan it.
public class AuthSuccessHandler implements AuthenticationSuccessHandler {


    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        String redirectUrl = "/nexmeet/delegate/dashboard";  //default

        for (GrantedAuthority authority : authorities){
            String role = authority.getAuthority();
            if(role.equals("ROLE_SUPER_ADMIN")) {
                redirectUrl = "/nexmeet/admin/dashboard";
                break;
            } else if (role.equals("ROLE_ORGANIZER")) {
                redirectUrl = "/nexmeet/organizer/profile/setup";
                break;
            } else if (role.equals("ROLE_INSTITUTIONAL_ADMIN")) {
                redirectUrl = "/nexmeet/institution/dashboard";
                break;
            }
        }
        response.sendRedirect(redirectUrl);
        }
}
