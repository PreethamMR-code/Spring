package com.xworkz.clothingapp.service;

import com.xworkz.clothingapp.dto.ClothDTO;
import com.xworkz.clothingapp.entity.ClothEntity;
import com.xworkz.clothingapp.repository.ClothDAO;
import com.xworkz.clothingapp.repository.ClothDaoImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class ClothServiceImpl implements ClothService{

    @Autowired
    ClothDAO clothDAO;


    @Override
    public boolean validateAndSave(ClothDTO clothDTO) {

        ClothEntity clothEntity = new ClothEntity();
        BeanUtils.copyProperties(clothDTO, clothEntity);
        return clothDAO.save(clothEntity);

    }

    @Override
    public ClothDTO getById(int id) {

        ClothEntity entity = clothDAO.getById(id);

        System.out.println("service impl "+entity);
        ClothDTO dto = new ClothDTO();

        if (entity !=null){
            BeanUtils.copyProperties(entity, dto);
            return dto;
        }

        return null;
    }

    @Override
    public boolean updateById(int id, ClothDTO dto) {
        if (id >= 0) {
            ClothEntity entity = new ClothEntity();
            BeanUtils.copyProperties(dto, entity);
            return clothDAO.updateById(id, entity);
        }
        return false;
    }

    @Override
    public boolean deleteById(int id) {
        if (id >= 0) {
            return clothDAO.deleteById(id);
        }
        return false;
    }

    @Override
    public boolean updatePriceById(int id, double price) {
        if (id >= 0) {
            return clothDAO.updatePriceById(id, price);
        }
        return false;
    }

    @Override
    public String getClothTypeByClothName(String clothName) {

        return clothDAO.getClothTypeByClothName(clothName);
    }

    @Override
    public Double getClothPriceByClothName(String clothName) {

        return clothDAO.getClothPriceByClothName(clothName);
    }

    @Override
    public Object[] getBrandAndPriceByClothName(String clothName) {

        if(clothName != null){
            return clothDAO.getBrandAndPriceByClothName(clothName);
        }
        return null;
    }

    @Override
    public List<String> getAllBrands() {

        return clothDAO.getAllBrands();
    }

    @Override
    public List<String> getAllClothNames() {

        return clothDAO.getAllClothNames();
    }

    @Override
    public List<ClothEntity> getAllCloths() {

        return clothDAO.getAllCloths();
    }

    @Override
    public String getClothNameByBrand(String brand) {

        return clothDAO.getClothNameByBrand(brand);
    }

    @Override
    public List<ClothEntity> getClothsByColor(String color) {

        if(color != null){
            return clothDAO.getClothsByColor(color);
        }
       return Collections.emptyList();
    }

    @Override
    public List<ClothEntity> getClothsBelowPrice(double price) {

       if(price != 0){
           return clothDAO.getClothsBelowPrice(price);
       }

        return Collections.emptyList();
    }

    @Override
    public Long getTotalClothCount() {

        return clothDAO.getTotalClothCount();
    }

    @Override
    public Double getAverageClothPrice() {

       return clothDAO.getAverageClothPrice();

    }

    @Override
    public List<ClothEntity> getClothsBySize(String size) {
        if(size != null){
            return clothDAO.getClothsBySize(size);
        }
        return Collections.emptyList();
    }

    @Override
    public List<ClothEntity> getClothsByMaterial(String material) {

       if(material != null){
           return clothDAO.getClothsByMaterial(material);
       }

        return Collections.emptyList();
    }

    @Override
    public List<ClothEntity> getClothsByType(String type) {

        if(type != null){
            return clothDAO.getClothsbyType(type);
        }

        return Collections.emptyList();
    }

    @Override
    public List<String> getAvailableClothNames() {

        return clothDAO.getAvailableClothNames();
    }

}
