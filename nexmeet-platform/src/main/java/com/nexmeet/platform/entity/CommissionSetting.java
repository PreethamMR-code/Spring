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
    @Column(name = "id")
    private Integer id;

    /*
     * Each conference type has exactly ONE commission setting.
     * unique = true enforces this — you can't have two rows
     * for STUDENT conferences with different rates.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "conference_type", nullable = false, unique = true, length = 20)
    private ConferenceType conferenceType;

    @Column(name = "base_fee", nullable = false, precision = 10, scale = 2)
    private BigDecimal baseFee = BigDecimal.ZERO;

    @Column(name = "per_delegate_fee", nullable = false, precision = 10, scale = 2)
    private BigDecimal perDelegateFee = BigDecimal.ZERO;

    @Column(name = "description", length = 300)
    private String description;

    @Column(name = "is_active", nullable = false)
    private boolean isActive = true;

    /*
     * updated_by tracks which admin last changed these rates.
     * Important for accountability.
     */
    @ManyToOne(optional = true)
    @JoinColumn(name = "updated_by", nullable = true)
    private User updatedBy;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public CommissionSetting() {}

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public ConferenceType getConferenceType() { return conferenceType; }
    public void setConferenceType(ConferenceType conferenceType) { this.conferenceType = conferenceType; }

    public BigDecimal getBaseFee() { return baseFee; }
    public void setBaseFee(BigDecimal baseFee) { this.baseFee = baseFee; }

    public BigDecimal getPerDelegateFee() { return perDelegateFee; }
    public void setPerDelegateFee(BigDecimal perDelegateFee) { this.perDelegateFee = perDelegateFee; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public User getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(User updatedBy) { this.updatedBy = updatedBy; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
}
