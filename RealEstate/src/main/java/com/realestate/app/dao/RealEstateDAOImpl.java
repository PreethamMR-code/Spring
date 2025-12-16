package com.realestate.app.dao;

import com.realestate.app.dto.RealEstateDTO;
import com.realestate.app.dto.SearchDTO;
import lombok.SneakyThrows;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class RealEstateDAOImpl implements RealEstateDAO{


    private static final String URl = "jdbc:mysql://localhost:3306/matrimony_db";
    private static final String USER = "root";
    private static final String PASS = "0000";

    static {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySql driver is loaded");
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }
    }



    @Override
    @SneakyThrows
    public boolean save(RealEstateDTO realEstateDTO) {

        String sql = "Insert into real_estate_inquiry (full_name,email, property_type,budget,message) Values (?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(URl, USER, PASS);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, realEstateDTO.getFullName());
            preparedStatement.setString(2,realEstateDTO.getEmail());
            preparedStatement.setString(3,realEstateDTO.getPropertyType());
            preparedStatement.setDouble(4,realEstateDTO.getBudget());
            preparedStatement.setString(5,realEstateDTO.getMessage());

            System.out.println("saving to DB :"+realEstateDTO);

            int rows = preparedStatement.executeUpdate();

            System.out.println("rows inserted:"+rows);

            return rows >0;

        }
        catch (SQLException e){
            e.printStackTrace();
            return false;
        }


    }

    @Override
    public boolean existsByEmail(String email) {

        String  sql1 = "Select 1 from real_estate_inquiry where Email = ? limit 1";

        try(Connection connection = DriverManager.getConnection(URl,USER,PASS);
            PreparedStatement preparedStatement = connection.prepareStatement(sql1))
        {
            preparedStatement.setString(1,email);

            try(ResultSet resultSet = preparedStatement.executeQuery())
            {
                return resultSet.next();
            }
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    @SneakyThrows
    public boolean update(RealEstateDTO realEstateDTO) {

        String updateSql ="UPDATE real_estate_inquiry SET full_name = ?, property_type = ?, budget = ?, message = ? WHERE email = ?";

        try(Connection connection = DriverManager.getConnection(URl,USER,PASS);
            PreparedStatement preparedStatement =connection.prepareStatement(updateSql))
        {
            preparedStatement.setString(1, realEstateDTO.getFullName());
            preparedStatement.setString(2, realEstateDTO.getPropertyType());
            preparedStatement.setDouble(3, realEstateDTO.getBudget());
            preparedStatement.setString(4, realEstateDTO.getMessage());
            preparedStatement.setString(5, realEstateDTO.getEmail());

            int rows = preparedStatement.executeUpdate();
            System.out.println("rows updated:"+rows);

            return rows == 1;


        }

    }

    @Override
    @SneakyThrows
    public Optional<RealEstateDTO> findByEmail(String gmail) {

        String searchByGmail = "Select * from real_estate_inquiry where email = ?";
        System.out.println("Search by gmail:"+searchByGmail);

        try(Connection connection = DriverManager.getConnection(URl,USER,PASS);
            PreparedStatement preparedStatement = connection.prepareStatement(searchByGmail))
        {
            System.out.println("executing search by gmail...");
            preparedStatement.setString(1,gmail);
            ResultSet resultSet = preparedStatement.executeQuery();


        while(resultSet.next()){
            System.out.println("Results are found ..");

            String fullName = resultSet.getString("full_name");
            String email = resultSet.getString("email");
            String propertyType = resultSet.getString("property_type");
            double budget = resultSet.getDouble("budget");
            String message = resultSet.getString("message");

            RealEstateDTO realEstateDTO = new RealEstateDTO(fullName,email,propertyType,budget,message);

            System.out.println("REAl ESTATE DTO from DB :"+realEstateDTO);
            return Optional.of(realEstateDTO);

        }

        }
        System.out.println("result set no rows found..");

        return RealEstateDAO.super.findByEmail(gmail);
    }

    @Override
    @SneakyThrows
    public List<RealEstateDTO> findByPropertyType(String propertyType) {

        System.out.println("running findByPropertyType in RealEstateDAO :+"+propertyType);
        String propertyTypeSQL="select * from real_estate_inquiry where property_type=?";

        List<RealEstateDTO> realEstateDTOS = new ArrayList<>();

        try(Connection connection = DriverManager.getConnection(URl,USER,PASS);
            PreparedStatement preparedStatement =connection.prepareStatement(propertyTypeSQL))
        {
            preparedStatement.setString(1,propertyType);
            ResultSet resultSet =preparedStatement.executeQuery();


            while (resultSet.next())
            {
                String fullName = resultSet.getString("full_name");
                String email = resultSet.getString("email");
                String propertyTypeSearch = resultSet.getString("property_type");
                double budget = resultSet.getDouble("budget");
                String message = resultSet.getString("message");


                RealEstateDTO realEstateDTO = new RealEstateDTO(fullName,email,propertyTypeSearch,budget,message);
                realEstateDTOS.add(realEstateDTO);
                System.out.println("REAL ESTATE DTO:" + realEstateDTO);

            }
        }
        System.out.println("total fishDTOS from DAO after result set:"+realEstateDTOS.size());

        return realEstateDTOS;
    }
}
