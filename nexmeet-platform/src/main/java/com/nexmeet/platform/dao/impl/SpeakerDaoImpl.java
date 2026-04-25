package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.SpeakerDao;
import com.nexmeet.platform.entity.Speaker;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class SpeakerDaoImpl implements SpeakerDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Speaker speaker) {
        sessionFactory.getCurrentSession().persist(speaker);
    }

    @Override
    public void update(Speaker speaker) {
        sessionFactory.getCurrentSession().update(speaker);
    }

    @Override
    public void delete(Long id) {
        findById(id).ifPresent(s ->
                sessionFactory.getCurrentSession().delete(s));
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Speaker> findById(Long id) {
        return Optional.ofNullable(
                sessionFactory.getCurrentSession()
                        .get(Speaker.class, id));
    }

    @Override
    @Transactional(readOnly = true)
    public List<Speaker> findByConferenceId(Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Speaker s " +
                                "WHERE s.conference.id = :confId " +
                                "ORDER BY s.createdAt ASC",
                        Speaker.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Speaker> findBySessionId(Long sessionId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Speaker s " +
                                "WHERE s.session.id = :sessionId " +
                                "ORDER BY s.createdAt ASC",
                        Speaker.class)
                .setParameter("sessionId", sessionId)
                .getResultList();
    }
}
