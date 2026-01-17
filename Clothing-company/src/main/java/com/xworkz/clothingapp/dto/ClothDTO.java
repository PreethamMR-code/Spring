package com.xworkz.clothingapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ClothDTO {

    private int id;
    private String clothName;
    private String brand;
    private String type;
    private String size;
    private String color;
    private double price;
    private String material;
    private boolean available;
}
