package com.xworkz.model.repository;

import com.xworkz.model.entity.BatchEntity;

import java.util.List;

public interface BatchDAO {

    boolean saveBatch(BatchEntity batch);

    List<BatchEntity> getAllBatches();

    BatchEntity getBatchById(int id);

    boolean updateBatch(BatchEntity batch);

    boolean deleteBatch(int id);
}
