package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Payment;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface PaymentDao {

    void save(Payment payment);

    List<Payment> findByConferenceId(Long conferenceId);

    List<Payment> findByUserId(Long userId);

    List<Payment> findAll();

    /*
     * Actual revenue collected for a conference
     * (sum of all COMPLETED payment amounts)
     */
    BigDecimal sumAmountByConferenceId(
            Long conferenceId);

    /*
     * Platform's actual share from a conference
     */
    BigDecimal sumPlatformCommissionByConferenceId(
            Long conferenceId);

    /*
     * Organizer's actual payout from a conference
     */
    BigDecimal sumOrganizerAmountByConferenceId(
            Long conferenceId);

    /*
     * Total platform commission across ALL conferences
     * Used on admin dashboard for overall revenue
     */
    BigDecimal sumAllPlatformCommission();

    long countByConferenceId(Long conferenceId);


    /*
     * Find a specific payment by conference + payer.
     * Used by organizer to mark venue payment received.
     */
    Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId);

    /*
     * Update an existing payment record.
     * Used when upgrading SIMULATED → VENUE_CASH/VENUE_UPI.
     */
    void update(Payment payment);
}