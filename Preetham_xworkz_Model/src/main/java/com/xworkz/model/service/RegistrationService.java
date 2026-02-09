package com.xworkz.model.service;

import com.xworkz.model.DTO.RegistrationDTO;
import com.xworkz.model.entity.FileEntity;
import com.xworkz.model.entity.RegistrationEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


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

    boolean isEmailExists(String email);

    boolean uploadProfilePhoto(String email, MultipartFile image) throws IOException;

    FileEntity getFileById(int id);
}
