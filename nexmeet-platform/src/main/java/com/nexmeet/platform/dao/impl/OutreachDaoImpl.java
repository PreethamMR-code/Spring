package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.OutreachDao;
import com.nexmeet.platform.entity.OutreachContact;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public class OutreachDaoImpl implements OutreachDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(OutreachContact contact) {
        sessionFactory.getCurrentSession()
                .persist(contact);
    }

    @Override
    public void update(OutreachContact contact) {
        sessionFactory.getCurrentSession()
                .update(contact);
    }

    @Override
    @Transactional(readOnly = true)
    public List<OutreachContact> findByConferenceId(
            Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM OutreachContact oc " +
                                "WHERE oc.conference.id = :cid " +
                                // contactedAt is the field name
                                // from your existing entity
                                "ORDER BY oc.contactedAt DESC",
                        OutreachContact.class)
                .setParameter("cid", conferenceId)
                .getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public boolean alreadyContacted(Long conferenceId,
                                    Long institutionId) {
        Long count = (Long) sessionFactory
                .getCurrentSession()
                .createQuery(
                        "SELECT COUNT(oc.id) " +
                                "FROM OutreachContact oc " +
                                "WHERE oc.conference.id = :cid " +
                                "AND oc.institution.id = :iid")
                .setParameter("cid", conferenceId)
                .setParameter("iid", institutionId)
                .uniqueResult();
        return count != null && count > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<OutreachContact> findById(Long id) {
        OutreachContact oc = sessionFactory
                .getCurrentSession()
                .get(OutreachContact.class, id);
        return Optional.ofNullable(oc);
    }
}