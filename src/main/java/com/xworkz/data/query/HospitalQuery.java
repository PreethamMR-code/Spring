package com.xworkz.data.query;


import com.xworkz.data.constants.DBConstant;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class HospitalQuery {

    public static void main(String[] args) {


        try(Connection connection = DriverManager.getConnection(
                DBConstant.URL,
                DBConstant.USERNAME,
                DBConstant.PASSWORD);

            Statement statement=connection.createStatement()){

            System.out.println("=== all rows ===");
            String sqlAll = "select * from hospital";
            ResultSet rsAll = statement.executeQuery(sqlAll);

            while (rsAll.next()) {
                String id=rsAll.getString("hospital_id");
                String name=rsAll.getString("hospital_name");

                System.out.println("id:"+id + "name:"+name);

//==================================================================

                System.out.println("=== one row ===");
                String sqlOne = "select * from hospital where hospital_id = 1";
                ResultSet rsOne = statement.executeQuery(sqlOne);
                while (rsOne.next()) {
                    System.out.println("id: " + rsOne.getString("hospital_id")
                            + " name: " + rsOne.getString("hospital_name"));

//                    ===============================================================

                    System.out.println("=== one row, one column ===");
                    String sqlOneCol = "select name from hospital where hospital_id = 1";
                    ResultSet rsOneCol = statement.executeQuery(sqlOneCol);
                    while (rsOneCol.next()) {
                        System.out.println("name: " + rsOneCol.getString("hospital_name"));
                    }

//                    ==========================================================


                    System.out.println("=== two rows ===");
                    String sqlTwo = "select * from hospital limit 2";
                    ResultSet rsTwo = statement.executeQuery(sqlTwo);
                    while (rsTwo.next()) {
                        System.out.println("id: " + rsTwo.getString("hospital_id")
                                + " name: " + rsTwo.getString("hospital_name"));
                    }

//                    =========================================================

                    System.out.println("=== three rows ===");
                    String sqlThree = "select * from hospital limit 3";
                    ResultSet rsThree = statement.executeQuery(sqlThree);
                    while (rsThree.next()) {
                        System.out.println("id: " + rsThree.getString("hospital_id")
                                + " name: " + rsThree.getString("hospital_name"));
                    }
//                    =============================================================


                    System.out.println("=== one column, all rows ===");
                    String sqlOneColumnAll = "select name from hospital";
                    ResultSet rsOneColumnAll = statement.executeQuery(sqlOneColumnAll);
                    while (rsOneColumnAll.next()) {
                        System.out.println("name: " + rsOneColumnAll.getString("hospital_name"));
                    }

//                 ========================================================

                    System.out.println("=== distinct city ===");
                    String sqlDistinct = "select location city from hospital";
                    ResultSet rsDistinct = statement.executeQuery(sqlDistinct);
                    while (rsDistinct.next()) {
                        System.out.println("city: " + rsDistinct.getString("location"));
                    }

//                    ============================================================

                    System.out.println("=== count(*) ===");
                    String sqlCount = "select count(*) as total from hospital";
                    ResultSet rsCount = statement.executeQuery(sqlCount);
                    while (rsCount.next()) {
                        System.out.println("total rows: " + rsCount.getInt("total"));
                    }

//                    ========================================================

                    System.out.println("===  latest row (max id) ===");
                    String sqlLatest = "select * from hospital order by id desc limit 1";
                    ResultSet rsLatest = statement.executeQuery(sqlLatest);
                    while (rsLatest.next()) {
                        System.out.println("id: " + rsLatest.getString("hospital_id")
                                + " name: " + rsLatest.getString("hospital_name"));
                    }

//                 =======================================================

                    System.out.println("===  top 2 by rating ===");
                    String sqlTop2 = "select * from hospital order by rating desc limit 2";
                    ResultSet rsTop2 = statement.executeQuery(sqlTop2);
                    while (rsTop2.next()) {
                        System.out.println("id: " + rsTop2.getString("hospital_id")
                                + " name: " + rsTop2.getString("hospital_name")
                                + " rating: " + rsTop2.getDouble("rating"));
                    }

//                    =======================================================

                    System.out.println("=== bottom 5 by rating ===");
                    String sqlBottom5 = "select * from hospital order by rating asc limit 5";
                    ResultSet rsBottom5 = statement.executeQuery(sqlBottom5);
                    while (rsBottom5.next()) {
                        System.out.println("id: " + rsBottom5.getString("hospital_id")
                                + " name: " + rsBottom5.getString("hospital_name")
                                + " rating: " + rsBottom5.getDouble("rating"));
                    }

//                   ======================================================

                    System.out.println("===  oldest hospital ===");
                    String sqlOldest = "select * from hospital order by established_year asc limit 1";
                    ResultSet rsOldest = statement.executeQuery(sqlOldest);
                    while (rsOldest.next()) {
                        System.out.println("id: " + rsOldest.getString("hospital_id")
                                + " name: " + rsOldest.getString("hospital_name")
                                + " year: " + rsOldest.getInt("established_year"));
                    }

//                   =========================================================

                    System.out.println("=== all rows order by id desc ===");
                    String sqlOrderDesc = "select * from hospital order by id desc";
                    ResultSet rsOrderDesc = statement.executeQuery(sqlOrderDesc);
                    while (rsOrderDesc.next()) {
                        System.out.println("id: " + rsOrderDesc.getString("hospital_id")
                                + " name: " + rsOrderDesc.getString("hospital_name"));
                    }

//                    ================================================

                    System.out.println("=== group by city ===");
                    String sqlGroup = "select city, count(*) as total from hospital group by city";
                    ResultSet rsGroup = statement.executeQuery(sqlGroup);
                    while (rsGroup.next()) {
                        System.out.println("city: " + rsGroup.getString("city")
                                + " total: " + rsGroup.getInt("total"));
                    }

//                    ==========================================================

                    System.out.println("=== group by city having count > 3 ===");
                    String sqlGroupHaving =
                            "select location, count(*) as total from hospital group by city having count(*) > 3";
                    ResultSet rsGroupHaving = statement.executeQuery(sqlGroupHaving);
                    while (rsGroupHaving.next()) {
                        System.out.println("city: " + rsGroupHaving.getString("location")
                                + " total: " + rsGroupHaving.getInt("total"));
                    }


                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

    }
}
