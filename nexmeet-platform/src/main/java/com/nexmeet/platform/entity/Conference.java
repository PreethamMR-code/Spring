package com.nexmeet.platform.entity;

import com.nexmeet.platform.enums.ConferenceMode;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.enums.ConferenceType;

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

    public Conference() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Organizer getOrganizer() { return organizer; }
    public void setOrganizer(Organizer organizer) { this.organizer = organizer; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getBannerImage() { return bannerImage; }
    public void setBannerImage(String bannerImage) { this.bannerImage = bannerImage; }

    public ConferenceType getConferenceType() { return conferenceType; }
    public void setConferenceType(ConferenceType conferenceType) { this.conferenceType = conferenceType; }

    public String getTargetAudience() { return targetAudience; }
    public void setTargetAudience(String targetAudience) { this.targetAudience = targetAudience; }

    public String getTargetDomains() { return targetDomains; }
    public void setTargetDomains(String targetDomains) { this.targetDomains = targetDomains; }

    public ConferenceMode getMode() { return mode; }
    public void setMode(ConferenceMode mode) { this.mode = mode; }

    public String getVenueName() { return venueName; }
    public void setVenueName(String venueName) { this.venueName = venueName; }

    public String getVenueAddress() { return venueAddress; }
    public void setVenueAddress(String venueAddress) { this.venueAddress = venueAddress; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getStreamingLink() { return streamingLink; }
    public void setStreamingLink(String streamingLink) { this.streamingLink = streamingLink; }

    public String getStreamingPassword() { return streamingPassword; }
    public void setStreamingPassword(String streamingPassword) { this.streamingPassword = streamingPassword; }

    public LocalDateTime getStartDate() { return startDate; }
    public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }

    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }

    public LocalDateTime getRegistrationDeadline() { return registrationDeadline; }
    public void setRegistrationDeadline(LocalDateTime registrationDeadline) { this.registrationDeadline = registrationDeadline; }

    public Integer getMaxDelegates() { return maxDelegates; }
    public void setMaxDelegates(Integer maxDelegates) { this.maxDelegates = maxDelegates; }

    public Integer getRegisteredCount() { return registeredCount; }
    public void setRegisteredCount(Integer registeredCount) { this.registeredCount = registeredCount; }

    public boolean isFree() { return isFree; }
    public void setFree(boolean free) { isFree = free; }

    public BigDecimal getDelegateFee() { return delegateFee; }
    public void setDelegateFee(BigDecimal delegateFee) { this.delegateFee = delegateFee; }

    public boolean isCertificateEnabled() { return certificateEnabled; }
    public void setCertificateEnabled(boolean certificateEnabled) { this.certificateEnabled = certificateEnabled; }

    public boolean isQrCheckinEnabled() { return qrCheckinEnabled; }
    public void setQrCheckinEnabled(boolean qrCheckinEnabled) { this.qrCheckinEnabled = qrCheckinEnabled; }

    public boolean isBulkUploadAllowed() { return bulkUploadAllowed; }
    public void setBulkUploadAllowed(boolean bulkUploadAllowed) { this.bulkUploadAllowed = bulkUploadAllowed; }

    public ConferenceStatus getStatus() { return status; }
    public void setStatus(ConferenceStatus status) { this.status = status; }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }

    public User getApprovedBy() { return approvedBy; }
    public void setApprovedBy(User approvedBy) { this.approvedBy = approvedBy; }

    public LocalDateTime getApprovedAt() { return approvedAt; }
    public void setApprovedAt(LocalDateTime approvedAt) { this.approvedAt = approvedAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }

    @Override
    public String toString() {
        return "Conference{id=" + id + ", title='" + title + "', status=" + status + "}";
    }
}
