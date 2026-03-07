package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.entity.Registration;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Repository
public class RegistrationDaoImpl implements RegistrationDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession(){
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Registration registration) {
        getCurrentSession().save(registration);
    }

    @Override
    public void update(Registration registration) {
        getCurrentSession().update(registration);
    }

    @Override
    public Optional<Registration> findById(Long id) {
        return Optional.ofNullable(getCurrentSession().get(Registration.class, id));
    }

    @Override
    public Optional<Registration> findByRegistrationNumber(String registrationNumber) {
        Registration r = (Registration) getCurrentSession()
                .createQuery("FROM Registration WHERE registrationNumber = :num")
                .setParameter("num", registrationNumber)
                .uniqueResult();
        return Optional.ofNullable(r);
    }

    @Override
    public boolean existsByConferenceAndUser(Long conferenceId, Long userId) {
        Long count = (Long) getCurrentSession()
                .createQuery(
                        "SELECT COUNT(r) FROM Registration r " +
                                "WHERE r.conference.id = :confId AND r.user.id = :userId")
                .setParameter("confId", conferenceId)
                .setParameter("userId", userId)
                .uniqueResult();
        return count > 0;
    }

    @Override
    public List<Registration> findByConferenceId(Long conferenceId) {
        return getCurrentSession()
                .createQuery(
                        "FROM Registration r WHERE r.conference.id = :confId " +
                                "ORDER BY r.registeredAt DESC", Registration.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }

    @Override
    public List<Registration> findByUserId(Long userId) {
        return getCurrentSession()
                .createQuery(
                        "FROM Registration r WHERE r.user.id = :userId " +
                                "ORDER BY r.registeredAt DESC", Registration.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public long countByUserEmail(String email) {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(r) FROM Registration r WHERE r.user.email = :email")
                .setParameter("email", email)
                .getSingleResult();
    }

    @Override
    public List<Registration> findByUserEmail(String email) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Registration r WHERE r.user.email = :email ORDER BY r.registeredAt DESC")
                .setParameter("email", email)
                .getResultList();
    }


}
