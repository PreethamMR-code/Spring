package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Payment;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;

import java.math.BigDecimal;
import java.util.List;

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
}