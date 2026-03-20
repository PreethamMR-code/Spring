package com.nexmeet.platform.service.impl;

import com.nexmeet.platform.dao.AttendanceDao;
import com.nexmeet.platform.dao.RegistrationDao;
import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.Attendance;
import com.nexmeet.platform.entity.Registration;
import com.nexmeet.platform.entity.User;
import com.nexmeet.platform.enums.RegistrationStatus;
import com.nexmeet.platform.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Optional;


@Service
@Transactional
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceDao attendanceDao;

    @Autowired
    private RegistrationDao registrationDao;

    @Autowired
    private UserDao userDao;

    @Override
    public String markAttendance(String registrationNumber,
                                 Long conferenceId,
                                 String organizerEmail) {
        // Find registration by number
        Optional<Registration> regOpt =
                registrationDao.findByRegistrationNumber(registrationNumber);

        if (!regOpt.isPresent()) {
            return "NOT_FOUND";
        }

        Registration reg = regOpt.get();

        // Check it belongs to this conference
        if (!reg.getConference().getId().equals(conferenceId)) {
            return "WRONG_CONFERENCE";
        }

        // Check registration is CONFIRMED
        if (reg.getStatus() != RegistrationStatus.CONFIRMED) {
            return "NOT_CONFIRMED";
        }

        // Check not already checked in
        if (attendanceDao.existsByRegistrationId(reg.getId())) {
            return "ALREADY_CHECKED_IN";
        }

        // Get organizer user
        User organizer = userDao.findByEmail(organizerEmail)
                .orElseThrow(() -> new RuntimeException("Organizer not found"));


        // Create attendance record
        Attendance attendance = new Attendance();
        attendance.setRegistration(reg);
        attendance.setConference(reg.getConference());
        attendance.setUser(reg.getUser());
        attendance.setCheckedInBy(organizer);
        attendanceDao.save(attendance);

        return "SUCCESS";
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasAttended(Long registrationId) {
        return attendanceDao.existsByRegistrationId(registrationId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Attendance> getAttendanceByConference(Long conferenceId) {
        return attendanceDao.findByConferenceId(conferenceId);
    }
}
