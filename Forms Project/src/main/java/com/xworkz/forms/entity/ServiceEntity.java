package com.xworkz.forms.entity;

import com.xworkz.forms.DTO.ServiceDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "service_table")
public class ServiceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int duration;
    private char type;
    private long code;
    private float rating;
    private double charge;
    private boolean active;
    private short supportPeriod;
    private byte level;

    // ✅ REQUIRED BY SERVICE LAYER
    public ServiceEntity(ServiceDTO dto) {
        this.name = dto.getName();
        this.duration = dto.getDuration();
        this.type = dto.getType().charAt(0);   // String → char
        this.code = dto.getCode();
        this.rating = dto.getRating();
        this.charge = dto.getCharge();
        this.active = dto.getActive();
        this.supportPeriod = dto.getSupportPeriod();
        this.level = dto.getLevel();
    }
}
