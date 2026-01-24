package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;


public interface StudentService {

    boolean validateAndSave(StudentDTO studentDTO);

    boolean validateLogin(String email, String password);

    void setCountToZero(String email);

    int getCount(String email);

    void updateCount(String email);

    boolean sendOtp(String email);

    boolean checkOptLogin(String email, String otp);

    boolean resetPassword(String email, String newPassword, String confirmPassword);
}
