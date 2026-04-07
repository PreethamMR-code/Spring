package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.NotificationDao;
import com.nexmeet.platform.entity.Notification;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


@Repository
@Transactional
public class NotificationDaoImpl implements NotificationDao {

    @Autowired
    private SessionFactory sessionFactory;


    @Override
    public void save(Notification notification) {
        sessionFactory.getCurrentSession().persist(notification);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Notification> findByUserEmail(String email) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Notification n " +
                                "WHERE n.user.email = :email " +
                                "ORDER BY n.sentAt DESC",
                        Notification.class)
                .setParameter("email", email)
                .setMaxResults(50) // cap at 50 most recent
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public long countUnreadByUserEmail(String email) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(n) FROM Notification n " +
                                "WHERE n.user.email = :email " +
                                "AND n.isRead = false",
                        Long.class)
                .setParameter("email", email)
                .getSingleResult();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Notification> findById(Long id) {
        Notification n = sessionFactory.getCurrentSession()
                .get(Notification.class, id);
        return Optional.ofNullable(n);
    }

    @Override
    public void markAllReadByUserEmail(String email) {
        sessionFactory.getCurrentSession()
                .createQuery(
                        "UPDATE Notification n SET n.isRead = true " +
                                "WHERE n.user.email = :email " +
                                "AND n.isRead = false")
                .setParameter("email", email)
                .executeUpdate();
    }
}
