package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Registration;

import java.util.List;
import java.util.Optional;

public interface RegistrationService {


    String registerForConference(Long conferenceId, String userEmail);

    long countByUserEmail(String email);

    List<Registration> findByUserEmail(String email);

    String cancelRegistration(Long registrationId, String userEmail);

    Optional<Registration> findById(Long id);

    List<Registration> findByConferenceId(Long conferenceId);

    // Both methods are @Transactional in the impl.
    // Called from ConferenceController which has no transaction
    // of its own — the service layer owns the transaction boundary.

    boolean isAlreadyRegistered(Long conferenceId, String userEmail);

    Optional<Registration> findByConferenceAndUserEmail(
            Long conferenceId, String userEmail);

    /*
     * Register a delegate for a conference when payment
     * has already been confirmed externally (Razorpay).
     * Identical to registerForConference() but SKIPS
     * internal payment creation — the RAZORPAY payment
     * row is already saved and COMPLETED before this is
     * called. Calling createRegistrationPayment() here
     * would create a duplicate SIMULATED row and violate
     * the unique constraint on transaction_ref.
     *
     * Returns the Registration entity (not a String status
     * code) so PaymentService can return it to the
     * controller for redirect logic.
     *
     * Throws RuntimeException on any failure — caller
     * (PaymentServiceImpl) handles it.
     */
    Registration registerDelegatePostPayment(
            Long conferenceId, String delegateEmail);
}
