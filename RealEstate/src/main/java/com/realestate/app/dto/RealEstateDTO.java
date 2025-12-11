package com.realestate.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class RealEstateDTO implements Serializable {

    private String fullName;
    private String email;
    private String propertyType;
    private double budget;
    private String message;

}
