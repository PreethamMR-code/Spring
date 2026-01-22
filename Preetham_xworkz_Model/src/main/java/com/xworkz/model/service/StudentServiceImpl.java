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
import java.util.Base64;

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
    public boolean saveStudent(StudentDTO dto) {

        // ONLY business logic here
        String encryptedPassword = encrypt(dto.getPassword());

        StudentEntity entity = new StudentEntity();
        entity.setName(dto.getName());
        entity.setEmail(dto.getEmail());
        entity.setPhone(dto.getPhone());
        entity.setAge(dto.getAge());
        entity.setGender(dto.getGender());
        entity.setAddress(dto.getAddress());
        entity.setPassword(encryptedPassword);

        return studentDAO.save(entity);
    }

    @Override
    public boolean validateLogin(String email, String password) {

        StudentEntity entity = studentDAO.findByEmail(email);
        if (entity == null) {
            return false;
        }

        String decryptedPassword = decrypt(entity.getPassword());
        return decryptedPassword.equals(password);
    }

    @Override
    public StudentEntity findByEmail(String email) {
        return studentDAO.findByEmail(email);
    }

    //  FAILED LOGIN → increment count
    @Override
    public int updateCount(String email) {

        StudentEntity entity = studentDAO.findByEmail(email);

        if (entity == null) {
            return 0;
        }

        int count = entity.getLoginCount() + 1;

        studentDAO.updateLoginCount(email, count);

        return count;
    }

    // SUCCESSFUL LOGIN → reset count
    @Override
    public void setCountToZero(String email) {

        studentDAO.resetLoginCount(email);

    }

    @Override
    public boolean generateAndSendOtp(String email) {

        System.out.println("service : generateAndSendOtp called:"+email);

        String otp = "171717";

        boolean saved = studentDAO.saveOtp(email, otp);

        System.out.println("DAO saveotp result:" + saved);

        if (saved) {
            otpUtil.sendOtpMail(otp);
            return true;
        }
        return false;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {

        return studentDAO.checkOtpMatch(email , otp);

    }

}