package com.xworkz.agricultureapp.repository;

import com.xworkz.agricultureapp.entity.AgricultureEntity;

public interface AgricultureDAO {

    boolean save(AgricultureEntity entity);

    AgricultureEntity getById(int id);

    boolean updateByID(int id, AgricultureEntity entity);

    boolean deleteById(int id);

    boolean updateFarmerByID(int id, String farmerName);
}
