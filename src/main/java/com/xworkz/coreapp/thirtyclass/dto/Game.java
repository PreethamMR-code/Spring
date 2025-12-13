package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@AllArgsConstructor
@Data
@ToString

public class Game {

    private String title;
    private String genre;
    private double rating;
    private String platform;
    private int releaseYear;
    private double sizeGB;
    private boolean multiplayer;
    private String developer;
}
