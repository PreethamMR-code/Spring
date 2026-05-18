package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.CertificateDao;
import com.nexmeet.platform.entity.Certificate;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class CertificateDaoImpl
        implements CertificateDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Certificate certificate) {
        sessionFactory.getCurrentSession()
                .persist(certificate);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Certificate> findByRegistrationId(
            Long registrationId) {
        try {
            Certificate c = (Certificate)
                    sessionFactory.getCurrentSession()
                            .createQuery(
                                    "FROM Certificate c " +
                                            "WHERE c.registration.id " +
                                            "= :rid")
                            .setParameter("rid", registrationId)
                            .getSingleResult();
            return Optional.of(c);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Certificate> findByConferenceId(
            Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Certificate c " +
                                "WHERE c.conference.id = :cid " +
                                "ORDER BY c.issuedAt DESC",
                        Certificate.class)
                .setParameter("cid", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByRegistrationId(
            Long registrationId) {
        Long count = (Long) sessionFactory
                .getCurrentSession()
                .createQuery(
                        "SELECT COUNT(c.id) " +
                                "FROM Certificate c " +
                                "WHERE c.registration.id = :rid")
                .setParameter("rid", registrationId)
                .uniqueResult();
        return count != null && count > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Certificate> findByCertificateNumber(
            String certificateNumber) {
        try {
            Certificate c = (Certificate)
                    sessionFactory.getCurrentSession()
                            .createQuery(
                                    "FROM Certificate c " +
                                            "WHERE c.certificateNumber" +
                                            " = :num")
                            .setParameter("num",
                                    certificateNumber)
                            .getSingleResult();
            return Optional.of(c);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }
}