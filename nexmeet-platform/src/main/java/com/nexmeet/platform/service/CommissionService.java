package com.nexmeet.platform.service;

import java.math.BigDecimal;
import java.util.List;

public interface CommissionService {


    BigDecimal getBaseFee(String conferenceType);

    BigDecimal getPerDelegateFee(String conferenceType);

    // Calculate platform earnings from a conference
    BigDecimal calculatePlatformEarnings(Long conferenceId);

    // Calculate total platform earnings across all conferences
    BigDecimal getTotalPlatformEarnings();

    // Calculate organizer payout for a conference
    BigDecimal calculateOrganizerPayout(Long conferenceId);

    List<Object[]> getAllCommissionSettings();
}
