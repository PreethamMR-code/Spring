package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.CommissionInvoice;
import java.util.List;
import java.util.Optional;

public interface CommissionInvoiceService {

    /*
     * Generate invoice for a completed conference.
     * Idempotent — returns existing invoice if already generated.
     * Throws if conference is not COMPLETED.
     */
    CommissionInvoice generateInvoice(
            Long conferenceId, String adminEmail);

    /*
     * Admin marks invoice as paid after receiving offline payment.
     * paymentReference = UTR number / UPI transaction ID
     */
    void markAsPaid(Long invoiceId,
                    String paymentReference,
                    String adminEmail);

    /*
     * Admin waives invoice (NGO, GOVT, or special case).
     */
    void waiveInvoice(Long invoiceId,
                      String notes,
                      String adminEmail);

    Optional<CommissionInvoice> findByConferenceId(
            Long conferenceId);

    List<CommissionInvoice> findByOrganizerId(
            Long organizerId);

    List<CommissionInvoice> findAll();

    long countPending();

    /*
     * Organizer submits their payment reference (UTR/UPI/Cheque)
     * after transferring the commission amount offline.
     * Does NOT mark the invoice as PAID — only admin can do
     * that after verifying the bank statement. This records
     * the claim and notifies the admin who generated the invoice.
     */
    void submitPaymentReference(Long invoiceId,
                                String reference,
                                String organizerEmail);
}