package com.xworkz.model.service;

import com.xworkz.model.DTO.BatchDTO;
import com.xworkz.model.entity.BatchEntity;

import java.util.List;

public interface BatchService {

    boolean createBatch(BatchDTO batchDTO);

    List<BatchEntity> getAllBatches();

    BatchEntity getBatchById(int id);

    boolean updateBatch(BatchDTO batchDTO);

    boolean deleteBatch(int id);
}
