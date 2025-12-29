//package com.xworkz.zomato.dao;
//
//import com.xworkz.zomato.dto.ZomatoDTO;
//import org.springframework.stereotype.Component;
//
//import java.sql.*;
//import java.util.Optional;
//
//@Component
//public class ZomatoDaoImpl implements ZomatoDAO {
//
//
//    private static final String URL = "jdbc:mysql://localhost:3306/matrimony_db";
//    private static final String USER = "root";
//    private static final String PASS = "0000";
//
//    static {
//        try{
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            System.out.println("MySql driver is loaded");
//        }catch (ClassNotFoundException e){
//            e.printStackTrace();
//        }
//    }
//
//
//    @Override
//    public boolean save(ZomatoDTO zomatoDTO) {
//
//
//        String sql = "INSERT INTO zomato (ownerName, email, restaurantName, foodStyles, city, number, stars) VALUES (?, ?, ?, ?, ?, ?, ?)";
//
//        try(Connection connection = DriverManager.getConnection(URL,USER,PASS);
//
//            PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
//
//
//            preparedStatement.setString(1, zomatoDTO.getOwnerName());
//            preparedStatement.setString(2, zomatoDTO.getEmail());
//            preparedStatement.setString(3, zomatoDTO.getRestaurantName());
//            preparedStatement.setString(4, zomatoDTO.getFoodStyles());
//            preparedStatement.setString(5, zomatoDTO.getCity());
//            preparedStatement.setLong(6, zomatoDTO.getNumber());
//            preparedStatement.setInt(7, zomatoDTO.getStars());
//
//            System.out.println("saving to DB:"+zomatoDTO);
//
//            int rows = preparedStatement.executeUpdate();
//
//            System.out.println("rows inserted:"+rows);
//
//            return rows > 0;
//        }
//        catch (SQLException e){
//            e.printStackTrace();
//            return false;
//        }
//
//    }
//
//    @Override
//    public Optional<ZomatoDTO> getRestaurantByName(String restaurantName) {
//
//        String sql = "Select * from zomato where restaurantName = ?";
//
//        try(Connection connection = DriverManager.getConnection(URL,USER,PASS);
//        PreparedStatement preparedStatement = connection.prepareStatement(sql)){
//
//
//            preparedStatement.setString(1,restaurantName);
//
//            ResultSet resultSet = preparedStatement.executeQuery();
//
//            while (resultSet.next()){
//
//                String ownerName =resultSet.getString(2);
//                String email =resultSet.getString(3);
//                String restName =resultSet.getString(4);
//                String foodStyles =resultSet.getString(5);
//                String city =resultSet.getString(6);
//                long number = Long.parseLong(resultSet.getString(7));
//                int stars = Integer.parseInt(resultSet.getString(8));
//
//                ZomatoDTO zomatoDTO = new ZomatoDTO(ownerName,email,restName,foodStyles,city,number,stars);
//                System.out.println(zomatoDTO);
//
//                return Optional.of(zomatoDTO);
//
//            }
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//
//    return Optional.empty();
//    }
//}
