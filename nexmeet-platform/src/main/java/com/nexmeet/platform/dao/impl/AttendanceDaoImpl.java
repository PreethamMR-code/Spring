package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.AttendanceDao;
import com.nexmeet.platform.entity.Attendance;
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
public class AttendanceDaoImpl implements AttendanceDao {

    @Autowired
    private SessionFactory sessionFactory;


    @Override
    public void save(Attendance attendance) {
        sessionFactory.getCurrentSession().persist(attendance);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByRegistrationId(Long registrationId) {
        Long count = sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(a) FROM Attendance a WHERE a.registration.id = :regId",
                        Long.class)
                .setParameter("regId", registrationId)
                .getSingleResult();
        return count > 0;

    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Attendance> findByRegistrationId(Long registrationId) {
        try {
            Attendance a = (Attendance) sessionFactory.getCurrentSession()
                    .createQuery(
                            "FROM Attendance a WHERE a.registration.id = :regId")
                    .setParameter("regId", registrationId)
                    .getSingleResult();
            return Optional.of(a);
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Attendance> findByConferenceId(Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM Attendance a WHERE a.conference.id = :confId " +
                                "ORDER BY a.checkedInAt DESC",
                        Attendance.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }
}
