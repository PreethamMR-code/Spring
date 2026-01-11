package com.xworkz.eventapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@NamedQuery(name = "getEventBYEventName", query = "select ref from EventEntity ref where ref.eventName = :en ")
@NamedQuery(name = "getEventByManager",query = "select ref from EventEntity ref where ref.eventManager = :eM")
@NamedQuery(name = "getManagerById", query = "select ref from EventEntity ref where ref.id = :id")
@NamedQuery(name = "getManagerAndTimeByEventName" , query = "select ref.eventManager, ref.eventTime from EventEntity ref where ref.eventName =: eName")
@NamedQuery(name = "getAllManagerNames", query = "select ref.eventManager from EventEntity ref ")
@NamedQuery(name = "getAllEvents", query = "select ref.eventName from EventEntity ref")
@NamedQuery(name = "getAllEvent" , query = "select ref  from EventEntity ref")
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
