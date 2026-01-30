package com.xworkz.model.service;

import com.xworkz.model.DTO.BatchStudentDTO;
import com.xworkz.model.entity.BatchStudentEntity;

import java.util.List;

public interface BatchStudentService {

    boolean addStudent(BatchStudentDTO studentDTO);

    List<BatchStudentEntity> getStudentsByBatchId(int batchId);

    BatchStudentEntity getStudentById(int id);

    String generateStudentId();

    boolean updateStudent(BatchStudentDTO studentDTO);

    boolean deleteStudent(int id);
}
