package com.nexmeet.platform.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/*
 * Tracks every payment made on the platform.
 *
 * For Phase 36 (simulation): no real payment gateway.
 * Every registration for a PAID conference auto-creates
 * a Payment record with status = COMPLETED immediately.
 *
 * payment_for: "REGISTRATION" or "BULK_REGISTRATION"
 * status:      "INITIATED" → "COMPLETED" (simulated instantly)
 *
 * amount           = conference.delegateFee (what delegate pays)
 * platform_commission = perDelegateFee from commission_settings
 * organizer_amount = amount - platform_commission
 *
 * In a real system: status stays INITIATED until payment
 * gateway confirms, then moves to COMPLETED.
 */
@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "payer_user_id", nullable = false)
    private User payerUser;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    /*
     * What the payment is for.
     * "REGISTRATION"      = delegate registered themselves
     * "BULK_REGISTRATION" = organizer uploaded CSV
     */
    @Column(name = "payment_for",
            nullable = false, length = 30)
    private String paymentFor = "REGISTRATION";

    /*
     * Total amount paid by the delegate.
     * = conference.delegateFee
     */
    @Column(name = "amount",
            nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    /*
     * Platform's share of the payment.
     * = perDelegateFee from commission_settings
     */
    @Column(name = "platform_commission",
            precision = 10, scale = 2)
    private BigDecimal platformCommission =
            BigDecimal.ZERO;

    /*
     * Organizer's share = amount - platform_commission
     */
    @Column(name = "organizer_amount",
            precision = 10, scale = 2)
    private BigDecimal organizerAmount =
            BigDecimal.ZERO;

    /*
     * "SIMULATED" for Phase 36.
     * Later: "UPI", "CARD", "NET_BANKING", "RAZORPAY"
     */
    @Column(name = "payment_method", length = 20)
    private String paymentMethod = "SIMULATED";

    /*
     * Unique reference for this payment.
     * Format: SIM-XXXXXXXXXXXX (12 hex chars)
     * In production: gateway transaction ID.
     */
    @Column(name = "transaction_ref",
            length = 100, unique = true)
    private String transactionRef;

    /*
     * INITIATED  = payment started, awaiting gateway
     * COMPLETED  = payment confirmed
     * FAILED     = payment failed
     * REFUNDED   = payment refunded (cancellation)
     *
     * Simulation: always COMPLETED immediately.
     */
    @Column(name = "status",
            nullable = false, length = 20)
    private String status = "INITIATED";

    @Column(name = "initiated_at",
            nullable = false, updatable = false)
    private LocalDateTime initiatedAt;

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

    @PrePersist
    protected void onCreate() {
        initiatedAt = LocalDateTime.now();
    }

    public Payment() {}

    // Getters and Setters
    public Long getId() { return id; }

    public User getPayerUser() { return payerUser; }
    public void setPayerUser(User u) {
        payerUser = u;
    }

    public Conference getConference() {
        return conference;
    }
    public void setConference(Conference c) {
        conference = c;
    }

    public String getPaymentFor() {
        return paymentFor;
    }
    public void setPaymentFor(String p) {
        paymentFor = p;
    }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal a) { amount = a; }

    public BigDecimal getPlatformCommission() {
        return platformCommission;
    }
    public void setPlatformCommission(BigDecimal p) {
        platformCommission = p;
    }

    public BigDecimal getOrganizerAmount() {
        return organizerAmount;
    }
    public void setOrganizerAmount(BigDecimal o) {
        organizerAmount = o;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }
    public void setPaymentMethod(String m) {
        paymentMethod = m;
    }

    public String getTransactionRef() {
        return transactionRef;
    }
    public void setTransactionRef(String t) {
        transactionRef = t;
    }

    public String getStatus() { return status; }
    public void setStatus(String s) { status = s; }

    public LocalDateTime getInitiatedAt() {
        return initiatedAt;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }
    public void setCompletedAt(LocalDateTime c) {
        completedAt = c;
    }
}