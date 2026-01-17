package com.xworkz.clothingapp.service;

import com.xworkz.clothingapp.dto.ClothDTO;
import com.xworkz.clothingapp.entity.ClothEntity;

import java.util.List;

public interface ClothService {

    boolean validateAndSave(ClothDTO clothDTO);

    ClothDTO getById(int id);

    boolean updateById(int id, ClothDTO clothDTO);

    boolean deleteById(int id);

    boolean updatePriceById(int id, double price);

    String getClothTypeByClothName(String clothName);

    Double getClothPriceByClothName(String clothName);

    Object[] getBrandAndPriceByClothName(String clothName);

    List<String> getAllBrands();

    List<String> getAllClothNames();

    List<ClothEntity> getAllCloths();

    String getClothNameByBrand(String brand);

    List<ClothEntity> getClothsByColor(String color);

    List<ClothEntity> getClothsBelowPrice(double price);

    Long getTotalClothCount();

    Double getAverageClothPrice();

    List<ClothEntity> getClothsBySize(String size);

    List<ClothEntity> getClothsByMaterial(String material);

    List<ClothEntity> getClothsByType(String type);

    List<String> getAvailableClothNames();
}
