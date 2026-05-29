package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.PaymentDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.service.CommissionService;
import com.nexmeet.platform.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class PaymentServiceImpl
        implements PaymentService {

    @Autowired
    private PaymentDao paymentDao;

    @Autowired
    private CommissionService commissionService;

    @Override
    public Payment createRegistrationPayment(
            Registration reg,
            User payer,
            Conference conf) {

        /*
         * Skip payment creation for free conferences.
         * No money changes hands — nothing to record.
         */
        if (conf.isFree()
                || conf.getDelegateFee() == null
                || conf.getDelegateFee()
                .compareTo(BigDecimal.ZERO) == 0) {
            return null;
        }

        BigDecimal delegateFee = conf.getDelegateFee();
        String confType = conf.getConferenceType().name();

        /*
         * Platform takes perDelegateFee per registration.
         * Capped at delegateFee — can't take more than
         * what delegate paid.
         */
        BigDecimal perDelegate =
                commissionService.getPerDelegateFee(
                        confType);
        BigDecimal platformCut =
                perDelegate.min(delegateFee);

        /*
         * Organizer keeps the rest.
         * Never goes negative.
         */
        BigDecimal organizerCut =
                delegateFee.subtract(platformCut);
        if (organizerCut.compareTo(
                BigDecimal.ZERO) < 0) {
            organizerCut = BigDecimal.ZERO;
        }

        /*
         * Determine payment_for label.
         * BULK_REGISTRATION = came from CSV/Excel upload
         * REGISTRATION      = individual self-registration
         */
        String paymentFor = "REGISTRATION";
        if (reg.getRegistrationType() != null
                && "BULK".equals(
                reg.getRegistrationType()
                        .name())) {
            paymentFor = "BULK_REGISTRATION";
        }

        Payment payment = new Payment();
        payment.setPayerUser(payer);
        payment.setConference(conf);
        payment.setPaymentFor(paymentFor);
        payment.setAmount(delegateFee);
        payment.setPlatformCommission(platformCut);
        payment.setOrganizerAmount(organizerCut);
        payment.setPaymentMethod("SIMULATED");

        /*
         * Unique transaction reference.
         * Format: SIM-XXXX-XXXX-XXXX
         * In production: Razorpay/Stripe order ID here.
         */
        payment.setTransactionRef(
                "SIM-" +
                        UUID.randomUUID()
                                .toString()
                                .substring(0, 8)
                                .toUpperCase());

        /*
         * Simulated payment = COMPLETED immediately.
         * Real payment gateway = stays INITIATED until
         * webhook callback updates status.
         */
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(LocalDateTime.now());

        paymentDao.save(payment);
        return payment;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getPaymentsByConference(
            Long conferenceId) {
        return paymentDao
                .findByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getPaymentsByUser(
            Long userId) {
        return paymentDao.findByUserId(userId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalRevenueByConference(
            Long conferenceId) {
        return paymentDao
                .sumAmountByConferenceId(conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getPlatformShareByConference(
            Long conferenceId) {
        return paymentDao
                .sumPlatformCommissionByConferenceId(
                        conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getOrganizerShareByConference(
            Long conferenceId) {
        return paymentDao
                .sumOrganizerAmountByConferenceId(
                        conferenceId);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalPlatformRevenue() {
        return paymentDao.sumAllPlatformCommission();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> getAllPayments() {
        return paymentDao.findAll();
    }

    @Override
    @Transactional
    public void markVenuePaymentReceived(
            Long conferenceId,
            Long delegateUserId,
            String paymentMethod,
            String paymentReference,
            String organizerEmail) {

        /*
         * paymentMethod must be VENUE_CASH or VENUE_UPI.
         * Reject anything else to prevent data corruption.
         */
        if (!"VENUE_CASH".equals(paymentMethod)
                && !"VENUE_UPI".equals(paymentMethod)) {
            throw new IllegalArgumentException(
                    "Invalid payment method: " + paymentMethod
                            + ". Must be VENUE_CASH or VENUE_UPI.");
        }

        Payment payment = paymentDao
                .findByConferenceAndUser(
                        conferenceId, delegateUserId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "No payment record found for " +
                                        "this delegate and conference."));

        /*
         * Idempotency: if already confirmed,
         * don't overwrite with same data.
         */
        if ("VENUE_CASH".equals(payment.getPaymentMethod())
                || "VENUE_UPI".equals(
                payment.getPaymentMethod())) {
            return; // already marked, skip silently
        }

        payment.setPaymentMethod(paymentMethod);
        payment.setStatus("COMPLETED");
        payment.setCompletedAt(
                java.time.LocalDateTime.now());

        if (paymentReference != null
                && !paymentReference.trim().isEmpty()) {
            payment.setTransactionRef(
                    paymentReference.trim());
        }

        paymentDao.update(payment);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId) {
        return paymentDao.findByConferenceAndUser(
                conferenceId, userId);
    }
}