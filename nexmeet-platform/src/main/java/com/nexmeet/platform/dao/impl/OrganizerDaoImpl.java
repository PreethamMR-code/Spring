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

}
