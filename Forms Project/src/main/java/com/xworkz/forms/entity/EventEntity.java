package com.xworkz.forms.entity;


import com.xworkz.forms.DTO.EventDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "event_table")
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int duration;
    private char type;
    private long code;
    private float rating;
    private double budget;
    private boolean active;
    private short teamSize;
    private byte priority;


    public EventEntity(EventDTO dto) {
        this.name = dto.getName();
        this.duration = dto.getDuration();
        this.type = dto.getType().charAt(0);   // String → char
        this.code = dto.getCode();
        this.rating = dto.getRating();
        this.budget = dto.getBudget();
        this.active = dto.getActive();
        this.teamSize = dto.getTeamSize();
        this.priority = dto.getPriority();
    }
}

