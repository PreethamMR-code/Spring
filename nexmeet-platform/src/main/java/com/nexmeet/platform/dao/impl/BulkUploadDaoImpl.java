package com.nexmeet.platform.dao.impl;

import com.nexmeet.platform.dao.BulkUploadDao;
import com.nexmeet.platform.entity.BulkUpload;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class BulkUploadDaoImpl implements BulkUploadDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(BulkUpload upload) {
        sessionFactory.getCurrentSession().persist(upload);
    }

    @Override
    public void update(BulkUpload upload) {
        sessionFactory.getCurrentSession().update(upload);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BulkUpload> findByConferenceId(
            Long conferenceId) {
        return sessionFactory.getCurrentSession()
                .createQuery(
                        "FROM BulkUpload b " +
                                "WHERE b.conference.id = :confId " +
                                "ORDER BY b.uploadedAt DESC",
                        BulkUpload.class)
                .setParameter("confId", conferenceId)
                .getResultList();
    }
}