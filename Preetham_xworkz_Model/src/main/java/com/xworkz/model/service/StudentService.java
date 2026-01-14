package com.xworkz.model.service;

import com.xworkz.model.DTO.StudentDTO;

public interface StudentService {
    
    boolean saveStudent(StudentDTO dto);

    boolean validateLogin(String email, String password);
}
