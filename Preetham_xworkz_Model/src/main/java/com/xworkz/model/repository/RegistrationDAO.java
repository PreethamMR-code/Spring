package com.xworkz.model.repository;

import com.xworkz.model.entity.FileEntity;
import com.xworkz.model.entity.RegistrationEntity;

public interface RegistrationDAO {

    boolean save(RegistrationEntity studentEntity);

    RegistrationEntity loginByEmail(String email);

    void setCountToZero(String email);

    int getCount(String email);

    void updateCount(String email);

    boolean checkEmail(String email);

    boolean saveOtp(String email, String otp);

    RegistrationEntity checkOtpMatch(String email, String otp);

    boolean updatePassword(String email, String newPassword);

    boolean updateProfile(String email, String name, String phone, Integer age, String address);

    RegistrationEntity findByEmail(String email);

    int saveFile(FileEntity fileEntity);

    FileEntity getFileById(int id);
}
