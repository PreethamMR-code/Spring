package com.xworkz.model.repository;

import com.xworkz.model.entity.StudentEntity;

public interface StudentDAO {

    boolean save(StudentEntity studentEntity);

    StudentEntity findByEmail(String email);
}
