package com.xworkz.model.repository;

import com.xworkz.model.entity.StudentEntity;

public interface StudentDAO {

    boolean save(StudentEntity studentEntity);

    StudentEntity loginByEmail(String email);

    void setCountToZero(String email);

    int getCount(String email);

    void updateCount(String email);

    boolean checkEmail(String email);

    boolean saveOtp(String email, String otp);

    StudentEntity checkOtpMatch(String email, String otp);

    boolean updatePassword(String email, String newPassword);

    boolean updateProfile(String email, String name, String phone, Integer age, String address);
}
