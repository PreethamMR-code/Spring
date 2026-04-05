package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.FeedbackDao;
import com.nexmeet.platform.entity.Feedback;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class FeedbackDaoImpl implements FeedbackDao {

    @Autowired
    private SessionFactory sessionFactory;


    @Override
    public void save(Feedback feedback) {
        sessionFactory.getCurrentSession().persist(feedback);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByConferenceAndUser(Long conferenceId, Long userId) {
        Long count = sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(f) FROM Feedback f " +
                                "WHERE f.conference.id = :confId " +
                                "AND f.user.id = :userId",
                        Long.class)
                .setParameter("confId", conferenceId)
                .setParameter("userId", userId)
                .getSingleResult();
        return count > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Feedback> findPublicByConferenceId(Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Feedback f WHERE f.conference.id = :confId " +
                                "AND f.isPublic = true " +
                                "ORDER BY f.submittedAt DESC",
                        Feedback.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Feedback> findAllByConferenceId(Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Feedback f WHERE f.conference.id = :confId " +
                                "ORDER BY f.submittedAt DESC",
                        Feedback.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public Double getAverageRatingByConferenceId(Long conferenceId) {
        /*
         * AVG returns null if no feedback exists.
         * We return 0.0 in that case.
         */
        Double avg = (Double) sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT AVG(f.overallRating) FROM Feedback f " +
                                "WHERE f.conference.id = :confId")
                .setParameter("confId", conferenceId)
                .uniqueResult();
        return avg != null ? avg : 0.0;
    }

    @Override
    @Transactional(readOnly = true)
    public Double getAverageRatingByOrganizerId(Long organizerId) {
        Double avg = (Double) sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT AVG(f.overallRating) FROM Feedback f " +
                                "WHERE f.conference.organizer.id = :orgId")
                .setParameter("orgId", organizerId)
                .uniqueResult();
        return avg != null ? avg : 0.0;
    }

    @Override
    @Transactional(readOnly = true)
    public long countByConferenceId(Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "SELECT COUNT(f) FROM Feedback f " +
                                "WHERE f.conference.id = :confId",
                        Long.class)
                .setParameter("confId", conferenceId)
                .getSingleResult();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Feedback> findByConferenceAndUser(Long conferenceId, Long userId) {

            try {
                Feedback f = (Feedback) sessionFactory.getCurrentSession()
                        .createQuery(
                                "FROM Feedback f " +
                                        "WHERE f.conference.id = :confId " +
                                        "AND f.user.id = :userId")
                        .setParameter("confId", conferenceId)
                        .setParameter("userId", userId)
                        .getSingleResult();
                return Optional.of(f);
            } catch (NoResultException e) {
                return Optional.empty();
            }
        }
}
