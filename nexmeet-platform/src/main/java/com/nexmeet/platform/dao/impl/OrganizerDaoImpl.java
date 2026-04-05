package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.OrganizerDao;
import com.nexmeet.platform.entity.Organizer;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.Optional;

@Repository
@Transactional
public class OrganizerDaoImpl implements OrganizerDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional(readOnly = true)
    public Optional<Organizer> findByUserEmail(String email) {
        try {
            Organizer o = (Organizer) sessionFactory.getCurrentSession()
                    .createQuery("FROM Organizer o WHERE o.user.email = :email")
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(o);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public void save(Organizer organizer) {
        sessionFactory.getCurrentSession().persist(organizer);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByUserEmail(String email) {
        Long count = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(o) FROM Organizer o WHERE o.user.email = :email",
                        Long.class)
                .setParameter("email", email)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public void update(Organizer organizer) {
        sessionFactory.getCurrentSession().update(organizer);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Organizer> findByOrganizerId(Long organizerId) {
        try {
            Organizer o = (Organizer) sessionFactory.getCurrentSession()
                    .createQuery(
                            "FROM Organizer o WHERE o.id = :id")
                    .setParameter("id", organizerId)
                    .getSingleResult();
            return Optional.of(o);
        } catch (javax.persistence.NoResultException e) {
            return Optional.empty();
        }
    }

}
