package com.nexmeet.platform.entity;

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
@Table(name = "commission_invoices")
public class CommissionInvoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "conference_id", nullable = false)
    private Conference conference;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organizer_id", nullable = false)
    private Organizer organizer;

    @Column(name = "invoice_number",
            nullable = false, length = 50)
    private String invoiceNumber;

    @Column(name = "base_fee", nullable = false)
    private BigDecimal baseFee = BigDecimal.ZERO;

    @Column(name = "per_delegate_fee", nullable = false)
    private BigDecimal perDelegateFee = BigDecimal.ZERO;

    @Column(name = "registered_count", nullable = false)
    private int registeredCount;

    @Column(name = "total_amount", nullable = false)
    private BigDecimal totalAmount = BigDecimal.ZERO;

    /*
     * PENDING  = invoice generated, payment awaited
     * PAID     = admin confirmed payment received
     * WAIVED   = admin waived (NGO/GOVT or goodwill)
     */
    @Column(name = "status",
            nullable = false, length = 20)
    private String status = "PENDING";

    @Column(name = "payment_reference", length = 200)
    private String paymentReference;

    @Column(name = "notes", length = 500)
    private String notes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "generated_by")
    private User generatedBy;

    @Column(name = "generated_at",
            nullable = false, updatable = false)
    private LocalDateTime generatedAt;

    @Column(name = "paid_at")
    private LocalDateTime paidAt;

    /*
     * Organizer's self-reported payment reference.
     * Distinct from `paymentReference` (set by admin after
     * verification). This is the organizer's CLAIM —
     * admin still must verify before marking PAID.
     */
    @Column(name = "submitted_payment_reference", length = 200)
    private String submittedPaymentReference;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
        if (this.generatedAt == null) {
            this.generatedAt = LocalDateTime.now();
        }
    }

}