package com.xworkz.eventapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EventDTO {

    private int id;
    private String eventName;
    private String eventManager;
    private String eventTime;

}
