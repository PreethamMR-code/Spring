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
import org.springframework.transaction.annotation.Transactional;


import java.util.*;


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
    public User registerUser(String fullName, String email, String rawPassword, String phone, String roleName) {
        if (userDao.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already registered: " + email);
        }


        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email.toLowerCase().trim());
        user.setPasswordHash(passwordEncoder.encode(rawPassword));
        user.setActive(true);
        user.setVerified(false);

        // Assign role — default to DELEGATE if not provided
        String roleToAssign = (roleName != null && roleName.equals("ORGANIZER"))
                ? "ORGANIZER" : "DELEGATE";


        Role role = (Role) sessionFactory.getCurrentSession()
                .createQuery("FROM Role WHERE name = :name")
                .setParameter("name", roleToAssign)
                .uniqueResult();

        if (role != null) {
            Set<Role> roles = new HashSet<>();
            roles.add(role);
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

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countAllUsers() {
        return userDao.countAll();
    }

    @Override
    public void updateProfile(String email, String fullName, String phone) {
        User user = userDao.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setFullName(fullName);
        user.setPhone(phone);
        userDao.update(user);
    }

    @Override
    public boolean changePassword(String email, String currentPassword, String newPassword) {
        User user = userDao.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Verify current password matches
        if (!passwordEncoder.matches(currentPassword,
                user.getPasswordHash())) {
            return false;
        }

        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userDao.update(user);
        return true;
    }

    @Override
    public void toggleUserActive(Long userId) {
        userDao.findById(userId).ifPresent(user -> {
            user.setActive(!user.isActive());
            userDao.update(user);
        });
    }

    @Override
    public List<User> findAllUsers() {
        return userDao.findAll();
    }
}
