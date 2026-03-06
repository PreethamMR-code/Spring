package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/*
 * ConferencePricing stores what the organizer must pay to NexMeet
 * in order to list their conference on the platform.
 *
 * This is DIFFERENT from delegate_fee in the Conference table.
 * delegate_fee = what delegates pay to attend (currently 0)
 * ConferencePricing = what organizer pays to list (platform revenue)
 *
 * One conference has exactly One pricing record.
 * That's why this is @OneToOne.
 */
@Entity
@Table(name = "conference_pricing")
public class ConferencePricing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /*
     * @OneToOne means one pricing record per conference.
     * unique = true enforces this at the database level too.
     */
    @OneToOne
    @JoinColumn(name = "conference_id", nullable = false, unique = true)
    private Conference conference;

    @Column(name = "base_fee", nullable = false, precision = 10, scale = 2)
    private BigDecimal baseFee = BigDecimal.ZERO;

    @Column(name = "per_delegate_fee", nullable = false, precision = 10, scale = 2)
    private BigDecimal perDelegateFee = BigDecimal.ZERO;

    @Column(name = "expected_delegates")
    private Integer expectedDelegates = 0;

    /*
     * total_fee = base_fee + (per_delegate_fee * expected_delegates)
     * This is calculated and stored when conference is created.
     * Stored (not computed on the fly) for performance and
     * to keep a historical record even if commission rates change later.
     */
    @Column(name = "total_fee", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalFee = BigDecimal.ZERO;

    @Column(name = "payment_status", nullable = false, length = 20)
    private String paymentStatus = "PENDING";

    @Column(name = "paid_at")
    private LocalDateTime paidAt;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public ConferencePricing() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public BigDecimal getBaseFee() { return baseFee; }
    public void setBaseFee(BigDecimal baseFee) { this.baseFee = baseFee; }

    public BigDecimal getPerDelegateFee() { return perDelegateFee; }
    public void setPerDelegateFee(BigDecimal perDelegateFee) { this.perDelegateFee = perDelegateFee; }

    public Integer getExpectedDelegates() { return expectedDelegates; }
    public void setExpectedDelegates(Integer expectedDelegates) { this.expectedDelegates = expectedDelegates; }

    public BigDecimal getTotalFee() { return totalFee; }
    public void setTotalFee(BigDecimal totalFee) { this.totalFee = totalFee; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public LocalDateTime getPaidAt() { return paidAt; }
    public void setPaidAt(LocalDateTime paidAt) { this.paidAt = paidAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
}
