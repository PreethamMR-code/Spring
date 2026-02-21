package com.xworkz.forms.entity;

import com.xworkz.forms.DTO.ProductDTO;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@Data
@Entity
@Table(name = "product_table")
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int quantity;
    private char type;
    private long code;
    private float rating;
    private double price;
    private boolean available;
    private short warranty;
    private byte level;


    public ProductEntity(ProductDTO dto) {
        this.name = dto.getName();
        this.quantity = dto.getQuantity();
        this.type = dto.getType().charAt(0);   // String → char
        this.code = dto.getCode();
        this.rating = dto.getRating();
        this.price = dto.getPrice();
        this.available = dto.getAvailable();
        this.warranty = dto.getWarranty();
        this.level = dto.getLevel();
    }
}
