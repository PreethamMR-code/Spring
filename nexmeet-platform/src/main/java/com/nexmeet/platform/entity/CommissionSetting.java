package com.nexmeet.platform.entity;


import com.nexmeet.platform.enums.ConferenceType;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/*
 * CommissionSetting defines how much NexMeet charges per conference type.
 * One row per conference type (STUDENT, CORPORATE, etc.)
 *
 * The admin can update these anytime from the admin panel.
 * When a new conference is submitted, the system looks up
 * the CommissionSetting for that conference type and calculates
 * the ConferencePricing automatically.
 *
 * We already inserted default rows in the original SQL setup.
 */
@Entity
@Table(name = "commission_settings")
public class CommissionSetting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /*
     * This is NOT per-conference but per conference TYPE.
     * e.g. "Technical" -> base_fee=500, per_delegate_fee=25
     * Admin configures this globally.
     */
    @Column(name = "conference_type", unique = true)
    private String conferenceType;

    /*
     * Fixed base fee the organizer pays to list
     * a conference on the platform.
     */
    @Column(name = "base_fee")
    private BigDecimal baseFee = BigDecimal.ZERO;

    /*
     * Per-delegate commission — platform earns this
     * for every confirmed registration.
     */
    @Column(name = "per_delegate_fee")
    private BigDecimal perDelegateFee = BigDecimal.ZERO;

    @Column(name = "description")
    private String description;

    @Column(name = "is_active")
    private boolean active = true;

    @Column(name = "updated_by")
    private Long updatedBy;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters and setters
    public Long getId() { return id; }
    public String getConferenceType() { return conferenceType; }
    public void setConferenceType(String t) { conferenceType = t; }
    public BigDecimal getBaseFee() { return baseFee; }
    public void setBaseFee(BigDecimal f) { baseFee = f; }
    public BigDecimal getPerDelegateFee() { return perDelegateFee; }
    public void setPerDelegateFee(BigDecimal f) { perDelegateFee = f; }
    public String getDescription() { return description; }
    public void setDescription(String d) { description = d; }
    public boolean isActive() { return active; }
    public void setActive(boolean a) { active = a; }
    public Long getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(Long u) { updatedBy = u; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime t) { updatedAt = t; }
}
