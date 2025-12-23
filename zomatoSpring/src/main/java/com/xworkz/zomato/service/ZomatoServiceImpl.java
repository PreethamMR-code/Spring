package com.xworkz.zomato.service;

import com.xworkz.zomato.dao.ZomatoDAO;
import com.xworkz.zomato.dto.ZomatoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class ZomatoServiceImpl implements ZomatoService {

    @Autowired
    ZomatoDAO zomatoDAO;

    @Override
    public boolean validateAndSave(ZomatoDTO zomatoDTO) {

        boolean invalid = false;


        if (zomatoDTO != null) {
            System.out.println("data is  entered");

            System.out.println("validation started");

            if (zomatoDTO.getOwnerName() == null || zomatoDTO.getOwnerName().trim().length() < 3) {
                invalid = true;
                System.out.println("owner name  not valid");
            }

            if (zomatoDTO.getEmail() == null || !zomatoDTO.getEmail().contains("@")) {
                invalid = true;
                System.out.println("email not valid");
            }

            if (zomatoDTO.getRestaurantName() == null || zomatoDTO.getRestaurantName().trim().length() < 3) {
                invalid = true;
                System.out.println("restaurant name  not valid");
            }

            if (zomatoDTO.getFoodStyles() == null || zomatoDTO.getFoodStyles().isEmpty()) {
                invalid = true;
                System.out.println("select atleast one ");
            }

            if (zomatoDTO.getCity() == null || zomatoDTO.getCity().trim().length() < 3) {
                invalid = true;
                System.out.println("city name  not valid");
            }

            if (zomatoDTO.getNumber() == 0 || zomatoDTO.getNumber() < 5) {
                System.out.println("number not valid");
                invalid = true;
            }

            if (zomatoDTO.getStars() == 0 || zomatoDTO.getStars() <= 1) {
                System.out.println("number not valid");
                invalid = true;
            }


        }
        if (!invalid) {

            System.out.println("all valid and proceeding to save");

            boolean saved = zomatoDAO.save(zomatoDTO);
            System.out.println("validation is done and saved to DB:" + saved);

            if (!saved) {
                invalid = true;
            }
        }
        return invalid;

    }

    @Override
    public Optional<ZomatoDTO> getRestaurant(String restaurantName) {

        if (restaurantName != null) {
            return zomatoDAO.getRestaurantByName(restaurantName);
        } else {

            return Optional.empty();
        }
    }
}
