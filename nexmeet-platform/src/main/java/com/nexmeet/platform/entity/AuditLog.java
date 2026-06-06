package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * AuditLog records important actions in the system.
 * Who did what, when, and to which record.
 * Examples:
 *   - Admin approved Conference ID 5
 *   - Organizer cancelled Conference ID 12
 *   - User registered for Conference ID 3
 *
 * This is critical for security, debugging, and accountability.
 * user_id can be NULL for system-triggered actions.
 */
@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "audit_logs")
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    // NULL if system triggered this action
    @ManyToOne(optional = true)
    @JoinColumn(name = "user_id", nullable = true)
    private User user;

    // e.g. "CONFERENCE_APPROVED", "USER_REGISTERED", "PAYMENT_COMPLETED"
    @Column(name = "action", nullable = false, length = 200)
    private String action;

    // e.g. "Conference", "User", "Payment"
    @Column(name = "entity_type", length = 100)
    private String entityType;

    // Which specific record was affected (its ID)
    @Column(name = "entity_id")
    private Long entityId;

    // Extra context stored as JSON string
    @Lob
    @Column(name = "details")
    private String details;

    @Column(name = "ip_address", length = 45)
    private String ipAddress;

    @Column(name = "performed_at", nullable = false, updatable = false)
    private LocalDateTime performedAt;

    @PrePersist
    protected void onCreate() {
        performedAt = LocalDateTime.now();
    }


}
