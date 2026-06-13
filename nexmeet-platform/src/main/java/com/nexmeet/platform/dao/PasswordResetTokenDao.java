package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.PasswordResetToken;
import java.util.Optional;

public interface PasswordResetTokenDao {

    void save(PasswordResetToken token);

    Optional<PasswordResetToken> findByToken(String token);

    /*
     * Delete all existing tokens for this user before
     * creating a new one. Prevents token accumulation.
     */
    void deleteByUserId(Long userId);
}