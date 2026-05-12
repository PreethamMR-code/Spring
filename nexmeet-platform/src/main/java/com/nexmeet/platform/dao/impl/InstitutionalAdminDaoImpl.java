package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.InstitutionalAdminDao;
import com.nexmeet.platform.entity.InstitutionalAdmin;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class InstitutionalAdminDaoImpl
        implements InstitutionalAdminDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(InstitutionalAdmin admin) {
        sessionFactory.getCurrentSession()
                .persist(admin);
    }

    @Override
    public void update(InstitutionalAdmin admin) {
        sessionFactory.getCurrentSession()
                .update(admin);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<InstitutionalAdmin> findByUserId(
            Long userId) {
        InstitutionalAdmin a = (InstitutionalAdmin)
                sessionFactory.getCurrentSession()
                        .createQuery(
                                "FROM InstitutionalAdmin ia " +
                                        "WHERE ia.user.id = :uid")
                        .setParameter("uid", userId)
                        .uniqueResult();
        return Optional.ofNullable(a);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<InstitutionalAdmin> findByUserEmail(
            String email) {
        InstitutionalAdmin a = (InstitutionalAdmin)
                sessionFactory.getCurrentSession()
                        .createQuery(
                                "FROM InstitutionalAdmin ia " +
                                        "WHERE ia.user.email = :email")
                        .setParameter("email", email)
                        .uniqueResult();
        return Optional.ofNullable(a);
    }

    @Override
    @Transactional(readOnly = true)
    public List<InstitutionalAdmin> findByInstitutionId(
            Long institutionId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM InstitutionalAdmin ia " +
                                "WHERE ia.institution.id = :iid " +
                                "ORDER BY ia.createdAt DESC",
                        InstitutionalAdmin.class)
                .setParameter("iid", institutionId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<InstitutionalAdmin> findPending() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM InstitutionalAdmin ia " +
                                "WHERE ia.isVerified = false " +
                                "ORDER BY ia.createdAt DESC",
                        InstitutionalAdmin.class)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByUserEmail(String email) {
        Long count = (Long) sessionFactory
                .getCurrentSession()
                .createQuery(
                        "SELECT COUNT(ia.id) " +
                                "FROM InstitutionalAdmin ia " +
                                "WHERE ia.user.email = :email")
                .setParameter("email", email)
                .uniqueResult();
        return count != null && count > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<InstitutionalAdmin> findById(Long id) {
        InstitutionalAdmin ia = sessionFactory
                .getCurrentSession()
                .get(InstitutionalAdmin.class, id);
        return Optional.ofNullable(ia);
    }
}