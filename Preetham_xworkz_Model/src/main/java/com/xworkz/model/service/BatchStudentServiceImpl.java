package com.xworkz.model.service;

import com.xworkz.model.DTO.BatchStudentDTO;
import com.xworkz.model.entity.BatchStudentEntity;
import com.xworkz.model.repository.BatchStudentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public class BatchStudentServiceImpl implements BatchStudentService{

    @Autowired
    BatchStudentDAO batchStudentDAO;

    @Override
    public boolean addStudent(BatchStudentDTO studentDTO) {
        if (studentDTO == null) {
            return false;
        }

        // Convert DTO to Entity
        BatchStudentEntity student = new BatchStudentEntity();

        // Auto-generate student ID
        student.setStudentId(batchStudentDAO.generateStudentId());

        student.setBatchId(studentDTO.getBatchId());
        student.setName(studentDTO.getName());
        student.setEmail(studentDTO.getEmail());
        student.setGender(studentDTO.getGender());
        student.setPhone(studentDTO.getPhone());
        student.setAge(studentDTO.getAge());
        student.setAddress(studentDTO.getAddress());
        student.setJoinedDate(LocalDateTime.now());
        student.setActive(true);

        return batchStudentDAO.saveStudent(student);
    }

    @Override
    public List<BatchStudentEntity> getStudentsByBatchId(int batchId) {
        return batchStudentDAO.getStudentsByBatchId(batchId);
    }

    @Override
    public BatchStudentEntity getStudentById(int id) {
        return batchStudentDAO.getStudentById(id);
    }

    @Override
    public String generateStudentId() {
        return batchStudentDAO.generateStudentId();
    }

    // needs edit option

    @Override
    public boolean updateStudent(BatchStudentDTO studentDTO) {
        BatchStudentEntity student = batchStudentDAO.getStudentById(studentDTO.getId());
        if (student == null) {
            return false;
        }

        student.setName(studentDTO.getName());
        student.setEmail(studentDTO.getEmail());
        student.setGender(studentDTO.getGender());
        student.setPhone(studentDTO.getPhone());
        student.setAge(studentDTO.getAge());
        student.setAddress(studentDTO.getAddress());

        return batchStudentDAO.updateStudent(student);
    }

    @Override
    public boolean deleteStudent(int id) {
        return batchStudentDAO.deleteStudent(id);
    }
}
