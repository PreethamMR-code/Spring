package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {

    // Register a brand new user — creates User + assigns DELEGATE role
    User registerUser(String fullName, String email, String rawPassword, String phone, String roleName);

    // Find user by email — used by Spring Security
    Optional<User> findByEmail(String email);

    // Find user by ID
    Optional<User> findById(Long id);

    // Check if email is already registered
    boolean isEmailTaken(String email);

    List<User> getAllUsers();

    long countAllUsers();

    void updateProfile(String email, String fullName, String phone);

    boolean changePassword(String email, String currentPassword,
                           String newPassword);

    void toggleUserActive(Long userId);

    List<User> findAllUsers();

    // UserService interface — add:
    long countByRole(String roleName);



}
