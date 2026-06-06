package com.nexmeet.platform.entity;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

@Getter
@Setter
@NoArgsConstructor
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


}
