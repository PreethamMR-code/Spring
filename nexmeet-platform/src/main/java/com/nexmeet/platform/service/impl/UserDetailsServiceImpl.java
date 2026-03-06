package com.nexmeet.platform.service.impl;


import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;
import java.util.stream.Collectors;

/*
 * Spring Security calls loadUserByUsername() automatically
 * when someone submits the login form.
 *
 * The flow is:
 * 1. User submits email + password
 * 2. Spring Security calls loadUserByUsername(email)
 * 3. We return a UserDetails object with the hashed password + roles
 * 4. Spring Security compares submitted password with the hash
 * 5. If match -> login success, redirect to dashboard
 * 6. If no match -> login failure, redirect to /login?error
 *
 * We never compare passwords ourselves — Spring Security handles that.
 */


@Service("userDetailsServiceImpl")
@Transactional(readOnly = true)
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userService.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("No user found with email: " + email));

        if (!user.isActive()) {
            throw new UsernameNotFoundException("Account is deactivated: " + email);
        }

        /*
         * Convert our Role entities into Spring Security's
         * GrantedAuthority objects. Spring Security needs roles
         * prefixed with "ROLE_" — so "SUPER_ADMIN" becomes "ROLE_SUPER_ADMIN".
         *
         * This matches what we have in spring-security.xml:
         * hasRole('SUPER_ADMIN') checks for "ROLE_SUPER_ADMIN" authority.
         */
        Set<SimpleGrantedAuthority> authorities = user.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName()))
                .collect(Collectors.toSet());

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPasswordHash(),
                authorities
        );
    }
}
