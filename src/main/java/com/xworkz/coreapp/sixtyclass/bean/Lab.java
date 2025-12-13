package com.xworkz.coreapp.sixtyclass.bean;

import com.xworkz.coreapp.sixtyclass.sub.Researcher;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component
@Data
@NoArgsConstructor
@Scope("prototype")
public class Lab {


    @Autowired
    private Researcher researcher;
}
