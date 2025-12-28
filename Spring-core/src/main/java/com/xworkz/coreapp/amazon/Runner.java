package com.xworkz.coreapp.amazon;

import com.xworkz.coreapp.amazon.details.Seller;
import com.xworkz.coreapp.amazon.product.ProductName;
import com.xworkz.coreapp.config.InternetConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Runner {

    public static void main(String[] args) {

        ApplicationContext applicationContext =new AnnotationConfigApplicationContext(InternetConfig.class);

        ProductName productName = applicationContext.getBean(ProductName.class);

        productName.setName("Muscle Blaze");

        Seller seller = productName.getSeller();
        seller.setSellerName("blaze");

        System.out.println(productName);
    }
}
