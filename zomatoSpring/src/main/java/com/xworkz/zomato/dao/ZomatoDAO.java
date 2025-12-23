package com.xworkz.zomato.dao;

import com.xworkz.zomato.dto.ZomatoDTO;

import java.util.Optional;

public interface ZomatoDAO {

    boolean save(ZomatoDTO zomatoDTO);

    Optional<ZomatoDTO> getRestaurantByName(String restaurantName);
}
