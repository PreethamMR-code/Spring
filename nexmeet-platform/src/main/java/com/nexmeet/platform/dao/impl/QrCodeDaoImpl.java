package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.QrCodeDao;
import com.nexmeet.platform.entity.QrCode;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.Optional;

@Repository
@Transactional
public class QrCodeDaoImpl implements QrCodeDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(QrCode qrCode) {
        sessionFactory.getCurrentSession().persist(qrCode);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<QrCode> findByRegistrationId(Long registrationId) {
        try {
            QrCode qr = (QrCode) sessionFactory.getCurrentSession()
                    .createQuery("FROM QrCode q WHERE q.registration.id = :regId")
                    .setParameter("regId", registrationId)
                    .getSingleResult();
            return Optional.of(qr);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }
}
