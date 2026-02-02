package com.xworkz.model.service;

import com.xworkz.model.DTO.BatchDTO;
import com.xworkz.model.entity.BatchEntity;
import com.xworkz.model.repository.BatchDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.time.LocalDateTime;
import java.util.List;

@Service
public class BatchServiceImpl implements BatchService{

    @Autowired
    BatchDAO batchDAO;

    @Override
    public boolean createBatch(BatchDTO batchDTO) {
        System.out.println("=== CREATE BATCH SERVICE CALLED ===");

        if (batchDTO == null) {
            System.err.println("ERROR: BatchDTO is null");
            return false;
        }

        System.out.println("Converting DTO to Entity...");

        // Convert DTO to Entity
        BatchEntity batch = new BatchEntity();
        batch.setBatchName(batchDTO.getBatchName());
        batch.setInstructor(batchDTO.getInstructor());
        batch.setCourse(batchDTO.getCourse());
        batch.setStartDate(batchDTO.getStartDate());
        batch.setBatchType(batchDTO.getBatchType());
        batch.setDescription(batchDTO.getDescription());
        batch.setCreatedAt(LocalDateTime.now());
        batch.setActive(true);  // Make sure this matches your entity field

        System.out.println("Batch Entity Created:");
        System.out.println("Name: " + batch.getBatchName());
        System.out.println("Course: " + batch.getCourse());
        System.out.println("Date: " + batch.getStartDate());

        System.out.println("Calling DAO to save...");
        boolean result = batchDAO.saveBatch(batch);

        System.out.println("DAO Result: " + result);
        return result;
    }

    @Override
    public List<BatchEntity> getAllBatches() {
        return batchDAO.getAllBatches();
    }

    @Override
    public BatchEntity getBatchById(int id) {
        return batchDAO.getBatchById(id);
    }

    @Override
    public boolean updateBatch(BatchDTO batchDTO) {
        BatchEntity batch = batchDAO.getBatchById(batchDTO.getId());
        if (batch == null) {
            return false;
        }

        batch.setBatchName(batchDTO.getBatchName());
        batch.setInstructor(batchDTO.getInstructor());
        batch.setCourse(batchDTO.getCourse());
        batch.setStartDate(batchDTO.getStartDate());
        batch.setBatchType(batchDTO.getBatchType());
        batch.setDescription(batchDTO.getDescription());

        return batchDAO.updateBatch(batch);
    }

    @Override
    public boolean deleteBatch(int id) {
        return batchDAO.deleteBatch(id);
    }
}
