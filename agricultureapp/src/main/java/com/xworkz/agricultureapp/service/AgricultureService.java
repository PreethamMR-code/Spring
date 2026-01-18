package com.xworkz.agricultureapp.service;

import com.xworkz.agricultureapp.dto.AgricultureDTO;

public interface AgricultureService {

    boolean validateAndSave(AgricultureDTO dto);

    AgricultureDTO getByID(int id);

    boolean updateById(int id, AgricultureDTO dto);

    boolean deleteById(int id);

    boolean updateFarmerById(int id, String farmerName);
}
