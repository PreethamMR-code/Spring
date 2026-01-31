package com.xworkz.model.repository;

import com.xworkz.model.entity.BatchStudentEntity;

import java.util.List;

public interface BatchStudentDAO {

    boolean saveStudent(BatchStudentEntity student);

    List<BatchStudentEntity> getStudentsByBatchId(int batchId);

    BatchStudentEntity getStudentById(int id);

    String generateStudentId(); // Auto-generate XWZ001, XWZ002, etc.

    boolean updateStudent(BatchStudentEntity student);

    boolean deleteStudent(int id);
}
