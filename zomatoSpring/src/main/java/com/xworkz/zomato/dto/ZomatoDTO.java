package com.xworkz.zomato.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ZomatoDTO {

    private String ownerName;
    private String email;
    private String restaurantName;
    private  String  foodStyles;
    private  String  city;
    private long number;
    private int stars;

}
