package com.nexmeet.platform.entity;


import com.nexmeet.platform.enums.RegistrationStatus;

import javax.persistence.*;
import java.time.LocalDateTime;

/*
 * Registration is the core business table of NexMeet.
 * It answers: "Which delegates are attending which conferences?"
 *
 * This is the junction between User and Conference.
 * One user can register for many conferences.
 * One conference can have many registered users.
 * But one user cannot register for the SAME conference twice
 * (enforced by the UNIQUE constraint below).
 */
@Entity
@Table(name = "registrations",
        uniqueConstraints = {
                /*
                 * @UniqueConstraint maps to the SQL:
                 * UNIQUE KEY unique_registration (conference_id, user_id)
                 * This prevents the same person registering twice
                 * for the same conference at the database level.
                 */
                @UniqueConstraint(
                        name = "unique_registration",
                        columnNames = {"conference_id", "user_id"}
                )
        }
)
public class Registration {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    /*
     * A human-readable registration number.
     * Format we'll generate: NM-2025-000123
     * Much better than showing users a raw database ID.
     * Unique across the entire platform.
     */
    @Column(name = "registration_number", nullable = false, unique = true, length = 50)
    private String registrationNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "registration_type", nullable = false, length = 20)
    private RegistrationStatus registrationType = RegistrationStatus.CONFIRMED;

    /*
     * bulk_upload_id links this registration to a BulkUpload record
     * if it was created via an Excel file upload.
     * NULL for individual registrations.
     * We store just the ID (Long) here, not a full @ManyToOne,
     * to avoid circular dependency issues at this stage.
     */
    @Column(name = "bulk_upload_id")
    private Long bulkUploadId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private RegistrationStatus status = RegistrationStatus.CONFIRMED;

    @Column(name = "registered_at", nullable = false, updatable = false)
    private LocalDateTime registeredAt;

    @Column(name = "cancelled_at")
    private LocalDateTime cancelledAt;

    @PrePersist
    protected void onCreate() {
        registeredAt = LocalDateTime.now();
    }

    public Registration() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getRegistrationNumber() { return registrationNumber; }
    public void setRegistrationNumber(String registrationNumber) { this.registrationNumber = registrationNumber; }

    public RegistrationStatus getRegistrationType() { return registrationType; }
    public void setRegistrationType(RegistrationStatus registrationType) { this.registrationType = registrationType; }

    public Long getBulkUploadId() { return bulkUploadId; }
    public void setBulkUploadId(Long bulkUploadId) { this.bulkUploadId = bulkUploadId; }

    public RegistrationStatus getStatus() { return status; }
    public void setStatus(RegistrationStatus status) { this.status = status; }

    public LocalDateTime getRegisteredAt() { return registeredAt; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    @Override
    public String toString() {
        return "Registration{id=" + id + ", number='" + registrationNumber + "', status=" + status + "}";
    }
}
