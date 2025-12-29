package com.xworkz.zomato.dto;

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
@Table(name = "zomato")
public class ZomatoDTO {



    @Id
    @Column(name = "idzomato")
    private int idZomato;

    @Column(name = "ownerName")
    private String ownerName;
    @Column(name = "email")
    private String email;
    @Column(name = "restaurantName")
    private String restaurantName;
    @Column(name = "foodStyles")
    private  String  foodStyles;
    @Column(name = "city")
    private  String  city;
    @Column(name = "number")
    private long number;
    @Column(name = "stars")
    private int stars;

}
