package com.xworkz.eventapp.service;

import com.xworkz.eventapp.dto.EventDTO;
import com.xworkz.eventapp.entity.EventEntity;
import com.xworkz.eventapp.repository.EventDAO;
import com.xworkz.eventapp.repository.EventDaoImpl;
import org.springframework.beans.BeanUtils;

public class EventServiceImpl implements EventService {


    EventDAO eventDAO = new EventDaoImpl();

    @Override
    public boolean validateAndSave(EventDTO eventDTO) {

        EventEntity eventEntity = new EventEntity();

        BeanUtils.copyProperties(eventDTO, eventEntity);
        eventDAO.save(eventEntity);
        return true;
    }

    @Override
    public EventDTO getByID(int id) {

        EventEntity eventEntity = eventDAO.getById(id);
        EventDTO eventDTO = new EventDTO();


        BeanUtils.copyProperties(eventEntity,eventDTO);



        return eventDTO;
    }

    @Override
    public boolean updateById(int id, EventDTO eventDTO1) {
      if(id>=0){
          EventEntity e = new EventEntity();
          BeanUtils.copyProperties(eventDTO1,e);
         boolean isUpdate = eventDAO.updateByID(id,e);
         return  isUpdate;
      }
      return  false;
    }

    @Override
    public boolean deleteById(int id) {

        if(id>=0){
            boolean isDeleted = eventDAO.deleteById(id);
            return isDeleted;
        }
        return false;
    }
}

