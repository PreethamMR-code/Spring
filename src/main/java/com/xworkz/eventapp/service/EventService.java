package com.xworkz.eventapp.service;

import com.xworkz.eventapp.dto.EventDTO;

public interface EventService {
    boolean validateAndSave(EventDTO eventDTO);

    EventDTO getByID(int id);

    boolean updateById( int id , EventDTO eventDTO1);

    boolean deleteById(int id);
}
