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
        if (batchDTO == null) {
            return false;
        }

        // Convert DTO to Entity
        BatchEntity batch = new BatchEntity();
        batch.setBatchName(batchDTO.getBatchName());
        batch.setInstructor(batchDTO.getInstructor());
        batch.setCourse(batchDTO.getCourse());
        batch.setStartDate(batchDTO.getStartDate());
        batch.setBatchType(batchDTO.getBatchType());
        batch.setDescription(batchDTO.getDescription());
        batch.setCreatedAt(LocalDateTime.now());
        batch.setActive(true);

        return batchDAO.saveBatch(batch);
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
