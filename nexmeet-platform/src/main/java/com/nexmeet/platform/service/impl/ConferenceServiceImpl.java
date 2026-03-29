package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.ConferenceStatus;
import com.nexmeet.platform.service.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@org.springframework.transaction.annotation.Transactional
public class ConferenceServiceImpl implements ConferenceService {

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private UserDao userDao;

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public Optional<Conference> findById(Long id) {
        return conferenceDao.findById(id);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getApprovedConferences() {
        return conferenceDao.findAllApproved();
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getPendingConferences() {
        return conferenceDao.findByStatus(ConferenceStatus.SUBMITTED);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(readOnly = true)
    public List<Conference> getConferencesByOrganizer(Long organizerId) {
        return conferenceDao.findByOrganizerId(organizerId);
    }

    @Override
    public void approveConference(Long conferenceId, String adminEmail) {
        Conference conference = conferenceDao.findById(conferenceId)
                .orElseThrow(() -> new IllegalArgumentException("Conference not found"));

        User admin = userDao.findByEmail(adminEmail)
                .orElseThrow(() -> new IllegalArgumentException("Admin not found"));

        conference.setStatus(ConferenceStatus.APPROVED);
        conference.setApprovedBy(admin);
        conference.setApprovedAt(LocalDateTime.now());
        conference.setRejectionReason(null);
        conferenceDao.update(conference);
    }

    @Override
    public void rejectConference(Long conferenceId, Long adminUserId, String reason) {
        Conference conference = conferenceDao.findById(conferenceId)
                .orElseThrow(() -> new IllegalArgumentException("Conference not found: " + conferenceId));

        conference.setStatus(ConferenceStatus.REJECTED);
        conference.setRejectionReason(reason);

        conferenceDao.update(conference);
    }

    @Override
    @Transactional
    public void save(Conference conference) {
        conferenceDao.save(conference);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByOrganizer(Long organizerId) {
        return conferenceDao.countByOrganizer(organizerId);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByOrganizerAndStatus(Long organizerId, ConferenceStatus status) {
        return conferenceDao.countByOrganizerAndStatus(organizerId, status);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Conference> getAllConferences() {
        return conferenceDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countByStatus(ConferenceStatus status) {
        return conferenceDao.countByStatus(status);
    }

    @Override
    public List<Conference> findByStatus(ConferenceStatus conferenceStatus) {
        return conferenceDao.findByStatus(conferenceStatus);
    }

    @Override
    public void update(Conference conf) {
        conferenceDao.update(conf);
    }
}
