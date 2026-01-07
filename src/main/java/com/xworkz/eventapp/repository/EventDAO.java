package com.xworkz.eventapp.repository;

import com.xworkz.eventapp.entity.EventEntity;

public interface EventDAO {
    boolean save(EventEntity eventEntity);

    EventEntity getById(int id);

    boolean updateByID(int id, EventEntity e);

    boolean deleteById(int id);
}