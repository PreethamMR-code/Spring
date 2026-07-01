package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.AuditLogDao;
import com.nexmeet.platform.entity.AuditLog;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AuditLogDaoImpl
        implements AuditLogDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(AuditLog log) {
        sessionFactory.getCurrentSession()
                .persist(log);
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> findRecent(int page, int size) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM AuditLog a " +
                                "ORDER BY a.performedAt DESC",
                        AuditLog.class)
                .setFirstResult((page - 1) * size)
                .setMaxResults(size)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> findByAction(
            String action, int page, int size) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM AuditLog a " +
                                "WHERE a.action = :action " +
                                "ORDER BY a.performedAt DESC",
                        AuditLog.class)
                .setParameter("action", action)
                .setFirstResult((page - 1) * size)
                .setMaxResults(size)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public long countByAction(String action) {
        Long count = (Long) sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(a.id) FROM AuditLog a " +
                                "WHERE a.action = :action")
                .setParameter("action", action)
                .uniqueResult();
        return count != null ? count : 0L;
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> findByUserId(
            Long userId, int limit) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM AuditLog a " +
                                "WHERE a.user.id = :uid " +
                                "ORDER BY a.performedAt DESC",
                        AuditLog.class)
                .setParameter("uid", userId)
                .setMaxResults(limit)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<AuditLog> findByEntity(
            String entityType,
            Long entityId,
            int limit) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM AuditLog a " +
                                "WHERE a.entityType " +
                                "= :etype " +
                                "AND a.entityId = :eid " +
                                "ORDER BY a.performedAt DESC",
                        AuditLog.class)
                .setParameter("etype", entityType)
                .setParameter("eid", entityId)
                .setMaxResults(limit)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public long countAll() {
        Long count = (Long) sessionFactory
                .getCurrentSession()
                .createQuery(
                        "SELECT COUNT(a.id) " +
                                "FROM AuditLog a")
                .uniqueResult();
        return count != null ? count : 0L;
    }
}