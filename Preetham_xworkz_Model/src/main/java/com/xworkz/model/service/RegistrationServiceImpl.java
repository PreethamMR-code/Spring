package com.xworkz.model.service;

import com.xworkz.model.DTO.RegistrationDTO;
import com.xworkz.model.config.FileUploadConfig;
import com.xworkz.model.entity.RegistrationEntity;
import com.xworkz.model.repository.RegistrationDAO;

import com.xworkz.model.utils.OTPUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Random;

@Service
public class RegistrationServiceImpl implements RegistrationService {

    @Autowired
    RegistrationDAO registrationDAO;

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
    public boolean validateAndSave(RegistrationDTO studentDTO) {
        if (studentDTO == null) return false;

        // Check if email already exists
        if (registrationDAO.checkEmail(studentDTO.getEmail())) {
            return false;
        }

        // Encrypt password
        String encryptedPwd = encrypt(studentDTO.getPassword());

        // Create entity
        RegistrationEntity studentEntity = new RegistrationEntity();
        studentEntity.setName(studentDTO.getName());
        studentEntity.setEmail(studentDTO.getEmail());
        studentEntity.setPhone(studentDTO.getPhone());
        studentEntity.setAge(studentDTO.getAge());
        studentEntity.setGender(studentDTO.getGender());
        studentEntity.setAddress(studentDTO.getAddress());
        studentEntity.setPassword(encryptedPwd);
        studentEntity.setCount(0);

        return registrationDAO.save(studentEntity);
    }

    //checking email exists through ajax

    @Override
    public boolean isEmailExists(String email) {
        return registrationDAO.findByEmail(email)!= null;
    }

    @Override
    public boolean validateLogin(String email, String password) {

        if (email == null || password == null) return false;

        RegistrationEntity signupEntity = registrationDAO.loginByEmail(email);

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
        registrationDAO.setCountToZero(email);
    }

    @Override
    public int getCount(String email) {
        return registrationDAO.getCount(email);
    }

    @Override
    public void updateCount(String email) {
        registrationDAO.updateCount(email);
    }

    @Override
    public boolean sendOtp(String email) {

        // Check if user exists
        if (!registrationDAO.checkEmail(email)) {
            return false;
        }

        // Generate random 6-digit OTP
        String generatedOtp = String.valueOf(100000 + new Random().nextInt(900000));

        // Save OTP to database
        boolean isSaved = registrationDAO.saveOtp(email, generatedOtp);

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
        RegistrationEntity student = registrationDAO.checkOtpMatch(email, otp);

        if (student == null) {
            System.out.println("Invalid OTP or email");
            return false;
        }

        //getting stored time
        LocalDateTime otpTime = student.getOtpGeneratedTime();

        if (otpTime == null) {
            System.out.println("Otp generaation time not found");
            return false;
        }

        // getting current time
        LocalDateTime currentTime = LocalDateTime.now();

        //calculating difference
        long secondsDifference = Duration.between(otpTime, currentTime).getSeconds();

        System.out.println("OTP was generated at:" + otpTime);
        System.out.println("Current Time is:" + currentTime);
        System.out.println("time Difference is " + secondsDifference + "seconds");


        //checking if its under 60 seconds
        if (secondsDifference > 60) {
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
        return registrationDAO.updatePassword(email, encryptedPassword);
    }

    @Override
    public RegistrationEntity getUserByEmail(String email) {
        return registrationDAO.loginByEmail(email);
    }

    @Override
    public boolean updateProfile(String email, String name, String phone, Integer age, String address) {

        // Validate inputs
        if (email == null || name == null || age == null || address == null) {
            return false;
        }

        // Add validation in service
        if (phone != null && !phone.matches("[6-9][0-9]{9}")) {
            return false;
        }
        if (age < 18 || age > 60) {
            return false;
        }

        // Call DAO to update
        return registrationDAO.updateProfile(email, name, phone, age, address);
    }


    @Override
    public boolean uploadProfilePhoto(String email, MultipartFile file){


        try {
            // Check file empty
            if (file.isEmpty()) {
                System.out.println(" File is empty");
                return false;
            }

            // Check file size
            if (file.getSize() > FileUploadConfig.MAX_FILE_SIZE) {
                System.out.println(" File size too large");
                return false;
            }

            // Create unique filename
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));

            // Clean email for filename (remove @ and .)
            String cleanEmail = email.replace("@", "_at_").replace(".", "_");

            // Add timestamp to prevent caching issues
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));

            String newFilename = "user_" + cleanEmail + "_" + timestamp + extension;

            System.out.println("New filename: " + newFilename);

// Ensure upload folder exists
//            Path uploadPath = Paths.get(FileUploadConfig.PROFILE_DIR);
//            Files.createDirectories(uploadPath);


            // Delete old profile photo (if exists)
            RegistrationEntity entity = registrationDAO.loginByEmail(email);
            if (entity != null && entity.getProfilePhoto() != null) {
                String oldPhoto = entity.getProfilePhoto();
                if (!oldPhoto.equals(FileUploadConfig.DEFAULT_AVATAR)) {
                    File oldFile = new File(FileUploadConfig.PROFILE_DIR + oldPhoto);
                    if (oldFile.exists()) {
                        boolean deleted = oldFile.delete();
                        System.out.println(deleted ? "🗑️ Deleted old photo: " + oldPhoto : "⚠️ Could not delete old photo");
                    }
                }
            }

            //Save to D drive
            Path filePath = Paths.get(FileUploadConfig.PROFILE_DIR + newFilename);
            Files.write(filePath, file.getBytes());

            System.out.println(" File saved to D drive: " + filePath.toAbsolutePath());

            // 4. Update DB (filename only)
            boolean updated =  registrationDAO.updateProfilePhoto(email, newFilename);

            if(updated){
                System.out.println(" Database updated with filename: " + newFilename);
            } else {
                System.err.println(" Failed to update database");
                // Delete the uploaded file if database update fails
                Files.deleteIfExists(filePath);
            }

            return updated;
        } catch (Exception e) {
            System.out.println("Error saving file:"+ e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


}