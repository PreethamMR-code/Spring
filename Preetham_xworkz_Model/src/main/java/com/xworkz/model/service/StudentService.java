package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.entity.StudentEntity;

public interface StudentService {
    
    boolean saveStudent(StudentDTO dto);

    boolean validateLogin(String email, String password);

    StudentEntity findByEmail(String email);

    int updateCount(String email);

    void setCountToZero(String email);

    boolean generateAndSendOtp(String email);

    boolean verifyOtp(String email, String otp);


}
