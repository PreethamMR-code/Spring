package com.xworkz.data.query;

import com.xworkz.data.constants.DBConstant;
import com.xworkz.data.contant.SweetEnum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class PresidentQuery {

    public static void main(String[] args) {


        try(Connection connection = DriverManager.getConnection(
                SweetEnum.URl.getS(),
                SweetEnum.USERNAME.getS(),
                SweetEnum.PASSWORD.getS());

                 Statement statement = connection.createStatement()){

            System.out.println("=== 1. all rows ===");
            String sqlAll = "SELECT * FROM president";
            ResultSet rsAll = statement.executeQuery(sqlAll);
            while (rsAll.next()) {
                System.out.println(
                        "id: " + rsAll.getInt("president_id") +
                                " name: " + rsAll.getString("name") +
                                " country: " + rsAll.getString("country"));
            }


            System.out.println("=== one row (id = 1) ===");
            String sqlOne = "SELECT * FROM president WHERE president_id = 1";
            ResultSet rsOne = statement.executeQuery(sqlOne);
            while (rsOne.next()) {
                System.out.println(
                        "id: " + rsOne.getInt("president_id") +
                                " name: " + rsOne.getString("name"));
            }


            System.out.println("=== one row, one column ===");
            String sqlOneCol = "SELECT name FROM president WHERE president_id = 1";
            ResultSet rsOneCol = statement.executeQuery(sqlOneCol);
            while (rsOneCol.next()) {
                System.out.println("name: " + rsOneCol.getString("name"));
            }


            System.out.println("=== two rows ===");
            String sqlTwo = "SELECT * FROM president LIMIT 2";
            ResultSet rsTwo = statement.executeQuery(sqlTwo);
            while (rsTwo.next()) {
                System.out.println(
                        "id: " + rsTwo.getInt("president_id") +
                                " name: " + rsTwo.getString("name"));
            }


            System.out.println("=== three rows ===");
            String sqlThree = "SELECT * FROM president LIMIT 3";
            ResultSet rsThree = statement.executeQuery(sqlThree);
            while (rsThree.next()) {
                System.out.println(
                        "id: " + rsThree.getInt("president_id") +
                                " name: " + rsThree.getString("name"));
            }


            System.out.println("=== one column, all rows (name) ===");
            String sqlOneColumnAll = "SELECT name FROM president";
            ResultSet rsOneColumnAll = statement.executeQuery(sqlOneColumnAll);
            while (rsOneColumnAll.next()) {
                System.out.println("name: " + rsOneColumnAll.getString("name"));
            }


            System.out.println("=== distinct country ===");
            String sqlDistinct = "SELECT DISTINCT country FROM president";
            ResultSet rsDistinct = statement.executeQuery(sqlDistinct);
            while (rsDistinct.next()) {
                System.out.println("country: " + rsDistinct.getString("country"));
            }


            System.out.println("=== count(*) ===");
            String sqlCount = "SELECT COUNT(*) AS total FROM president";
            ResultSet rsCount = statement.executeQuery(sqlCount);
            while (rsCount.next()) {
                System.out.println("total presidents: " + rsCount.getInt("total"));
            }


            System.out.println("=== latest row ===");
            String sqlLatest = "SELECT * FROM president ORDER BY president_id DESC LIMIT 1";
            ResultSet rsLatest = statement.executeQuery(sqlLatest);
            while (rsLatest.next()) {
                System.out.println(
                        "id: " + rsLatest.getInt("president_id") +
                                " name: " + rsLatest.getString("name"));
            }


            System.out.println("=== top 2 by start_year ===");
            String sqlTop2 = "SELECT * FROM president ORDER BY start_year DESC LIMIT 2";
            ResultSet rsTop2 = statement.executeQuery(sqlTop2);
            while (rsTop2.next()) {
                System.out.println(
                        "id: " + rsTop2.getInt("president_id") +
                                " name: " + rsTop2.getString("name") +
                                " start_year: " + rsTop2.getInt("start_year"));
            }


            System.out.println("=== earliest 5 by start_year ===");
            String sqlBottom5 = "SELECT * FROM president ORDER BY start_year ASC LIMIT 5";
            ResultSet rsBottom5 = statement.executeQuery(sqlBottom5);
            while (rsBottom5.next()) {
                System.out.println(
                        "id: " + rsBottom5.getInt("president_id") +
                                " name: " + rsBottom5.getString("name") +
                                " start_year: " + rsBottom5.getInt("start_year"));
            }


            System.out.println("=== oldest president by start_year ===");
            String sqlOldest = "SELECT * FROM president ORDER BY start_year ASC LIMIT 1";
            ResultSet rsOldest = statement.executeQuery(sqlOldest);
            while (rsOldest.next()) {
                System.out.println(
                        "id: " + rsOldest.getInt("president_id") +
                                " name: " + rsOldest.getString("name") +
                                " start_year: " + rsOldest.getInt("start_year"));
            }


            System.out.println("=== all rows order by id desc ===");
            String sqlOrderDesc = "SELECT * FROM president ORDER BY president_id DESC";
            ResultSet rsOrderDesc = statement.executeQuery(sqlOrderDesc);
            while (rsOrderDesc.next()) {
                System.out.println(
                        "id: " + rsOrderDesc.getInt("president_id") +
                                " name: " + rsOrderDesc.getString("name"));
            }


            System.out.println("=== group by country ===");
            String sqlGroup = "SELECT country, COUNT(*) AS total FROM president GROUP BY country";
            ResultSet rsGroup = statement.executeQuery(sqlGroup);
            while (rsGroup.next()) {
                System.out.println(
                        "country: " + rsGroup.getString("country") +
                                " total: " + rsGroup.getInt("total"));
            }


            System.out.println("=== group by country having count > 2 ===");
            String sqlGroupHaving =
                    "SELECT country, COUNT(*) AS total FROM president " +
                            "GROUP BY country HAVING COUNT(*) > 2";
            ResultSet rsGroupHaving = statement.executeQuery(sqlGroupHaving);
            while (rsGroupHaving.next()) {
                System.out.println(
                        "country: " + rsGroupHaving.getString("country") +
                                " total: " + rsGroupHaving.getInt("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

