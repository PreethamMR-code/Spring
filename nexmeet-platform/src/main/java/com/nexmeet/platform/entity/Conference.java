package com.nexmeet.platform.entity;

import com.nexmeet.platform.enums.ConferenceMode;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.ConferenceType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/*
 * Conference is the central entity of NexMeet.
 * Almost every other entity (Session, Registration, Payment,
 * QrCode, Certificate, Feedback) connects back to this one.
 *
 * Key relationship: Many conferences belong to ONE organizer.
 * This is @ManyToOne from Conference's side.
 */

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "conferences")
public class Conference {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * @ManyToOne: Many conferences can be created by one organizer.
     * @JoinColumn(name = "organizer_id"): the FK column in conferences table.
     * nullable = false: every conference MUST have an organizer.
     *
     * Notice we reference the Organizer entity object, NOT a Long id.
     * This is the power of Hibernate — you work with objects, not raw IDs.
     * When you call conference.getOrganizer(), Hibernate fetches the
     * full Organizer object automatically.
     */
    @ManyToOne
    @JoinColumn(name = "organizer_id", nullable = false)
    private Organizer organizer;

    @Column(name = "title", nullable = false, length = 300)
    private String title;

    /*
     * @Lob = Large Object. Maps to TEXT in MySQL.
     * Used for long text fields like descriptions.
     * Regular @Column with length would be VARCHAR (max 65535 chars).
     * TEXT can hold much more and is better for descriptions.
     */
    @Lob
    @Column(name = "description")
    private String description;

    @Column(name = "banner_image", length = 500)
    private String bannerImage;

    @Enumerated(EnumType.STRING)
    @Column(name = "conference_type", nullable = false, length = 20)
    private ConferenceType conferenceType;

    @Column(name = "target_audience", length = 500)
    private String targetAudience;

    @Column(name = "target_domains", length = 500)
    private String targetDomains;

    @Enumerated(EnumType.STRING)
    @Column(name = "mode", nullable = false, length = 10)
    private ConferenceMode mode;

    // Location fields (for offline/hybrid)
    @Column(name = "venue_name", length = 300)
    private String venueName;

    @Column(name = "venue_address", length = 500)
    private String venueAddress;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "state", length = 100)
    private String state;

    // Online link (for online/hybrid)
    @Column(name = "streaming_link", length = 500)
    private String streamingLink;

    @Column(name = "streaming_password", length = 100)
    private String streamingPassword;

    // Dates
    @Column(name = "start_date", nullable = false)
    private LocalDateTime startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDateTime endDate;

    @Column(name = "registration_deadline", nullable = false)
    private LocalDateTime registrationDeadline;

    // Capacity
    @Column(name = "max_delegates", nullable = false)
    private Integer maxDelegates = 100;

    /*
     * registeredCount is updated every time someone registers.
     * We track it here so we can quickly check:
     * if (conference.getRegisteredCount() >= conference.getMaxDelegates())
     *     → conference is full, add to waitlist
     * Without this field, we'd need a COUNT(*) query on registrations
     * every time someone tries to register — much slower.
     */
    @Column(name = "registered_count", nullable = false)
    private Integer registeredCount = 0;

    // Pricing
    @Column(name = "is_free", nullable = false)
    private boolean isFree = true;

    @Column(name = "delegate_fee", precision = 10, scale = 2)
    private BigDecimal delegateFee = BigDecimal.ZERO;

    // Optional features
    @Column(name = "certificate_enabled", nullable = false)
    private boolean certificateEnabled = false;

    @Column(name = "qr_checkin_enabled", nullable = false)
    private boolean qrCheckinEnabled = false;

    @Column(name = "bulk_upload_allowed", nullable = false)
    private boolean bulkUploadAllowed = true;

    /*
     * Status follows a workflow:
     * DRAFT -> SUBMITTED -> APPROVED (visible publicly) or REJECTED
     * APPROVED -> CANCELLED or COMPLETED
     *
     * The organizer moves it from DRAFT to SUBMITTED.
     * The admin moves it from SUBMITTED to APPROVED or REJECTED.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private ConferenceStatus status = ConferenceStatus.DRAFT;

    @Column(name = "rejection_reason", length = 500)
    private String rejectionReason;

    @ManyToOne
    @JoinColumn(name = "approved_by", nullable = true)
    private User approvedBy;

    @Column(name = "approved_at")
    private LocalDateTime approvedAt;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }



    @Override
    public String toString() {
        return "Conference{id=" + id + ", title='" + title + "', status=" + status + "}";
    }
}
