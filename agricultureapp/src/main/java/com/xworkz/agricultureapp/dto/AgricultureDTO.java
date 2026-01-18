package com.xworkz.agricultureapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class AgricultureDTO {

    private int id;
    private String cropName;
    private String farmerName;
    private String season;
}
