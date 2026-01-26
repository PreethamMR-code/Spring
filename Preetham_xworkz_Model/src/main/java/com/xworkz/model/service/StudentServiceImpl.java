package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.entity.StudentEntity;
import com.xworkz.model.repository.StudentDAO;

import com.xworkz.model.utils.OTPUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Random;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    StudentDAO studentDAO;

    @Autowired
    OTPUtil otpUtil;

    private static final String SECRET = "xworkzSecretKey1";

    private SecretKey getKey() {
        byte[] keyBytes = SECRET.getBytes();
        return new SecretKeySpec(keyBytes, "AES");
    }

    private String encrypt(String plainText) {

        try {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, getKey());
            byte[] encrypted = cipher.doFinal(plainText.getBytes());
            return Base64.getEncoder().encodeToString(encrypted);
        } catch (Exception e) {
            throw new RuntimeException("Error encrypting password", e);
        }
    }

    private String decrypt(String cipherText) {
        try {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, getKey());
            byte[] decoded = Base64.getDecoder().decode(cipherText);
            byte[] original = cipher.doFinal(decoded);
            return new String(original);
        } catch (Exception e) {
            throw new RuntimeException("Error decrypting password", e);
        }
    }

//    ------------------------------------------------------------------------

    @Override
    public boolean validateAndSave(StudentDTO studentDTO) {
        if (studentDTO == null) return false;

        // Check if email already exists
        if (studentDAO.checkEmail(studentDTO.getEmail())) {
            return false;
        }

        // Encrypt password
        String encryptedPwd = encrypt(studentDTO.getPassword());

        // Create entity
        StudentEntity studentEntity = new StudentEntity();
        studentEntity.setName(studentDTO.getName());
        studentEntity.setEmail(studentDTO.getEmail());
        studentEntity.setPhone(studentDTO.getPhone());
        studentEntity.setAge(studentDTO.getAge());
        studentEntity.setGender(studentDTO.getGender());
        studentEntity.setAddress(studentDTO.getAddress());
        studentEntity.setPassword(encryptedPwd);
        studentEntity.setCount(0);

        return studentDAO.save(studentEntity);
    }

    @Override
    public boolean validateLogin(String email, String password) {
        if (email == null || password == null) return false;

        StudentEntity signupEntity = studentDAO.loginByEmail(email);
        if (signupEntity == null) return false;

        try {
            String decryptedPassword = decrypt(signupEntity.getPassword());
            return decryptedPassword.equals(password);
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public void setCountToZero(String email) {
        studentDAO.setCountToZero(email);
    }

    @Override
    public int getCount(String email) {
        return studentDAO.getCount(email);
    }

    @Override
    public void updateCount(String email) {
        studentDAO.updateCount(email);
    }

    @Override
    public boolean sendOtp(String email) {

        // Check if user exists
        if (!studentDAO.checkEmail(email)) {
            return false;
        }

        // Generate random 6-digit OTP
        String generatedOtp = String.valueOf(100000 + new Random().nextInt(900000));

        // Save OTP to database
        boolean isSaved = studentDAO.saveOtp(email, generatedOtp);

        if (isSaved) {
            // Send OTP via email
            otpUtil.sendSimpleMessage(email, "Password Reset OTP",
                    "Your OTP for password reset is: " + generatedOtp + "\n\nThis OTP is valid for 10 minutes."
            );
            return true;
        }
        return false;
    }

    //sending otp to email and verifying
    @Override
    public boolean checkOptLogin(String email, String otp) {

       // getting STUDENT ENTITY ( which contains otpGeneratedTime)
        StudentEntity student= studentDAO.checkOtpMatch(email, otp);

        if(student == null){
            System.out.println("Invalid OTP or email");
            return false;
        }

        //getting stored time
        LocalDateTime otpTime = student.getOtpGeneratedTime();

        if(otpTime == null){
            System.out.println("Otp generaation time not found");
            return false;
        }

        // getting current time
        LocalDateTime currentTime = LocalDateTime.now();

        //calculating difference
        long secondsDifference  = Duration.between(otpTime, currentTime).getSeconds();

        System.out.println("OTP was generated at:"+otpTime);
        System.out.println("Current Time is:"+currentTime);
        System.out.println("time Difference is " + secondsDifference + "seconds");


        //checking if its under 60 seconds
        if(secondsDifference > 60){
            System.out.println("OTP is timed out ( expired after 60 seconds)");
            return false;
        }

        System.out.println("OTP is valid and within time limit");
        return true;

    }

    //resetting password through otp and email
    @Override
    public boolean resetPassword(String email, String newPassword, String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {
            return false;
        }

        // Encrypt new password
        String encryptedPassword = encrypt(newPassword);

        // Update password and clear OTP
        return studentDAO.updatePassword(email, encryptedPassword);
    }
}