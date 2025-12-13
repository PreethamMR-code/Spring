package com.xworkz.coreapp.sixtyclass.bean;

import com.xworkz.coreapp.sixtyclass.sub.Pupil;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@NoArgsConstructor
@Data
@Component
@Scope("prototype")
public class School {

    @Autowired
    private Pupil pupil;
}
