package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.CommissionInvoiceDao;
import com.nexmeet.platform.entity.*;
import com.nexmeet.platform.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class CommissionInvoiceServiceImpl
        implements CommissionInvoiceService {

    @Autowired
    private CommissionInvoiceDao invoiceDao;

    @Autowired
    private ConferenceService conferenceService;

    @Autowired
    private CommissionService commissionService;

    @Autowired
    private UserService userService;

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private AuditLogService auditLogService;

    @Override
    public CommissionInvoice generateInvoice(
            Long conferenceId, String adminEmail) {

        Conference conf = conferenceService
                .findById(conferenceId)
                .orElseThrow(() ->
                        new RuntimeException("Conference not found"));

        /*
         * Only generate for COMPLETED conferences.
         * No point invoicing for an ongoing or cancelled event.
         */
        if (!conf.getStatus().name().equals("COMPLETED")) {
            throw new RuntimeException(
                    "Invoice can only be generated for " +
                            "COMPLETED conferences.");
        }

        /*
         * Idempotency: if invoice already exists, return it.
         * Admin can click "Generate Invoice" multiple times safely.
         */
        Optional<CommissionInvoice> existing =
                invoiceDao.findByConferenceId(conferenceId);
        if (existing.isPresent()) {
            return existing.get();
        }

        /*
         * Free conferences: no invoice needed.
         * Platform commission_settings may still have base_fee,
         * but we waive it for free events as a product decision.
         */
        if (conf.isFree()) {
            throw new RuntimeException(
                    "No invoice required for free conferences.");
        }

        String confType = conf.getConferenceType().name();
        BigDecimal baseFee =
                commissionService.getBaseFee(confType);
        BigDecimal perDelegateFee =
                commissionService.getPerDelegateFee(confType);
        int regCount = conf.getRegisteredCount();

        /*
         * total = base_fee + (per_delegate_fee × registered_count)
         * This matches what the platform offered:
         *   - Listing the conference (base fee)
         *   - Processing each registration (per-delegate fee)
         */
        BigDecimal total = baseFee
                .add(perDelegateFee
                        .multiply(BigDecimal.valueOf(regCount)));

        CommissionInvoice invoice = new CommissionInvoice();
        invoice.setConference(conf);
        invoice.setOrganizer(conf.getOrganizer());
        invoice.setInvoiceNumber(
                "NM-INV-" + Year.now().getValue()
                        + "-" + UUID.randomUUID()
                        .toString()
                        .substring(0, 6)
                        .toUpperCase());
        invoice.setBaseFee(baseFee);
        invoice.setPerDelegateFee(perDelegateFee);
        invoice.setRegisteredCount(regCount);
        invoice.setTotalAmount(total);
        invoice.setStatus("PENDING");

        userService.findByEmail(adminEmail)
                .ifPresent(invoice::setGeneratedBy);

        invoiceDao.save(invoice);

        // Notify organizer in-app
        notificationService.createNotification(
                conf.getOrganizer().getUser().getEmail(),
                "Platform Invoice Generated",
                "Invoice " + invoice.getInvoiceNumber()
                        + " for ₹" + total.toPlainString()
                        + " has been raised for: "
                        + conf.getTitle()
                        + ". Please pay to continue hosting on NexMeet.",
                "IN_APP"
        );

        // Audit log
        try {
            auditLogService.log(
                    adminEmail,
                    "INVOICE_GENERATED",
                    "CommissionInvoice",
                    invoice.getId(),
                    "Invoice: " + invoice.getInvoiceNumber()
                            + " | Amount: ₹" + total
                            + " | Conference: " + conf.getTitle());
        } catch (Exception ignored) {}

        return invoice;
    }

    @Override
    public void markAsPaid(Long invoiceId,
                           String paymentReference,
                           String adminEmail) {
        CommissionInvoice invoice =
                invoiceDao.findById(invoiceId)
                        .orElseThrow(() ->
                                new RuntimeException("Invoice not found"));

        if ("PAID".equals(invoice.getStatus())) {
            throw new RuntimeException(
                    "Invoice is already marked as paid.");
        }

        invoice.setStatus("PAID");
        invoice.setPaymentReference(paymentReference);
        invoice.setPaidAt(LocalDateTime.now());
        invoiceDao.update(invoice);

        // Notify organizer
        notificationService.createNotification(
                invoice.getOrganizer().getUser().getEmail(),
                "Payment Received",
                "Your payment for invoice "
                        + invoice.getInvoiceNumber()
                        + " (₹" + invoice.getTotalAmount()
                        + ") has been confirmed. Thank you!",
                "IN_APP"
        );

        try {
            auditLogService.log(
                    adminEmail,
                    "INVOICE_PAID",
                    "CommissionInvoice",
                    invoiceId,
                    "Invoice: " + invoice.getInvoiceNumber()
                            + " | Ref: " + paymentReference);
        } catch (Exception ignored) {}
    }

    @Override
    public void waiveInvoice(Long invoiceId,
                             String notes,
                             String adminEmail) {
        CommissionInvoice invoice =
                invoiceDao.findById(invoiceId)
                        .orElseThrow(() ->
                                new RuntimeException("Invoice not found"));

        invoice.setStatus("WAIVED");
        invoice.setNotes(notes);
        invoiceDao.update(invoice);

        notificationService.createNotification(
                invoice.getOrganizer().getUser().getEmail(),
                "Invoice Waived",
                "Your platform invoice "
                        + invoice.getInvoiceNumber()
                        + " has been waived by the admin.",
                "IN_APP"
        );

        try {
            auditLogService.log(
                    adminEmail,
                    "INVOICE_WAIVED",
                    "CommissionInvoice",
                    invoiceId,
                    "Invoice: " + invoice.getInvoiceNumber()
                            + " | Notes: " + notes);
        } catch (Exception ignored) {}
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CommissionInvoice> findByConferenceId(
            Long conferenceId) {
        return invoiceDao.findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommissionInvoice> findByOrganizerId(
            Long organizerId) {
        return invoiceDao.findByOrganizerId(organizerId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommissionInvoice> findAll() {
        return invoiceDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countPending() {
        return invoiceDao.countPending();
    }

    @Override
    public void submitPaymentReference(Long invoiceId,
                                       String reference,
                                       String organizerEmail) {

        CommissionInvoice invoice = invoiceDao.findById(invoiceId)
                .orElseThrow(() ->
                        new RuntimeException("Invoice not found"));

        // Security: only the owning organizer can submit
        if (!invoice.getOrganizer().getUser()
                .getEmail().equals(organizerEmail)) {
            throw new RuntimeException("Unauthorized");
        }

        if (!"PENDING".equals(invoice.getStatus())) {
            throw new RuntimeException(
                    "This invoice is not awaiting payment.");
        }

        if (reference == null || reference.trim().isEmpty()) {
            throw new RuntimeException(
                    "Please enter a payment reference.");
        }

        invoice.setSubmittedPaymentReference(reference.trim());
        invoice.setSubmittedAt(LocalDateTime.now());
        invoiceDao.update(invoice);

        /*
         * Notify the admin who generated this invoice that the
         * organizer claims to have paid. Admin still verifies
         * the bank/UPI statement before clicking "Mark as Paid".
         */
        if (invoice.getGeneratedBy() != null) {
            notificationService.createNotification(
                    invoice.getGeneratedBy().getEmail(),
                    "Payment Reference Submitted",
                    "Organizer " + invoice.getOrganizer()
                            .getUser().getFullName()
                            + " submitted payment reference \""
                            + reference.trim()
                            + "\" for invoice "
                            + invoice.getInvoiceNumber()
                            + " (₹" + invoice.getTotalAmount()
                            + "). Please verify and confirm.",
                    "IN_APP"
            );
        }

        try {
            auditLogService.log(
                    organizerEmail,
                    "INVOICE_PAYMENT_SUBMITTED",
                    "CommissionInvoice",
                    invoiceId,
                    "Invoice: " + invoice.getInvoiceNumber()
                            + " | Reference: " + reference.trim());
        } catch (Exception ignored) {}
    }
}