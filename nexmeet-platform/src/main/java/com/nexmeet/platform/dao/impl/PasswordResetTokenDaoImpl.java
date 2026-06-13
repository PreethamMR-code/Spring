package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.PasswordResetTokenDao;
import com.nexmeet.platform.entity.PasswordResetToken;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class PasswordResetTokenDaoImpl
        implements PasswordResetTokenDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(PasswordResetToken token) {
        getCurrentSession().persist(token);
    }

    @Override
    public Optional<PasswordResetToken> findByToken(
            String token) {
        PasswordResetToken result = getCurrentSession()
                .createQuery(
                        "FROM PasswordResetToken t " +
                                "WHERE t.token = :token",
                        PasswordResetToken.class)
                .setParameter("token", token)
                .uniqueResult();
        return Optional.ofNullable(result);
    }

    @Override
    public void deleteByUserId(Long userId) {
        /*
         * HQL bulk DELETE — no object loading, very fast.
         * Removes ALL existing tokens for this user so
         * only the newest token is ever valid.
         */
        getCurrentSession()
                .createQuery(
                        "DELETE FROM PasswordResetToken t " +
                                "WHERE t.user.id = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
    }
}