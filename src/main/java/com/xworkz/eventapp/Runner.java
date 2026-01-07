package com.xworkz.eventapp;

import com.xworkz.eventapp.dto.EventDTO;
import com.xworkz.eventapp.service.EventService;
import com.xworkz.eventapp.service.EventServiceImpl;

public class Runner {

    public static void main(String[] args) {

        EventService eventService = new EventServiceImpl();

//        EventDTO eventDTO =  new EventDTO();
//        eventDTO.setId(1);
//        eventDTO.setEventName("Republic day");
//        eventDTO.setEventManager("Preetham M R");
//        eventDTO.setEventTime("31122025");
//
//        eventService.validateAndSave(eventDTO);

        EventDTO eventDTO1 =eventService.getByID(1);

        System.out.println(eventDTO1);

        eventDTO1.setEventTime("26-1-2026");
        eventDTO1.setEventManager("India Army");
        eventDTO1.setEventName("Republic day");


        boolean isUpdated = eventService.updateById( 1 ,eventDTO1);
        System.out.println(isUpdated+"Is Updated ");


//        boolean isDeleted = eventService.deleteById(1);
//        System.out.println(isDeleted+"data deleted");

    }


}
