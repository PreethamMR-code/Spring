package com.xworkz.data.sweets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class SweetUpdate {

    public static void main(String[] args) {

        String url= "jdbc:mysql://localhost:3306/matrimony_db";
        String username="root";
        String password="0000";

        try {

            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connection:" + connection);

            Statement statement = connection.createStatement();

            System.out.println("updating");

            String sql = "update sweet set price= 250 where sweet_id=1";
            int row = statement.executeUpdate(sql);
            System.out.println("row:" + row);

            String sql1 = "update sweet set price= 250 where sweet_id=2";
            int row1 = statement.executeUpdate(sql1);
            System.out.println("row:" + row1);

            String sql2 = "update sweet set price= 250 where sweet_id=3";
            int row2 = statement.executeUpdate(sql2);
            System.out.println("row:" + row2);

            String sql3 = "update sweet set price= 250 where sweet_id=4";
            int row3 = statement.executeUpdate(sql3);
            System.out.println("row:" + row3);

 //           ===========================================================

            String sql4 = "update sweet set weight_grams=350 where sweet_id=1";
            int row4 = statement.executeUpdate(sql4);
            System.out.println("row1:" + row4);

            String sql5 = "update sweet set weight_grams=350 where sweet_id=2";
            int row5 = statement.executeUpdate(sql5);
            System.out.println("row1:" + row5);

            String sql6 = "update sweet set weight_grams=350 where sweet_id=3";
            int row6 = statement.executeUpdate(sql6);
            System.out.println("row1:" + row6);

            String sql7 = "update sweet set weight_grams=350 where sweet_id=4";
            int row7 = statement.executeUpdate(sql7);
            System.out.println("row1:" + row7);

//            =======================================================


            String sql8 = "update sweet set shop_name='haldirams' where sweet_id=1";
            int row8 = statement.executeUpdate(sql8);
            System.out.println("row2:" + row8);

            String sql9 = "update sweet set shop_name='haldirams' where sweet_id=2";
            int row9 = statement.executeUpdate(sql9);
            System.out.println("row2:" + row9);

            String sql10 = "update sweet set shop_name='haldirams' where sweet_id=3";
            int row10 = statement.executeUpdate(sql10);
            System.out.println("row2:" + row10);

            String sql11 = "update sweet set shop_name='haldirams' where sweet_id=4";
            int row11 = statement.executeUpdate(sql11);
            System.out.println("row2:" + row11);


//            ===================================================================

            String sql12 = "update sweet set sweet_type='dry fruit special' where sweet_id=1";
            int row12 = statement.executeUpdate(sql12);
            System.out.println("row3:" + row12);

            String sql13 = "update sweet set sweet_type='dry fruit special' where sweet_id=2";
            int row13 = statement.executeUpdate(sql13);
            System.out.println("row3:" + row13);

            String sql14 = "update sweet set sweet_type='dry fruit special' where sweet_id=3";
            int row14 = statement.executeUpdate(sql14);
            System.out.println("row3:" + row14);

            String sql15 = "update sweet set sweet_type='dry fruit special' where sweet_id=4";
            int row15 = statement.executeUpdate(sql15);
            System.out.println("row3:" + row15);

        }
        catch(SQLException sqlException){
            sqlException.printStackTrace();
        }
        System.out.println("Update Operation Completed");
    }
}
