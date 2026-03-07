package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.UUID;

@Service
public class RegistrationServiceImpl implements RegistrationService {

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public String registerForConference(Long conferenceId, String userEmail) {

        // 1. Load user and conference
        User user = userDao.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Conference conference = conferenceDao.findById(conferenceId)
                .orElseThrow(() -> new RuntimeException("Conference not found"));

        // 2. Prevent duplicate registration
        if (registrationDao.existsByConferenceAndUser(conferenceId, user.getId())) {
            return "ALREADY_REGISTERED";
        }

        // 3. Check if registration is open
        if (!conferenceDao.isRegistrationOpen(conferenceId)) {
            return "REGISTRATION_CLOSED";
        }

        // 4. Create registration
        Registration reg = new Registration();
        reg.setConference(conference);
        reg.setUser(user);
        reg.setRegistrationNumber("NM-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        reg.setStatus(RegistrationStatus.CONFIRMED);
        reg.setRegistrationType(RegistrationStatus.CONFIRMED);


        registrationDao.save(reg);

        // 5. Increment registered count
        conference.setRegisteredCount(conference.getRegisteredCount() + 1);
        conferenceDao.update(conference);

        return "SUCCESS";
    }
}
