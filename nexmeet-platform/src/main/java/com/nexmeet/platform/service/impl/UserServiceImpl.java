package com.nexmeet.platform.service.impl;


/*
 * @Service marks this as a Spring-managed service bean.
 * @Transactional at class level means EVERY method here runs
 * inside a database transaction automatically.
 *
 * What is a transaction?
 * It's a unit of work — either ALL operations succeed and get
 * committed, or if ANY operation fails, ALL are rolled back.
 *
 * Example: registerUser() does 2 things:
 *   1. Save user row
 *   2. Assign role
 * If step 2 fails, step 1 is also rolled back.
 * The database stays consistent — no orphan users without roles.
 */

import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Role;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.UserService;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.HashSet;
import java.util.Optional;
import java.util.Set;



@Service
@org.springframework.transaction.annotation.Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private SessionFactory sessionFactory;


    /*
     * BCryptPasswordEncoder is the industry standard for password hashing.
     * It generates a different hash each time (due to random salt),
     * so even two identical passwords produce different hashes.
     * NEVER store raw passwords. Always hash before saving.
     *
     * We create the encoder here directly because it has no dependencies.
     * In larger projects it would be a Spring bean in a config class.
     */
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


    @Override
    public User registerUser(String fullName, String email, String rawPassword) {
        if (userDao.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already registered: " + email);
        }


        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email.toLowerCase().trim());
        user.setPasswordHash(passwordEncoder.encode(rawPassword));
        user.setActive(true);
        user.setVerified(false);

        /*
         * Assign the DELEGATE role automatically on registration.
         * We look up the role by name from the roles table.
         * The roles table already has DELEGATE inserted from our SQL setup.
         */
        Role delegateRole = (Role) sessionFactory.getCurrentSession()
                .createQuery("FROM Role WHERE name = :name")
                .setParameter("name", "DELEGATE")
                .uniqueResult();

        if (delegateRole != null) {
            Set<Role> roles = new HashSet<>();
            roles.add(delegateRole);
            user.setRoles(roles);
        }

        userDao.save(user);
        return user;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public Optional<User> findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public Optional<User> findById(Long id) {
        return userDao.findById(id);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public boolean isEmailTaken(String email) {
        return userDao.existsByEmail(email);
    }
}
