package com.xworkz.eventapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "event")
public class EventEntity {

    @Id
    @Column(name = "id")
    private int id;
    @Column(name = "event_name")
    private String eventName;
    @Column(name = "event_manager")
    private String eventManager;
    @Column(name = "event_time")
    private String eventTime;

}
