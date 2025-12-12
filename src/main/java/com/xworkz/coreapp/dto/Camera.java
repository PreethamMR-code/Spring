package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@ToString
@Data
@AllArgsConstructor
public class Camera {

    private String title;
    private String artist;
    private int tracks;
    private String genre;
    private int releaseYear;
    private double duration;
    private double price;
    private String language;
}
