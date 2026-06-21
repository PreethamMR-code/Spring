package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PaymentService {

    /*
     * Creates a SIMULATED payment for a conference
     * registration. Called automatically after
     * each successful registration (individual or bulk).
     *
     * Returns null if the conference is free — no
     * payment record is created for free events.
     *
     * The payment is immediately marked COMPLETED
     * to simulate instant payment processing.
     * In production: stay INITIATED until gateway
     * callback confirms.
     */
    Payment createRegistrationPayment(
            Registration reg,
            User payer,
            Conference conf);

    /*
     * All payments for a conference.
     * Used by organizer to see who paid.
     */
    List<Payment> getPaymentsByConference(
            Long conferenceId);

    /*
     * All payments made by a specific user.
     * Used on delegate dashboard.
     */
    List<Payment> getPaymentsByUser(Long userId);

    /*
     * Total delegate fees collected for a conference.
     */
    BigDecimal getTotalRevenueByConference(
            Long conferenceId);

    /*
     * Platform's share from a conference.
     */
    BigDecimal getPlatformShareByConference(
            Long conferenceId);

    /*
     * Organizer's actual payout from a conference.
     */
    BigDecimal getOrganizerShareByConference(
            Long conferenceId);

    /*
     * Total platform commission across all conferences.
     * Used on admin dashboard.
     */
    BigDecimal getTotalPlatformRevenue();

    /*
     * All payments — admin view.
     */
    List<Payment> getAllPayments();

    /*
     * Organizer confirms delegate paid at venue.
     * Updates payment method from SIMULATED to
     * VENUE_CASH or VENUE_UPI.
     * paymentReference = optional UPI transaction ID
     * or cash receipt note.
     */
    void markVenuePaymentReceived(
            Long conferenceId,
            Long delegateUserId,
            String paymentMethod,
            String paymentReference,
            String organizerEmail);

    /*
     * Find a specific payment by conference + payer user.
     * Used by organizer delegate list to show per-delegate
     * payment status.
     */

    Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId);

    /*
     * Creates a Razorpay order via REST API.
     * Returns the order JSON so the controller can
     * send order_id + amount to the JSP/JS frontend.
     * Amount is in PAISE (multiply rupees × 100).
     */
    org.json.JSONObject createRazorpayOrder(
            Long conferenceId, String delegateEmail)
            throws Exception;

    /*
     * Verifies Razorpay signature server-side using
     * HMAC-SHA256(order_id + "|" + payment_id, key_secret).
     * If valid, saves the payment IDs, marks COMPLETED,
     * and triggers the existing registration flow:
     * QR generation, ticket email, notifications.
     * Returns the Registration so controller can redirect.
     */
    com.nexmeet.platform.entity.Registration
    verifyAndCompleteRazorpayPayment(
            Long conferenceId,
            String delegateEmail,
            String razorpayOrderId,
            String razorpayPaymentId,
            String razorpaySignature)
            throws Exception;
}