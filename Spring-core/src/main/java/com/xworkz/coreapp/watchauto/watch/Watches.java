package com.xworkz.coreapp.watchauto.watch;

import com.xworkz.coreapp.watchauto.details.Amount;
import com.xworkz.coreapp.watchauto.details.Series;
import com.xworkz.coreapp.watchauto.details.Type;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Data
@NoArgsConstructor
public class Watches {

    private String brand;

    @Autowired
    Series series;

    @Autowired
    Type type;

    @Autowired
    Amount amount;


}
