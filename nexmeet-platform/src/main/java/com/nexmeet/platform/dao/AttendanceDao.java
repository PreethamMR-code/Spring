package com.nexmeet.platform.dao;

import com.nexmeet.platform.entity.Attendance;

import java.util.List;
import java.util.Optional;

public interface AttendanceDao {

    void save(Attendance attendance);

    boolean existsByRegistrationId(Long registrationId);

    Optional<Attendance> findByRegistrationId(Long registrationId);

    List<Attendance> findByConferenceId(Long conferenceId);
}
