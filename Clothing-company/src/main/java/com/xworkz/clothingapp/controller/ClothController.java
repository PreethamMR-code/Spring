package com.xworkz.clothingapp.controller;

import com.xworkz.clothingapp.dto.ClothDTO;
import com.xworkz.clothingapp.service.ClothService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class ClothController {

    @Autowired
    ClothService clothService;

    public ClothController(){
        System.out.println("controller object created");
    }

    @PostMapping("cloth")
    public String CreateClothAccount(ClothDTO clothDTO, Model model){
        System.out.println(clothDTO);

        boolean saved = clothService.validateAndSave(clothDTO);
        System.out.println("the data is valid and saved:" + saved);

        if(saved) {
            model.addAttribute("status", true);
            model.addAttribute("message", "Cloth registered successfully!");
            return "response";
        }else {
            model.addAttribute("status", false);
            model.addAttribute("message", "Cloth already exists or invalid data");
            return "response";
        }
    }

    @GetMapping("/searchCloth")
    public String searchCloth(int id , Model model) {
        System.out.println(id);

        ClothDTO fetched = clothService.getById(id);
        System.out.println("controller");
        System.out.println(fetched);

        if (fetched != null) {
            model.addAttribute("cloth", fetched);
            return "result";
        } else {
            model.addAttribute("message", "cloth not found or not available");
            return "error";
        }
    }

    @GetMapping("update")
    public String openUpdatePage(ClothDTO clothDTO, Model model) {
        model.addAttribute("cloth", clothDTO);
        return "update";   // update.jsp
    }


    @PostMapping("updateCloth")
    public String updateCloth(int id ,ClothDTO clothDTO,Model model){

        boolean updated = clothService.updateById(id,clothDTO);

        if(updated){
            model.addAttribute("success" ,"data updated successfully");
            return "update";
        }else {
            model.addAttribute("error","please try again");
            return "update";
        }
    }


    @GetMapping("deleteCloth")
    public String deleteCloth(int id, Model model){
        System.out.println("delete cloth using ID:"+ id);

        boolean deleted = clothService.deleteById(id);

        if(deleted){
            model.addAttribute("success","cloth deleted successfully");
        }else {
            model.addAttribute("error", "cloth not found");
        }
        return "delete";
    }

}
