package com.nexmeet.platform.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

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

    @PrePersist
    protected void onCreate() {
        if (this.generatedAt == null) {
            this.generatedAt = LocalDateTime.now();
        }
    }

    // ── Getters & Setters ──────────────────────────
    public Long getId()                             { return id; }
    public void setId(Long id)                      { this.id = id; }

    public Conference getConference()               { return conference; }
    public void setConference(Conference c)         { this.conference = c; }

    public Organizer getOrganizer()                 { return organizer; }
    public void setOrganizer(Organizer o)           { this.organizer = o; }

    public String getInvoiceNumber()                { return invoiceNumber; }
    public void setInvoiceNumber(String n)          { this.invoiceNumber = n; }

    public BigDecimal getBaseFee()                  { return baseFee; }
    public void setBaseFee(BigDecimal b)            { this.baseFee = b; }

    public BigDecimal getPerDelegateFee()           { return perDelegateFee; }
    public void setPerDelegateFee(BigDecimal p)     { this.perDelegateFee = p; }

    public int getRegisteredCount()                 { return registeredCount; }
    public void setRegisteredCount(int r)           { this.registeredCount = r; }

    public BigDecimal getTotalAmount()              { return totalAmount; }
    public void setTotalAmount(BigDecimal t)        { this.totalAmount = t; }

    public String getStatus()                       { return status; }
    public void setStatus(String s)                 { this.status = s; }

    public String getPaymentReference()             { return paymentReference; }
    public void setPaymentReference(String r)       { this.paymentReference = r; }

    public String getNotes()                        { return notes; }
    public void setNotes(String n)                  { this.notes = n; }

    public User getGeneratedBy()                    { return generatedBy; }
    public void setGeneratedBy(User u)              { this.generatedBy = u; }

    public LocalDateTime getGeneratedAt()           { return generatedAt; }
    public void setGeneratedAt(LocalDateTime t)     { this.generatedAt = t; }

    public LocalDateTime getPaidAt()                { return paidAt; }
    public void setPaidAt(LocalDateTime t)          { this.paidAt = t; }
}