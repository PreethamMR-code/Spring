package com.nexmeet.platform.service;

import com.nexmeet.platform.entity.Registration;

import java.util.List;

public interface RegistrationService {


    String registerForConference(Long conferenceId, String userEmail);

    long countByUserEmail(String email);

    List<Registration> findByUserEmail(String email);

    String cancelRegistration(Long registrationId, String userEmail);
}
