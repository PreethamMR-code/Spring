package com.nexmeet.platform.service.impl;


import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


/*
 * @Service tells Spring: "This is a service layer class.
 * Create one instance of it and manage it."
 *
 * The name "userDetailsServiceImpl" in @Service("userDetailsServiceImpl")
 * is CRITICAL — it must exactly match what we wrote in spring-security.xml:
 * <authentication-provider user-service-ref="userDetailsServiceImpl">
 *
 * UserDetailsService is a Spring Security interface with one method:
 * loadUserByUsername() — called every time someone tries to log in.
 * Spring Security calls this, gets the user details, then checks
 * if the password matches.
 *
 * This is a STUB (temporary placeholder) — we return a hardcoded
 * admin user for now. Phase 3 will replace this with real
 * database lookup.
 */


@Service("userDetailsServiceImpl")
public class UserDetailsServiceImpl implements UserDetailsService {


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        /*
         * TEMPORARY: Hardcoded admin user for testing.
         *
         * org.springframework.security.core.userdetails.User.withUsername()
         * is a builder that creates a UserDetails object.
         *
         * {noop} prefix means "no password encoding" — plain text.
         * We use this ONLY for this temporary stub.
         * In Phase 3, we'll use BCrypt encoded passwords from the database.
         *
         * "SUPER_ADMIN" is the role. Spring Security internally
         * stores it as "ROLE_SUPER_ADMIN" — the "ROLE_" prefix is
         * added automatically when using roles().
         */



        if ("admin@nexmeet.com".equals(email)) {
            return org.springframework.security.core.userdetails.User
                    .withUsername("admin@nexmeet.com")
                    .password("{noop}admin123")
                    .roles("SUPER_ADMIN")
                    .build();
    }


        /*
         * If the email doesn't match any user, throw this exception.
         * Spring Security catches it and redirects to login page
         * with an error message.
         */


        throw new UsernameNotFoundException(
                "No user found with email: " + email);
    }
}
