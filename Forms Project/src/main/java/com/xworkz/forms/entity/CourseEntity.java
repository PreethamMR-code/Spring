package com.xworkz.forms.entity;

import com.xworkz.forms.DTO.CourseDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "course_table")
public class CourseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int duration;
    private char mode;
    private long code;
    private float rating;
    private double fee;
    private boolean active;
    private short credits;
    private byte level;

    // ✅ REQUIRED BY SERVICE LAYER
    public CourseEntity(CourseDTO dto) {
        this.name = dto.getName();
        this.duration = dto.getDuration();
        this.mode = dto.getMode().charAt(0); // String → char
        this.code = dto.getCode();
        this.rating = dto.getRating();
        this.fee = dto.getFee();
        this.active = dto.getActive();
        this.credits = dto.getCredits();
        this.level = dto.getLevel();
    }
}
