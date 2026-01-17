package com.xworkz.clothingapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "cloth")
public class ClothEntity {

    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "cloth_name")
    private String clothName;

    @Column(name = "brand")
    private String brand;

    @Column(name = "type")
    private String type;

    @Column(name = "size")
    private String size;

    @Column(name = "color")
    private String color;

    @Column(name = "price")
    private double price;

    @Column(name = "material")
    private String material;

    @Column(name = "available")
    private boolean available;
}
