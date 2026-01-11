package com.xworkz.eventapp.repository;

import com.xworkz.eventapp.entity.EventEntity;

import java.util.List;

public interface EventDAO {
    boolean save(EventEntity eventEntity);

    EventEntity getById(int id);

    boolean updateByID(int id, EventEntity e);

    boolean deleteById(int id);

    boolean updateManagerByID(int id, String manager);

    EventEntity getEventBYEventName(String eventName);

    EventEntity getEventByManager(String manager);

    EventEntity getManagerById(int id);

    Object[] getManagerAndTimeByEventName(String eventName);

    List<String> getAllManagerNames();

    List<String> getAllEvents();

    List<EventEntity> getAllEvent();

    String getEventNameByManager(String manager);

    boolean updateManagerByEventNameAndTime(String manager, String eventName, String time);

    boolean updateEventTimeByEventName(String eventTime, String eventName);

    boolean deleteByEventName(String eventName);
}