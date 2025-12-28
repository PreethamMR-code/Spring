package com.xworkz.coreapp.concept;

import com.xworkz.coreapp.config.InternetConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class InstituteRunner {

    public static void main(String[] args) {

        System.out.println("main started");

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(InternetConfig.class);

        Institute institute = applicationContext.getBean(Institute.class);

        institute.getId();
        institute.getLoc();
        institute.addInstitute();
        System.out.println("getting the method");

        System.out.println(institute);






    }
}
