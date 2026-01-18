package com.xworkz.agricultureapp;

import com.xworkz.agricultureapp.dto.AgricultureDTO;
import com.xworkz.agricultureapp.service.AgricultureService;
import com.xworkz.agricultureapp.service.AgricultureServiceImpl;

public class Runner {

    public static void main(String[] args) {


        AgricultureService service = new AgricultureServiceImpl();

        // SAVE
        AgricultureDTO dto = new AgricultureDTO(1, "Rice", "Ramesh", "Kharif");
        service.validateAndSave(dto);

        // GET
        AgricultureDTO fetched = service.getByID(1);
        System.out.println(fetched);

        // UPDATE
        fetched.setSeason("Rabi");
        fetched.setFarmerName("Suresh");
        service.updateById(1, fetched);

        // UPDATE SINGLE FIELD
        service.updateFarmerById(1, "Mahesh");

        // DELETE
        // service.deleteById(1);
    }
}
