package com.realestate.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@Data@AllArgsConstructor
public class SearchDTO implements Serializable {

    private String emailID;
    private String propertyType;

    public SearchDTO(String mail) {
        this.emailID = mail;

    }
}
