package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Payment;
import java.math.BigDecimal;
import java.util.List;

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
}