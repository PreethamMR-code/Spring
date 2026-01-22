package com.xworkz.model.repository;

import com.xworkz.model.entity.StudentEntity;

public interface StudentDAO {

    boolean save(StudentEntity studentEntity);

    StudentEntity findByEmail(String email);

    void update(StudentEntity studentEntity);

    void updateLoginCount(String email, int count);

    void resetLoginCount(String email);

    boolean saveOtp(String email, String otp);


    boolean checkOtpMatch(String email, String otp);
}
