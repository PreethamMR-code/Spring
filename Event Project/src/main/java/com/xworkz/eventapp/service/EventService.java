package com.xworkz.eventapp.service;

import com.xworkz.eventapp.dto.EventDTO;
import com.xworkz.eventapp.entity.EventEntity;

import java.util.List;

public interface EventService {
    boolean validateAndSave(EventDTO eventDTO);

    EventDTO getByID(int id);

    boolean updateById( int id , EventDTO eventDTO1);

    boolean deleteById(int id);

    boolean updateManagerById(int id, String manager);

    EventDTO getEventByEventName(String eventName);

    EventDTO getEventByManager(String manager);

    EventDTO getManagerById(int id);



    Object[] getManagerAndTimeByEventName(String eventName);

    List<String> getAllManagerNames();

    List<String> getAllEvents();

    List<EventDTO> getAllEvent();

    String getEventNameByManager(String manager);

    boolean updateManagerByEventNameAndTime(String manager, String eventName, String time);

    boolean updateEventTimeByEventName(String eventTime, String eventName);

    boolean deleteByEventName(String eventName);
}
