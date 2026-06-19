package com.nexmeet.platform.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

@Getter
@Setter
@NoArgsConstructor
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
     * Razorpay order ID returned by /v1/orders API.
     * Created on the server when delegate clicks "Pay Now".
     * Format: order_XXXXXXXXXXXXXXXXXX
     */
    @Column(name = "razorpay_order_id", length = 100)
    private String razorpayOrderId;

    /*
     * Razorpay payment ID returned after delegate
     * completes payment in the Checkout popup.
     * Format: pay_XXXXXXXXXXXXXXXXXX
     */
    @Column(name = "razorpay_payment_id", length = 100)
    private String razorpayPaymentId;

    /*
     * HMAC-SHA256 signature returned by Razorpay.
     * Verified server-side to confirm payment is genuine.
     * razorpay_order_id + "|" + razorpay_payment_id
     * hashed with key_secret.
     */
    @Column(name = "razorpay_signature", length = 255)
    private String razorpaySignature;

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


}