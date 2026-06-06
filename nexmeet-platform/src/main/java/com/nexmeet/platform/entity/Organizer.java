package com.nexmeet.platform.entity;

/*
 * The Organizer entity stores details specific to users who create conferences.
 *
 * Notice: Every Organizer is first a User. We don't duplicate name/email here.
 * Instead we have a @OneToOne relationship pointing to the User entity.
 *
 * @OneToOne means: one Organizer record belongs to exactly one User.
 * And one User can have at most one Organizer profile.
 */

import com.nexmeet.platform.enums.VerificationStatus;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "organizers")
public class Organizer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * @OneToOne — one organizer profile belongs to one user.
     *
     * @JoinColumn(name = "user_id") — the foreign key column in the
     * "organizers" table that points to the "users" table.
     * This matches our SQL: user_id BIGINT NOT NULL UNIQUE
     *
     * nullable = false — every organizer MUST have a user.
     * unique = true — one user cannot have two organizer profiles.
     */


    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Column(name = "organization_name", nullable = false, length = 200)
    private String organizationName;

    @Column(name = "organization_type", length = 100)
    private String organizationType;

    @Column(name = "website_url", length = 300)
    private String websiteUrl;

    @Column(name = "address", length = 500)
    private String address;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "state", length = 100)
    private String state;

    @Column(name = "pincode", length = 10)
    private String pincode;

    @Column(name = "document_path", length = 500)
    private String documentPath;


    /*
     * @Enumerated(EnumType.STRING) tells Hibernate:
     * "Store the enum as its name (text) in the database."
     * So PENDING is stored as the string "PENDING", not as 0 or 1.
     *
     * EnumType.ORDINAL (the other option) would store 0, 1, 2...
     * We NEVER use ORDINAL because if you reorder your enum values,
     * all existing data in the database becomes wrong.
     * Always use EnumType.STRING for safety.
     *
     * But wait — our MySQL column is defined as ENUM('PENDING','APPROVED','REJECTED')
     * Hibernate STRING maps cleanly to this.
     */

    @Enumerated(EnumType.STRING)
    @Column(name = "verification_status", nullable = false, length = 20)
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    @Column(name = "rejection_reason", length = 500)
    private String rejectionReason;

    @Column(name = "verified_at")
    private LocalDateTime verifiedAt;

    /*
     * verified_by is a foreign key to users(id) — the admin who approved.
     * We use @ManyToOne here because MANY organizers can be verified by
     * ONE admin user.
     *
     * optional = true means this can be NULL (not verified yet).
     */


    @ManyToOne
    @JoinColumn(name = "verified_by", nullable = true)
    private User verifiedBy;

    /*
     * BigDecimal for money/decimal values — NEVER use double or float
     * for financial data because floating point has precision errors.
     * Example: 0.1 + 0.2 = 0.30000000000000004 in double.
     * BigDecimal is exact.
     *
     * precision = total digits, scale = digits after decimal point.
     * precision=3, scale=2 means max value = 9.99
     */
    @Column(name = "average_rating", precision = 3, scale = 2)
    private BigDecimal averageRating = BigDecimal.ZERO;

    @Column(name = "total_events")
    private Integer totalEvents = 0;

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

}
