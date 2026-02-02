package com.xworkz.model.service;

import com.xworkz.model.DTO.RegistrationDTO;
import com.xworkz.model.entity.RegistrationEntity;


public interface RegistrationService {

    boolean validateAndSave(RegistrationDTO studentDTO);

    boolean validateLogin(String email, String password);

    void setCountToZero(String email);

    int getCount(String email);

    void updateCount(String email);

    boolean sendOtp(String email);

    boolean checkOptLogin(String email, String otp);

    boolean resetPassword(String email, String newPassword, String confirmPassword);

    RegistrationEntity getUserByEmail(String email);

    boolean updateProfile(String email, String name, String phone, Integer age, String address);
}
