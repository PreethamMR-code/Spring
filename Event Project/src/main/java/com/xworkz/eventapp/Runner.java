package com.xworkz.eventapp;

import com.xworkz.eventapp.dto.EventDTO;
import com.xworkz.eventapp.entity.EventEntity;
import com.xworkz.eventapp.service.EventService;
import com.xworkz.eventapp.service.EventServiceImpl;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

public class Runner {

    public static void main(String[] args) {

        EventService eventService = new EventServiceImpl();

//        EventDTO eventDTO =  new EventDTO();
//        eventDTO.setId(2);
//        eventDTO.setEventName("Sankarnti");
//        eventDTO.setEventManager("Preetham M R");
//        eventDTO.setEventTime("14-1-2026");
//
//
//        eventService.validateAndSave(eventDTO);

//        EventDTO eventDTO1 =eventService.getByID(2);
//        System.out.println(eventDTO1);
//
//        eventDTO1.setEventTime("14-1-2026");
//        eventDTO1.setEventManager("kohli");
//        eventDTO1.setEventName("Sankarnti");


//        boolean isUpdated = eventService.updateById( 2 ,eventDTO1);
//        System.out.println(isUpdated+"Is Updated ");
//
//        boolean isUpdate = eventService.updateManagerById(2, "virat");
//        System.out.println(isUpdate);


//        boolean isDeleted = eventService.deleteById(2);
//        System.out.println(isDeleted+ " data deleted");

//
//        EventDTO eventDTO =eventService.getEventByEventName("Sankarnti");
//        System.out.println(eventDTO);
//
//        EventDTO eventDTO1=eventService.getEventByManager("India Army");
//        System.out.println(eventDTO1);
//
//        EventDTO eventDTO2 = eventService.getManagerById(1);
//        System.out.println(eventDTO2);


        // 1 row and 2 column   (if same event name is there then use list<Objects[]> for 2 row 2 col)
//       Object[] objects = eventService.getManagerAndTimeByEventName("Republic Day");
//       for(Object o : objects){
//           System.out.println(o);
//       }


        //multiple row and one column
//     List<String> list = eventService.getAllManagerNames();
//       list.stream().forEach(System.out::println);

//        List<String> list = eventService.getAllEvents();
//        list.stream().forEach(System.out::println);


//        List<EventDTO> list = eventService.getAllEvent();
//        list.stream().forEach(System.out::println);

//        String manager = eventService.getEventNameByManager("India Army");
//        System.out.println(manager);


//       boolean update = eventService.updateManagerByEventNameAndTime("Defence forces", "Republic Day", "26-1-2026");
//        System.out.println(update);

//       boolean updateTime =  eventService.updateEventTimeByEventName("8-1-2026","sankarnti");
//        System.out.println(updateTime);

        boolean delete = eventService.deleteByEventName("sankarnti");
        System.out.println(delete);


    }
}
