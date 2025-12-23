package com.xworkz.zomato.service;

import com.xworkz.zomato.dto.ZomatoDTO;

import java.util.Optional;

public interface ZomatoService {

    boolean validateAndSave(ZomatoDTO zomatoDTO);

   Optional<ZomatoDTO>  getRestaurant(String restaurantName);
}
