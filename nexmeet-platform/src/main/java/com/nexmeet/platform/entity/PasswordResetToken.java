package com.nexmeet.platform.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "password_reset_tokens")
public class PasswordResetToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * ManyToOne because one user can have multiple tokens
     * (e.g. clicked "forgot password" twice).
     * We always delete old tokens when issuing a new one.
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /*
     * UUID stored as VARCHAR(100).
     * Generated in the service layer using UUID.randomUUID().
     */
    @Column(name = "token", nullable = false,
            unique = true, length = 100)
    private String token;

    /*
     * Tokens expire after 1 hour.
     * Set in PasswordResetServiceImpl when creating the token.
     */
    @Column(name = "expires_at", nullable = false)
    private LocalDateTime expiresAt;

    @Column(name = "created_at", nullable = false,
            updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    /* Convenience method used in the service layer */
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }
}