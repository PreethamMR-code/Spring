//package com.xworkz.clothingapp;
//
//import com.xworkz.clothingapp.dto.ClothDTO;
//import com.xworkz.clothingapp.entity.ClothEntity;
//import com.xworkz.clothingapp.service.ClothService;
//import com.xworkz.clothingapp.service.ClothServiceImpl;
//
//import java.util.List;
//
//public class Runner {
//
//
//    public static void main(String[] args) {
//
//        ClothService service = new ClothServiceImpl();
//
////        ClothDTO clothDTO = new ClothDTO(
////                3,
////                "Shirt",
////                "US polo",
////                "Formal",
////                "M",
////                "Beige",
////                999.00,
////                "Cotton",
////                true
////        );
////
////        service.validateAndSave(clothDTO);
////
////        ClothDTO fetched = service.getById(1);
////        System.out.println(fetched);
//
//
//
////        fetched.setClothName("Sweater");
////        fetched.setBrand("Indian");
////        fetched.setType("casual");
////        fetched.setSize("L");
////        fetched.setColor("white");
////        fetched.setPrice(1499.00);
////        fetched.setMaterial("Ullan");
////        fetched.setAvailable(true);
////
////      boolean updated= service.updateById(3,  fetched);
////        System.out.println("updated:"+updated);
//
//
////        service.updatePriceById(1, 1499.00);
//
//        // service.deleteById(1);
//
//
//
////     String clothName = service.getClothTypeByClothName("T-Shirt");
////        System.out.println(clothName);
//
////      Double price = service.getClothPriceByClothName("Skin fit");
////        System.out.println(price);
//
//
////        Object[] brandAndPrice = service.getBrandAndPriceByClothName("Shirt");
////        for(Object obj : brandAndPrice){
////            System.out.println(obj);
////        }
//
////        List<String> brands = service.getAllBrands();
////        System.out.println(brands);
//
////        List<String> clothNames = service.getAllClothNames();
////        System.out.println(clothNames);
//
////        List<ClothEntity> entities = service.getAllCloths();
////        System.out.println(entities);
//
//
////        String clothName = service.getClothNameByBrand("Nike");
////        System.out.println(clothName);
//
////        List<ClothEntity> entities = service.getClothsByColor("white");
////        System.out.println(entities);
//
////        double maxPrice =2000;
////        List<ClothEntity> cloths = service.getClothsBelowPrice(maxPrice);
////        if(cloths.isEmpty()){
////            System.out.println("no cloths found beleow price:"+maxPrice);
////        }else {
////            cloths.forEach(System.out::println);
////        }
//
////        Long totalCount  = service.getTotalClothCount();
////        System.out.println(totalCount);
//
////        Double avgPrice = service.getAverageClothPrice();
////        System.out.println(avgPrice);
//
////        List<ClothEntity> entities = service.getClothsBySize("M");
////        System.out.println(entities);
//
////        List<ClothEntity> entities = service.getClothsByMaterial("Cotton");
////        System.out.println(entities);
//
////        List<ClothEntity> entities = service.getClothsByType("sports");
////        System.out.println(entities);
//
////        List<String> availableCloth = service.getAvailableClothNames();
////        System.out.println(availableCloth);
//
//
//
//
//
//
//
//
//
//
//
//
//
//    }
//}
