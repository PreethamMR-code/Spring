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
        Optional<User> userOpt = userDao.findByEmail(email);

        if (!userOpt.isPresent()) {
            // Silent on unknown email — security best practice,
            // never reveal whether an email is registered.
            return;
        }

        User user = userOpt.get();

        // Invalidate any previous reset link for this user
        passwordResetTokenDao.deleteByUserId(user.getId());

        String token = UUID.randomUUID().toString();

        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setUser(user);
        resetToken.setToken(token);
        resetToken.setExpiresAt(LocalDateTime.now().plusHours(1));

        passwordResetTokenDao.save(resetToken);

        /*
         * Isolated in its own try-catch so an email failure
         * never rolls back the token save via the @Transactional
         * boundary. Worst case: token exists but email didn't
         * arrive — user can request a new link.
         */
        try {
            emailService.sendPasswordResetEmail(
                    user.getEmail(),
                    user.getFullName(),
                    token
            );
        } catch (Exception e) {
            System.err.println(
                    "[PasswordReset] Email send failed for "
                            + user.getEmail() + ": " + e.getMessage());
        }
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