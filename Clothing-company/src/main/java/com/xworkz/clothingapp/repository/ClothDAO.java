package com.xworkz.clothingapp.repository;

import com.xworkz.clothingapp.entity.ClothEntity;

import java.util.List;

public interface ClothDAO {


    boolean save(ClothEntity clothEntity);

    ClothEntity getById(int id);

    boolean updateById(int id, ClothEntity clothEntity);

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

    List<ClothEntity> getClothsbyType(String type);

    List<String> getAvailableClothNames();
}
