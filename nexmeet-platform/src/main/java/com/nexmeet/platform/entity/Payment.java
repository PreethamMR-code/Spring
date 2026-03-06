package com.nexmeet.platform.entity;


import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/*
 * Payment records every financial transaction on NexMeet.
 * Currently: organizer pays a platform listing fee.
 * Later: delegates will also pay conference fees.
 *
 * payment_for distinguishes which type of payment this is.
 */
@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "payer_user_id", nullable = false)
    private User payerUser;

    @ManyToOne
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    /*
     * payment_for = CONFERENCE_LISTING_FEE (organizer pays to list)
     *             = DELEGATE_FEE (delegate pays to attend) — future
     */
    @Column(name = "payment_for", nullable = false, length = 30)
    private String paymentFor;

    @Column(name = "amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "platform_commission", precision = 10, scale = 2)
    private BigDecimal platformCommission = BigDecimal.ZERO;

    @Column(name = "organizer_amount", precision = 10, scale = 2)
    private BigDecimal organizerAmount = BigDecimal.ZERO;

    @Column(name = "payment_method", length = 20)
    private String paymentMethod = "SIMULATED";

    /*
     * transaction_ref is the unique payment reference number.
     * In real payment gateways (Razorpay, Stripe), this comes
     * from their system. We generate a fake one for simulation.
     */
    @Column(name = "transaction_ref", unique = true, length = 100)
    private String transactionRef;

    @Column(name = "status", nullable = false, length = 20)
    private String status = "INITIATED";

    @Column(name = "initiated_at", nullable = false, updatable = false)
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
    public void setId(Long id) { this.id = id; }

    public User getPayerUser() { return payerUser; }
    public void setPayerUser(User payerUser) { this.payerUser = payerUser; }

    public Conference getConference() { return conference; }
    public void setConference(Conference conference) { this.conference = conference; }

    public String getPaymentFor() { return paymentFor; }
    public void setPaymentFor(String paymentFor) { this.paymentFor = paymentFor; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public BigDecimal getPlatformCommission() { return platformCommission; }
    public void setPlatformCommission(BigDecimal platformCommission) { this.platformCommission = platformCommission; }

    public BigDecimal getOrganizerAmount() { return organizerAmount; }
    public void setOrganizerAmount(BigDecimal organizerAmount) { this.organizerAmount = organizerAmount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getTransactionRef() { return transactionRef; }
    public void setTransactionRef(String transactionRef) { this.transactionRef = transactionRef; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getInitiatedAt() { return initiatedAt; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
}
