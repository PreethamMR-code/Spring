package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.DelegateDao;
import com.nexmeet.platform.entity.Delegate;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;


@Repository
@Transactional
public class DelegateDaoImpl implements DelegateDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public boolean existsByUserEmail(String email) {
        Long count = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(d) FROM Delegate d " +
                                "WHERE d.user.email = :email", Long.class)
                .setParameter("email", email)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public Optional<Delegate> findByUserEmail(String email) {
        try {
            Delegate d = (Delegate) sessionFactory
                    .getCurrentSession()
                    .createQuery(
                            "FROM Delegate d " +
                                    "WHERE d.user.email = :email")
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(d);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public void save(Delegate delegate) {
        sessionFactory.getCurrentSession().persist(delegate);
    }

    @Override
    public void update(Delegate delegate) {
        sessionFactory.getCurrentSession().update(delegate);
    }
}
