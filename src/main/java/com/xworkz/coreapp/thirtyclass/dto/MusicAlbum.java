package com.xworkz.coreapp.thirtyclass.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor

@ToString
public class MusicAlbum {

    private String title;
    private String artist;
    private int tracks;
    private String genre;
    private int releaseYear;
    private double duration;
    private double price;
    private String language;
}
