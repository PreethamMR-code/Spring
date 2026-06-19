package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.PaymentDao;
import com.nexmeet.platform.entity.Payment;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class PaymentDaoImpl implements PaymentDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Payment payment) {
        sessionFactory.getCurrentSession()
                .persist(payment);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> findByConferenceId(
            Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Payment p " +
                                "WHERE p.conference.id = :cid " +
                                "ORDER BY p.initiatedAt DESC",
                        Payment.class)
                .setParameter("cid", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> findByUserId(Long userId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Payment p " +
                                "WHERE p.payerUser.id = :uid " +
                                "ORDER BY p.initiatedAt DESC",
                        Payment.class)
                .setParameter("uid", userId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Payment> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Payment p " +
                                "ORDER BY p.initiatedAt DESC",
                        Payment.class)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal sumAmountByConferenceId(
            Long conferenceId) {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT SUM(p.amount) " +
                                "FROM Payment p " +
                                "WHERE p.conference.id = :cid " +
                                "AND p.status = 'COMPLETED'")
                .setParameter("cid", conferenceId)
                .uniqueResult();
        return r != null ? (BigDecimal) r
                : BigDecimal.ZERO;
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal sumPlatformCommissionByConferenceId(
            Long conferenceId) {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT SUM(p.platformCommission) " +
                                "FROM Payment p " +
                                "WHERE p.conference.id = :cid " +
                                "AND p.status = 'COMPLETED'")
                .setParameter("cid", conferenceId)
                .uniqueResult();
        return r != null ? (BigDecimal) r
                : BigDecimal.ZERO;
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal sumOrganizerAmountByConferenceId(
            Long conferenceId) {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT SUM(p.organizerAmount) " +
                                "FROM Payment p " +
                                "WHERE p.conference.id = :cid " +
                                "AND p.status = 'COMPLETED'")
                .setParameter("cid", conferenceId)
                .uniqueResult();
        return r != null ? (BigDecimal) r
                : BigDecimal.ZERO;
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal sumAllPlatformCommission() {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT SUM(p.platformCommission) " +
                                "FROM Payment p " +
                                "WHERE p.status = 'COMPLETED'")
                .uniqueResult();
        return r != null ? (BigDecimal) r
                : BigDecimal.ZERO;
    }

    @Override
    @Transactional(readOnly = true)
    public long countByConferenceId(Long conferenceId) {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(p.id) FROM Payment p " +
                                "WHERE p.conference.id = :cid")
                .setParameter("cid", conferenceId)
                .uniqueResult();
        return r != null
                ? ((Number) r).longValue() : 0L;
    }

    @Override
    public void update(Payment payment) {
        sessionFactory.getCurrentSession().update(payment);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Payment> findByConferenceAndUser(
            Long conferenceId, Long userId) {
        try {
            Payment p = sessionFactory.getCurrentSession()
                    .createQuery(
                            "FROM Payment p " +
                                    "WHERE p.conference.id = :cid " +
                                    "AND p.payerUser.id = :uid",
                            Payment.class)
                    .setParameter("cid", conferenceId)
                    .setParameter("uid", userId)
                    .getSingleResult();
            return Optional.of(p);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Payment> findByRazorpayOrderId(
            String orderId) {
        try {
            Payment p = sessionFactory.getCurrentSession()
                    .createQuery(
                            "FROM Payment p " +
                                    "WHERE p.razorpayOrderId = :oid",
                            Payment.class)
                    .setParameter("oid", orderId)
                    .getSingleResult();
            return Optional.of(p);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }

}