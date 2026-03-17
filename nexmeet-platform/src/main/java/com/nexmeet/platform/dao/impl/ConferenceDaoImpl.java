package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.enums.ConferenceStatus;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public class ConferenceDaoImpl implements ConferenceDao {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession(){
        return sessionFactory.getCurrentSession();
    }


    @Override
    public void save(Conference conference) {
        getCurrentSession().persist(conference);
    }

    @Override
    public void update(Conference conference) {
        getCurrentSession().update(conference);
    }

    @Override
    public Optional<Conference> findById(Long id) {
        Conference conference = getCurrentSession().get(Conference.class, id);
        return Optional.ofNullable(conference);
    }

    @Override
    public List<Conference> findAllApproved() {
        /*
         * We only show APPROVED conferences on the public page.
         * ORDER BY startDate so upcoming conferences appear first.
         *
         * Notice: we use c.conferenceType not conference_type —
         * HQL uses Java field names from the entity class.
         */
        return getCurrentSession()
                .createQuery(
                        "FROM Conference c WHERE c.status = :status " +
                                "ORDER BY c.startDate ASC", Conference.class)
                .setParameter("status", ConferenceStatus.APPROVED)
                .getResultList();
    }

    @Override
    public List<Conference> findByStatus(ConferenceStatus status) {
        return getCurrentSession()
                .createQuery(
                        "FROM Conference c WHERE c.status = :status " +
                                "ORDER BY c.createdAt DESC", Conference.class)
                .setParameter("status", status)
                .getResultList();
    }

    @Override
    public List<Conference> findByOrganizerId(Long organizerId) {
        /*
         * Traversing a relationship in HQL:
         * c.organizer.id means: go to the organizer field of Conference,
         * then get its id field.
         * Hibernate generates the JOIN automatically.
         */
        return getCurrentSession()
                .createQuery(
                        "FROM Conference c WHERE c.organizer.id = :organizerId " +
                                "ORDER BY c.createdAt DESC", Conference.class)
                .setParameter("organizerId", organizerId)
                .getResultList();
    }

    @Override
    public boolean isRegistrationOpen(Long conferenceId) {
        return (Long) getCurrentSession()
                .createQuery(
                        "SELECT COUNT(c) FROM Conference c " +
                                "WHERE c.id = :id " +
                                "AND c.status = :status " +
                                "AND c.registrationDeadline >= :now " +
                                "AND c.registeredCount < c.maxDelegates",
                        Long.class)
                .setParameter("id", conferenceId)
                .setParameter("status", ConferenceStatus.APPROVED)
                .setParameter("now", LocalDateTime.now())
                .getSingleResult() > 0;
    }

    @Override
    public long countByOrganizer(Long organizerId) {
        return (long) getCurrentSession()
                .createQuery("SELECT COUNT(c) FROM Conference c WHERE c.organizer.id = :id")
                .setParameter("id", organizerId)
                .getSingleResult();

    }

    @Override
    public long countByOrganizerAndStatus(Long organizerId, ConferenceStatus status) {
        return (long) getCurrentSession()
                .createQuery("SELECT COUNT(c) FROM Conference c WHERE c.organizer.id = :id AND c.status = :status")
                .setParameter("id", organizerId)
                .setParameter("status", status)
                .getSingleResult();
    }
}
