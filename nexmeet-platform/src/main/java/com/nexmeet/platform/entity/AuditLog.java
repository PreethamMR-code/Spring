package com.nexmeet.platform.entity;


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

    public AuditLog() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getEntityType() { return entityType; }
    public void setEntityType(String entityType) { this.entityType = entityType; }

    public Long getEntityId() { return entityId; }
    public void setEntityId(Long entityId) { this.entityId = entityId; }

    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public LocalDateTime getPerformedAt() { return performedAt; }
}
