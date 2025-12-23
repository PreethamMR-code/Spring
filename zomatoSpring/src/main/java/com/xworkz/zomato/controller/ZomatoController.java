package com.xworkz.zomato.controller;

import com.xworkz.zomato.dto.ZomatoDTO;
import com.xworkz.zomato.service.ZomatoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.DispatcherServlet;

import java.util.Optional;

@Component
@RequestMapping("/")
public class ZomatoController {

    @Autowired
    ZomatoService zomatoService;

    public ZomatoController(){
        System.out.println("zomato object created");
    }


    @PostMapping("/addRestaurant")
    public String addRestaurant(ZomatoDTO zomatoDTO){

        System.out.println(zomatoDTO);

        boolean added = zomatoService.validateAndSave(zomatoDTO);

        System.out.println("added stored as false :" + added);
        if (!added) {
            System.out.println("response");
            return "result.jsp";

        } else {
            return "error.jsp";
        }
    }

@GetMapping("/search")
    public String searchByRestaurantName(@RequestParam("restaurantName") String restaurantName, Model model){
                                                                                // model is the scope
    System.out.println(restaurantName);


   Optional<ZomatoDTO> zomatoDTO =  zomatoService.getRestaurant(restaurantName);
   model.addAttribute("zomatoDTO", zomatoDTO.get());

        return "search.jsp";
    }
}

