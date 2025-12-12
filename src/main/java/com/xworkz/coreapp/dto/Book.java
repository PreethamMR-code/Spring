package com.xworkz.coreapp.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;


@ToString
@Data
@Component
@NoArgsConstructor@AllArgsConstructor

public class Book {

    private String title;
    private String author;
    private int pages;
    private String genre;
    private double price;
    private String publisher;
    private int edition;
    private String language;
}
