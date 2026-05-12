package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.InstitutionDao;
import com.nexmeet.platform.entity.Institution;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class InstitutionDaoImpl implements InstitutionDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Institution institution) {
        sessionFactory.getCurrentSession()
                .persist(institution);
    }

    @Override
    public void update(Institution institution) {
        sessionFactory.getCurrentSession()
                .update(institution);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Institution> findById(Long id) {
        Institution i = sessionFactory
                .getCurrentSession()
                .get(Institution.class, id);
        return Optional.ofNullable(i);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Institution> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Institution i " +
                                "ORDER BY i.name ASC",
                        Institution.class)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Institution> findByActive(boolean active) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Institution i " +
                                "WHERE i.isActive = :active " +
                                "ORDER BY i.name ASC",
                        Institution.class)
                .setParameter("active", active)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public long countAll() {
        Object r = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(i.id) " +
                                "FROM Institution i")
                .uniqueResult();
        return r != null ? ((Number) r).longValue() : 0L;
    }
}