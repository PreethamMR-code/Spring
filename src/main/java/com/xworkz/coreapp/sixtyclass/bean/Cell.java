package com.xworkz.coreapp.sixtyclass.bean;

import com.xworkz.coreapp.sixtyclass.sub.Partner;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Data
@NoArgsConstructor
@Scope("prototype")
public class Cell {

    @Autowired
    private Partner partner;
}
