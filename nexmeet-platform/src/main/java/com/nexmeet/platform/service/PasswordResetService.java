package com.nexmeet.platform.service;

public interface PasswordResetService {

    /*
     * Generates a token, saves it, and sends the reset email.
     * Returns silently even if email not found —
     * never tell the user whether the email exists (security).
     */
    void initiateReset(String email);

    /*
     * Returns true if the token exists AND has not expired.
     * Used by the GET handler to decide whether to show the form.
     */
    boolean isTokenValid(String token);

    /*
     * Validates token, BCrypt-encodes the new password,
     * updates the user record, and deletes the token.
     * Throws RuntimeException if token is invalid/expired.
     */
    void resetPassword(String token, String newPassword);
}