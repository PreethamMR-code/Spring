package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.service.CommissionService;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;


@Service
@Transactional(readOnly = true)
public class CommissionServiceImpl implements CommissionService {


    @Autowired
    private SessionFactory sessionFactory;

    /*
     * Looks up commission settings by conference type.
     * Falls back to DEFAULT if type not found.
     * Returns [baseFee, perDelegateFee] as Object[].
     */
    private Object[] getSettingForType(String conferenceType) {
        try {
            Object[] result = (Object[]) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "SELECT cs.baseFee, cs.perDelegateFee " +
                                    "FROM CommissionSetting cs " +
                                    "WHERE cs.conferenceType = :type " +
                                    "AND cs.active = true")
                    .setParameter("type", conferenceType)
                    .uniqueResult();

            if (result != null) return result;

            // Fallback to DEFAULT
            return (Object[]) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "SELECT cs.baseFee, cs.perDelegateFee " +
                                    "FROM CommissionSetting cs " +
                                    "WHERE cs.conferenceType = 'DEFAULT' " +
                                    "AND cs.active = true")
                    .uniqueResult();

        } catch (Exception e) {
            // Hard fallback if table empty
            return new Object[]{
                    new BigDecimal("300.00"),
                    new BigDecimal("15.00")
            };
        }
    }

    @Override
    public BigDecimal getBaseFee(String conferenceType) {
        Object[] r = getSettingForType(conferenceType);
        return r != null ? (BigDecimal) r[0] : new BigDecimal("300");
    }

    @Override
    public BigDecimal getPerDelegateFee(String conferenceType) {
        Object[] r = getSettingForType(conferenceType);
        return r != null ? (BigDecimal) r[1] : new BigDecimal("15");
    }

    @Override
    public BigDecimal calculatePlatformEarnings(Long conferenceId) {
        /*
         * Platform earns:
         *   base_fee (fixed listing fee)
         * + per_delegate_fee × confirmed registrations
         *
         * This is independent of the delegate fee paid to
         * organizer — it's what the organizer owes the platform.
         */
        try {
            Object[] conf = (Object[]) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "SELECT c.registeredCount, " +
                                    "c.conferenceType FROM Conference c " +
                                    "WHERE c.id = :id")
                    .setParameter("id", conferenceId)
                    .uniqueResult();

            if (conf == null) return BigDecimal.ZERO;

            long registeredCount =
                    ((Number) conf[0]).longValue();
            String type = (String) conf[1];

            BigDecimal baseFee = getBaseFee(type);
            BigDecimal perDelegate = getPerDelegateFee(type);

            return baseFee.add(
                    perDelegate.multiply(
                            BigDecimal.valueOf(registeredCount)));

        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    @Override
    public BigDecimal getTotalPlatformEarnings() {
        try {
            List<Long> ids = sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "SELECT c.id FROM Conference c " +
                                    "WHERE c.status IN (:approved, :completed)",
                            Long.class)
                    .setParameter("approved", ConferenceStatus.APPROVED)
                    .setParameter("completed", ConferenceStatus.COMPLETED)
                    .getResultList();


            BigDecimal total = BigDecimal.ZERO;
            for (Long id : ids) {
                total = total.add(
                        calculatePlatformEarnings(id));
            }
            return total;
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    @Override
    public BigDecimal calculateOrganizerPayout(Long conferenceId) {
        /*
         * Organizer keeps: (delegate_fee × registrations)
         * minus platform per_delegate_fee × registrations
         * minus base_fee
         *
         * If free conference, organizer pays only base_fee.
         */
        try {
            Object[] conf = (Object[]) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "SELECT c.registeredCount, c.delegateFee, " +
                                    "c.isFree, c.conferenceType " +
                                    "FROM Conference c WHERE c.id = :id")
                    .setParameter("id", conferenceId)
                    .uniqueResult();

            if (conf == null) return BigDecimal.ZERO;

            long registered = ((Number) conf[0]).longValue();
            BigDecimal delegateFee = (BigDecimal) conf[1];
            boolean isFree = (boolean) conf[2];
            String type = (String) conf[3];

            BigDecimal baseFee = getBaseFee(type);
            BigDecimal perDelegate = getPerDelegateFee(type);

            BigDecimal delegateRevenue = isFree
                    ? BigDecimal.ZERO
                    : (delegateFee != null
                    ? delegateFee.multiply(
                    BigDecimal.valueOf(registered))
                    : BigDecimal.ZERO);

            BigDecimal platformCut = baseFee.add(
                    perDelegate.multiply(
                            BigDecimal.valueOf(registered)));

            // Organizer payout = what delegates paid minus
            // platform cut
            BigDecimal payout = delegateRevenue
                    .subtract(platformCut);

            // Never go negative
            return payout.compareTo(BigDecimal.ZERO) < 0
                    ? BigDecimal.ZERO : payout;

        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    @Override
    public List<Object[]> getAllCommissionSettings() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT cs.conferenceType, cs.baseFee, " +
                                "cs.perDelegateFee, cs.description, " +
                                "cs.active " +
                                "FROM CommissionSetting cs " +
                                "ORDER BY cs.conferenceType ASC",
                        Object[].class)
                .getResultList();
    }
}
