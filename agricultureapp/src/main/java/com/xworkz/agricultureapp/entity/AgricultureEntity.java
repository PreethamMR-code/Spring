package com.xworkz.agricultureapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name = "agriculture")
public class AgricultureEntity {

    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "crop_name")
    private String cropName;

    @Column(name = "farmer_name")
    private String farmerName;

    @Column(name = "season")
    private String season;
}
