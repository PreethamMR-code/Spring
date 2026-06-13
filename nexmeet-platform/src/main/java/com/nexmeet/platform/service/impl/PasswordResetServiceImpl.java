package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.PasswordResetTokenDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.PasswordResetToken;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.EmailService;
import com.nexmeet.platform.service.PasswordResetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class PasswordResetServiceImpl
        implements PasswordResetService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordResetTokenDao passwordResetTokenDao;

    @Autowired
    private EmailService emailService;

    /*
     * BCryptPasswordEncoder is defined as a bean in
     * spring-security.xml with id="passwordEncoder".
     * Spring injects it here by type automatically.
     */
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public void initiateReset(String email) {
        Optional<User> userOpt =
                userDao.findByEmail(email);

        /*
         * SECURITY: Do NOT throw or return an error
         * if the email doesn't exist. Always behave
         * the same way so attackers cannot enumerate
         * registered emails by watching the response.
         */
        if (userOpt.isEmpty()) {
            return;
        }

        User user = userOpt.get();

        // Delete any existing tokens for this user
        // so only one valid reset link exists at a time
        passwordResetTokenDao.deleteByUserId(user.getId());

        // Generate a cryptographically random token
        String token = UUID.randomUUID().toString();

        PasswordResetToken resetToken =
                new PasswordResetToken();
        resetToken.setUser(user);
        resetToken.setToken(token);
        resetToken.setExpiresAt(
                LocalDateTime.now().plusHours(1));

        passwordResetTokenDao.save(resetToken);

        // Send the reset email
        emailService.sendPasswordResetEmail(
                user.getEmail(),
                user.getFullName(),
                token
        );
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isTokenValid(String token) {
        return passwordResetTokenDao
                .findByToken(token)
                .map(t -> !t.isExpired())
                .orElse(false);
    }

    @Override
    public void resetPassword(String token,
                              String newPassword) {
        PasswordResetToken resetToken =
                passwordResetTokenDao
                        .findByToken(token)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Invalid or expired " +
                                                "reset link."));

        if (resetToken.isExpired()) {
            throw new RuntimeException(
                    "This reset link has expired. " +
                            "Please request a new one.");
        }

        User user = resetToken.getUser();

        // BCrypt-encode the new password
        user.setPasswordHash(
                passwordEncoder.encode(newPassword));
        userDao.update(user);

        // Token is single-use — delete after successful reset
        passwordResetTokenDao.deleteByUserId(user.getId());
    }
}