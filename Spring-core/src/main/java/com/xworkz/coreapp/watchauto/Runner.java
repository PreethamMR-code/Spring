package com.xworkz.coreapp.watchauto;

import com.xworkz.coreapp.config.InternetConfig;
import com.xworkz.coreapp.watchauto.details.Amount;
import com.xworkz.coreapp.watchauto.details.Series;
import com.xworkz.coreapp.watchauto.details.Type;
import com.xworkz.coreapp.watchauto.watch.Watches;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class Runner {

    public static void main(String[] args) {

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(InternetConfig.class);

        Watches watch = applicationContext.getBean(Watches.class);

        watch.setBrand("Seiko");

        Series series = watch.getSeries();
        series.setSeriesName("SNPK");


        Type type = watch.getType();
        type.setAutomatic(true);

        Amount amount = watch.getAmount();
        amount.setPrice(23.354);
        System.out.println(watch);

    }
}
