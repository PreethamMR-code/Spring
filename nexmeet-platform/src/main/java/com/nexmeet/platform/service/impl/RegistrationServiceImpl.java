package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.ConferenceDao;
import com.nexmeet.platform.dao.QrCodeDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Conference;
import com.nexmeet.platform.entity.QrCode;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.QrCodeService;
import com.nexmeet.platform.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class RegistrationServiceImpl implements RegistrationService {

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private ConferenceDao conferenceDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private QrCodeDao qrCodeDao;

    @Autowired
    private QrCodeService qrCodeService;

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

        // Generate QR Code
        QrCode qr = new QrCode();
        qr.setRegistration(reg);
        qr.setQrToken(reg.getRegistrationNumber());   // <- was setQrData
        qr.setQrImageBase64(qrCodeService.generateQrCodeBase64(reg.getRegistrationNumber()));
        qrCodeDao.save(qr);

        return "SUCCESS";
    }

    @Override
    @Transactional(readOnly = true)
    public long countByUserEmail(String email) {
        return registrationDao.countByUserEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Registration> findByUserEmail(String email) {
        return registrationDao.findByUserEmail(email);
    }

    @Override
    @Transactional
    public String cancelRegistration(Long registrationId, String userEmail) {
        Optional<Registration> regOpt = registrationDao.findById(registrationId);

        if (!regOpt.isPresent()) {
            return "NOT_FOUND";
        }

        Registration reg = regOpt.get();

        // Security check — delegate can only cancel their own
        if (!reg.getUser().getEmail().equals(userEmail)) {
            return "UNAUTHORIZED";
        }

        if (reg.getStatus() == RegistrationStatus.CANCELLED) {
            return "ALREADY_CANCELLED";
        }

        // Check if registration deadline has passed
        boolean afterDeadline = LocalDateTime.now()
                .isAfter(reg.getConference().getRegistrationDeadline());

        reg.setStatus(RegistrationStatus.CANCELLED);
        reg.setCancelledAt(LocalDateTime.now());
        registrationDao.cancel(reg);

        // Free the seat
        Conference conf = reg.getConference();
        if (conf.getRegisteredCount() > 0) {
            conf.setRegisteredCount(conf.getRegisteredCount() - 1);
            conferenceDao.update(conf);
        }

        return afterDeadline ? "CANCELLED_LATE" : "CANCELLED";
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Registration> findById(Long id) {
        return registrationDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Registration> findByConferenceId(Long conferenceId) {
        return registrationDao.findByConferenceId(conferenceId);
    }
}
