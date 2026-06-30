package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PaymentService {

    Payment createRegistrationPayment(
            Registration reg,
            User payer,
            Conference conf);

    List<Payment> getPaymentsByConference(
            Long conferenceId);

    List<Payment> getPaymentsByUser(Long userId);

    BigDecimal getTotalRevenueByConference(
            Long conferenceId);

    BigDecimal getPlatformShareByConference(
            Long conferenceId);

    BigDecimal getOrganizerShareByConference(
            Long conferenceId);

    BigDecimal getTotalPlatformRevenue();

    List<Payment> getAllPayments();

    void markVenuePaymentReceived(
            Long conferenceId,
            Long delegateUserId,
            String paymentMethod,
            String paymentReference,
            String organizerEmail);

    Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId);

    org.json.JSONObject createRazorpayOrder(
            Long conferenceId, String delegateEmail)
            throws Exception;

    com.nexmeet.platform.entity.Registration
    verifyAndCompleteRazorpayPayment(
            Long conferenceId,
            String delegateEmail,
            String razorpayOrderId,
            String razorpayPaymentId,
            String razorpaySignature)
            throws Exception;

    /*
     * Initiates a full refund to the delegate via Razorpay.
     * Called inside cancelRegistration() when the payment
     * method is RAZORPAY and status is COMPLETED.
     *
     * Uses POST /v1/payments/{razorpay_payment_id}/refund.
     * No amount param = full refund of the original charge.
     *
     * On success: payment status updated to REFUNDED.
     * On failure: logs the error but does NOT block
     * cancellation — the registration is cancelled
     * regardless. Refund failure is an operational issue
     * to be handled manually, not a reason to prevent
     * the delegate from cancelling.
     *
     * SIMULATED and VENUE_* payments: no-op (no real
     * money was charged via gateway).
     */
    void initiateRazorpayRefund(
            Long conferenceId, Long userId);
}
