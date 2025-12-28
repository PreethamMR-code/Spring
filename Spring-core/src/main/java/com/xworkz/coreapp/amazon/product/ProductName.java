package com.xworkz.coreapp.amazon.product;

import com.xworkz.coreapp.amazon.details.Seller;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
@NoArgsConstructor
public class ProductName {

    private String name;

    @Autowired
    Seller seller;
}
