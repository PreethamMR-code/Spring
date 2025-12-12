package com.xworkz.coreapp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;


@Data
@ToString
@AllArgsConstructor
public class Movie {

    private String title;
    private String director;
    private int durationMin;
    private String genre;
    private double rating;
    private int releaseYear;
    private String language;
    private double budget;
}
