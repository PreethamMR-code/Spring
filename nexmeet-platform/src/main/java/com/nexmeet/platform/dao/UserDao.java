package com.nexmeet.platform.dao;

/*
 * UserDao defines ALL database operations related to the User table.
 * This is an interface — it only says WHAT can be done, not HOW.
 * The HOW is in UserDaoImpl.
 *
 * Why use an interface?
 * - Your Service only depends on this interface, not the implementation.
 * - If you ever switch from Hibernate to JPA or JDBC, you only rewrite
 *   UserDaoImpl, not any Service or Controller code.
 * - Makes unit testing easy — you can mock this interface.
 */

import com.nexmeet.platform.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserDao {

    // Save a new user to the database
    void save(User user);

    // Update an existing user
    void update(User user);

    // Find a user by their database ID
    Optional<User> findById(Long id);

    // Find a user by their email address (used for login)
    Optional<User> findByEmail(String email);

    // Get all users (admin use)
    List<User> findAll();

    // Check if an email is already taken (used during registration)
    boolean existsByEmail(String email);

    // Soft delete — set is_active = false instead of deleting the row
    void deactivate(Long id);

    long countAll();


}
