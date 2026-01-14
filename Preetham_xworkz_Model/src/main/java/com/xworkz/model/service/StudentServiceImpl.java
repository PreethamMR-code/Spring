package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;
import com.xworkz.model.entity.StudentEntity;
import com.xworkz.model.repository.StudentDAO;
import org.springframework.beans.BeanUtils;
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

        if (dto == null) {
            return false;
        }

        if (dto.getName() == null || dto.getName().trim().isEmpty()){
            return false;
        }

        if (dto.getEmail() == null || !dto.getEmail().contains("@")) {
            return false;
        }

        if (dto.getPhone() == null || dto.getPhone().trim().length() < 10) {
            return false;
        }

        if (dto.getAge() == 0 || dto.getAge() < 10 || dto.getAge() > 100) {
            return false;
        }

        if (dto.getGender() == null || dto.getGender().trim().isEmpty()) {
            return false;
        }

        if (dto.getAddress() == null || dto.getAddress().trim().isEmpty()) {
            return false;
        }

        if (dto.getPassword() == null || dto.getPassword().length() < 8) {
            return false;
        }

        // confirm password check (not stored)
        if (dto.getConfirmPassword() == null ||
                !dto.getPassword().equals(dto.getConfirmPassword())) {
            return false;
        }

        // ===============================

        // encrypt password before saving
        String encryptedPwd = encrypt(dto.getPassword());
        dto.setPassword(encryptedPwd);
        dto.setConfirmPassword(null);   // do NOT store confirm password

        StudentEntity studentEntity = new StudentEntity();
        BeanUtils.copyProperties(dto, studentEntity);

        return studentDAO.save(studentEntity);

    }

    @Override
    public boolean validateLogin(String email, String password) {


        if (email == null || !email.contains("@")) {
            return false;
        }
        if (password == null || password.length() < 8) {
            return false;
        }

        StudentEntity entity = studentDAO.findByEmail(email);
        if (entity == null) {
            return false;
        }

        // decrypt stored password and compare with raw input
        String decryptedPwd = decrypt(entity.getPassword());
        return decryptedPwd.equals(password);
    }
}
