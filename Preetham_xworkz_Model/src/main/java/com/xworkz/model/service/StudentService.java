package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.entity.StudentEntity;


public interface StudentService {

    boolean validateAndSave(StudentDTO studentDTO);

    boolean validateLogin(String email, String password);

    void setCountToZero(String email);

    int getCount(String email);

    void updateCount(String email);

    boolean sendOtp(String email);

    boolean checkOptLogin(String email, String otp);

    boolean resetPassword(String email, String newPassword, String confirmPassword);

    StudentEntity getUserByEmail(String email);

    boolean updateProfile(String email, String name, String phone, Integer age, String address);
}
