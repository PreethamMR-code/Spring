package com.xworkz.data.president;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class PresidentDelete {

    public static void main(String[] args) {

         String url = "jdbc:mysql://localhost:3306/matrimony_db";
         String username = "root";
         String password = "0000";


         try {

             Connection connection = DriverManager.getConnection(url, username, password);
             System.out.println("Connection:" + connection);

             Statement statement = connection.createStatement();

             System.out.println("deleting");

             String sql = "delete from president where party='Independent'";
             int row = statement.executeUpdate(sql);
             System.out.println("row:" + row);

             String sql1 = "delete from president where president_id = 10";
             int row1 = statement.executeUpdate(sql1);
             System.out.println("row2:" + row1);
         }
         catch (SQLException sqlException){
             sqlException.printStackTrace();
         }
        System.out.println("delete is completed");

    }
}
