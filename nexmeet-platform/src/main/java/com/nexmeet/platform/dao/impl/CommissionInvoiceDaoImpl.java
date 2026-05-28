package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.CommissionInvoiceDao;
import com.nexmeet.platform.entity.CommissionInvoice;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class CommissionInvoiceDaoImpl
        implements CommissionInvoiceDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(CommissionInvoice invoice) {
        sessionFactory.getCurrentSession().persist(invoice);
    }

    @Override
    public void update(CommissionInvoice invoice) {
        sessionFactory.getCurrentSession().update(invoice);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CommissionInvoice> findById(Long id) {
        return Optional.ofNullable(
                sessionFactory.getCurrentSession()
                        .get(CommissionInvoice.class, id));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CommissionInvoice> findByConferenceId(
            Long conferenceId) {
        try {
            CommissionInvoice inv =
                    sessionFactory.getCurrentSession()
                            .createQuery(
                                    "FROM CommissionInvoice ci " +
                                            "WHERE ci.conference.id = :cid",
                                    CommissionInvoice.class)
                            .setParameter("cid", conferenceId)
                            .getSingleResult();
            return Optional.of(inv);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommissionInvoice> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM CommissionInvoice ci " +
                                "ORDER BY ci.generatedAt DESC",
                        CommissionInvoice.class)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CommissionInvoice> findByOrganizerId(
            Long organizerId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM CommissionInvoice ci " +
                                "WHERE ci.organizer.id = :oid " +
                                "ORDER BY ci.generatedAt DESC",
                        CommissionInvoice.class)
                .setParameter("oid", organizerId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public long countPending() {
        Object result = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(ci.id) " +
                                "FROM CommissionInvoice ci " +
                                "WHERE ci.status = 'PENDING'")
                .uniqueResult();
        return result != null
                ? ((Number) result).longValue() : 0L;
    }
}