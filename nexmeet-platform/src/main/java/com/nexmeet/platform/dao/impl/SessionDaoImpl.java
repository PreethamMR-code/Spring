package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.SessionDao;
import com.nexmeet.platform.entity.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class SessionDaoImpl implements SessionDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Session session) {
        sessionFactory.getCurrentSession().persist(session);
    }

    @Override
    public void update(Session session) {
        sessionFactory.getCurrentSession().update(session);
    }

    @Override
    public void delete(Long id) {
        findById(id).ifPresent(s ->
                sessionFactory.getCurrentSession().delete(s));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Session> findById(Long id) {
        return Optional.ofNullable(
                sessionFactory.getCurrentSession()
                        .get(Session.class, id));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Session> findByConferenceId(
            Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Session s " +
                                "WHERE s.conference.id = :confId " +
                                "ORDER BY s.startTime ASC",
                        Session.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }
}
