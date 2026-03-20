package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Attendance;

import java.util.List;

public interface AttendanceService {

    String markAttendance(String registrationNumber, Long conferenceId, String organizerEmail);

    boolean hasAttended(Long registrationId);

    List<Attendance> getAttendanceByConference(Long conferenceId);
}
