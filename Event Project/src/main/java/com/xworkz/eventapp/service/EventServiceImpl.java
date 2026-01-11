package com.xworkz.eventapp.service;

import com.xworkz.eventapp.dto.EventDTO;
import com.xworkz.eventapp.entity.EventEntity;
import com.xworkz.eventapp.repository.EventDAO;
import com.xworkz.eventapp.repository.EventDaoImpl;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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
          EventEntity entity = new EventEntity();
          BeanUtils.copyProperties(eventDTO1,entity);
         boolean isUpdate = eventDAO.updateByID(id,entity);
         return  isUpdate;
      }
      return  false;
    }

    @Override
    public boolean deleteById(int id) {

        if (id >= 0) {
            boolean isDeleted = eventDAO.deleteById(id);
            return isDeleted;
        }
        return false;
    }

    @Override
    public boolean updateManagerById(int id, String manager) {
        if(id>=0){

            boolean isUpdate = eventDAO.updateManagerByID(id,manager);
            return  isUpdate;
        }
        return  false;
    }

    @Override
    public EventDTO getEventByEventName(String eventName) {
        if(eventName!= null){

           EventEntity eventEntity =eventDAO.getEventBYEventName(eventName);
           EventDTO eventDTO = new EventDTO();
           BeanUtils.copyProperties(eventEntity,eventDTO);
           return eventDTO;
        }
        return new EventDTO();
    }

    @Override
    public EventDTO getEventByManager(String manager) {
        if(manager !=null){
           EventEntity eventEntity =eventDAO.getEventByManager(manager);
           EventDTO eventDTO = new EventDTO();
           BeanUtils.copyProperties(eventEntity, eventDTO);
           return eventDTO;
        }
        return new EventDTO();
    }

    @Override
    public EventDTO getManagerById(int id) {
        if(id != 0){
            EventEntity eventEntity = eventDAO.getManagerById(id);
            EventDTO eventDTO = new EventDTO();
            BeanUtils.copyProperties(eventEntity,eventDTO);
            return eventDTO;

        }
        return new EventDTO();
    }



    @Override
    public Object[] getManagerAndTimeByEventName(String eventName) {

        if (eventName != null ) {
            return eventDAO.getManagerAndTimeByEventName(eventName);
        }

        return null;
    }

    @Override
    public List<String> getAllManagerNames() {

        return eventDAO.getAllManagerNames();
    }

    @Override
    public List<String> getAllEvents() {

        return eventDAO.getAllEvents();
    }

    @Override
    public List<EventDTO> getAllEvent() {

        List<EventEntity> entities =eventDAO.getAllEvent();
        List<EventDTO> eventDTOS = new ArrayList<>();
        entities.stream().forEach(eventEntity -> {
                    EventDTO eventdto = new EventDTO();
                    BeanUtils.copyProperties(eventEntity, eventdto);
                    eventDTOS.add(eventdto);
                });
        return eventDTOS;
    }

    @Override
    public String getEventNameByManager(String manager) {

        return eventDAO.getEventNameByManager(manager);
    }

    @Override
    public boolean updateManagerByEventNameAndTime(String manager, String eventName, String time) {

        return eventDAO.updateManagerByEventNameAndTime(manager,eventName,time);
    }

    @Override
    public boolean updateEventTimeByEventName(String eventTime, String eventName) {
        return eventDAO.updateEventTimeByEventName(eventTime,eventName);
    }

    @Override
    public boolean deleteByEventName(String eventName) {
        return eventDAO.deleteByEventName(eventName);
    }


}

