package com.xworkz.agricultureapp.service;

import com.xworkz.agricultureapp.dto.AgricultureDTO;
import com.xworkz.agricultureapp.entity.AgricultureEntity;
import com.xworkz.agricultureapp.repository.AgricultureDAO;
import com.xworkz.agricultureapp.repository.AgricultureDaoImpl;
import org.springframework.beans.BeanUtils;

public class AgricultureServiceImpl implements AgricultureService{

    AgricultureDAO agricultureDAO = new AgricultureDaoImpl();


    @Override
    public boolean validateAndSave(AgricultureDTO dto) {
        AgricultureEntity entity = new AgricultureEntity();
        BeanUtils.copyProperties(dto, entity);
        agricultureDAO.save(entity);
        return true;
    }

    @Override
    public AgricultureDTO getByID(int id) {

        AgricultureEntity entity = agricultureDAO.getById(id);
        AgricultureDTO dto = new AgricultureDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    @Override
    public boolean updateById(int id, AgricultureDTO dto) {

        if (id >= 0) {
            AgricultureEntity entity = new AgricultureEntity();
            BeanUtils.copyProperties(dto, entity);
            return agricultureDAO.updateByID(id, entity);
        }
        return false;
    }

    @Override
    public boolean deleteById(int id) {

        if (id >= 0) {
            return agricultureDAO.deleteById(id);
        }
        return false;
    }

    @Override
    public boolean updateFarmerById(int id, String farmerName) {

        if (id >= 0) {
            return agricultureDAO.updateFarmerByID(id, farmerName);
        }
        return false;
    }
}
