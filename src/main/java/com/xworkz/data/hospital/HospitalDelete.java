package com.xworkz.data.hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class HospitalDelete {
    public static void main(String[] args) {


        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";

        try {

            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connection:" + connection);

            Statement statement = connection.createStatement();

            System.out.println("Deleting...");

            // Delete based on column match
            String sql = "delete from hospital where rating < 4.0";
            int row = statement.executeUpdate(sql);
            System.out.println("row:" + row);

            // Delete by Primary Key
            String sql1 = "delete from hospital where hospital_id = 10";
            int row1 = statement.executeUpdate(sql1);
            System.out.println("row2:" + row1);
        }
        catch (SQLException sqlException){
            sqlException.printStackTrace();
        }
        System.out.println("delete is complete");
    }
}
