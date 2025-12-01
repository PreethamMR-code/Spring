package com.xworkz.data.query;

import com.xworkz.data.constants.DBConstant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class PresidentQuery {

    public static void main(String[] args) {

        try(Connection connection =
                    DriverManager.getConnection(DBConstant.URL,
                            DBConstant.USERNAME,
                            DBConstant.PASSWORD);

        Statement statement = connection.createStatement()){

            System.out.println("=== 1. all rows ===");
            String sqlAll = "select * from president";
            ResultSet rsAll = statement.executeQuery(sqlAll);
            while (rsAll.next()) {
                System.out.println(
                        "id: " + rsAll.getInt("id") +
                                " name: " + rsAll.getString("name") +
                                " country: " + rsAll.getString("country"));
            }

//======================================================
            System.out.println("=== one row (id = 1) ===");
            String sqlOne = "select * from president where id = 1";
            ResultSet rsOne = statement.executeQuery(sqlOne);
            while (rsOne.next()) {
                System.out.println(
                        "id: " + rsOne.getInt("id") +
                                " name: " + rsOne.getString("name"));
            }

//=======================================
            System.out.println("=== one row, one column ===");
            String sqlOneCol = "select name from president where id = 1";
            ResultSet rsOneCol = statement.executeQuery(sqlOneCol);
            while (rsOneCol.next()) {
                System.out.println("name: " + rsOneCol.getString("name"));
            }

//=====================================================
            System.out.println("=== two rows ===");
            String sqlTwo = "select * from president limit 2";
            ResultSet rsTwo = statement.executeQuery(sqlTwo);
            while (rsTwo.next()) {
                System.out.println(
                        "id: " + rsTwo.getInt("id") +
                                " name: " + rsTwo.getString("name"));
            }

//===========================================================
            System.out.println("===three rows ===");
            String sqlThree = "select * from president limit 3";
            ResultSet rsThree = statement.executeQuery(sqlThree);
            while (rsThree.next()) {
                System.out.println(
                        "id: " + rsThree.getInt("id") +
                                " name: " + rsThree.getString("name"));
            }

//=========================================================

            System.out.println("=== one column, all rows (name) ===");
            String sqlOneColumnAll = "select name from president";
            ResultSet rsOneColumnAll = statement.executeQuery(sqlOneColumnAll);
            while (rsOneColumnAll.next()) {
                System.out.println("name: " + rsOneColumnAll.getString("name"));
            }

//==============================================================

            System.out.println("=== distinct country ===");
            String sqlDistinct = "select distinct country from president";
            ResultSet rsDistinct = statement.executeQuery(sqlDistinct);
            while (rsDistinct.next()) {
                System.out.println("country: " + rsDistinct.getString("country"));
            }

//            =================================================================


            System.out.println("=== count(*) ===");
            String sqlCount = "select count(*) as total from president";
            ResultSet rsCount = statement.executeQuery(sqlCount);
            while (rsCount.next()) {
                System.out.println("total presidents: " + rsCount.getInt("total"));
            }

//===================================================

            System.out.println("=== latest row ===");
            String sqlLatest = "select * from president order by id desc limit 1";
            ResultSet rsLatest = statement.executeQuery(sqlLatest);
            while (rsLatest.next()) {
                System.out.println(
                        "id: " + rsLatest.getInt("id") +
                                " name: " + rsLatest.getString("name"));
            }

//==============================================================

            System.out.println("=== top 2 by start_year ===");
            String sqlTop2 = "select * from president order by start_year desc limit 2";
            ResultSet rsTop2 = statement.executeQuery(sqlTop2);
            while (rsTop2.next()) {
                System.out.println(
                        "id: " + rsTop2.getInt("id") +
                                " name: " + rsTop2.getString("name") +
                                " start_year: " + rsTop2.getInt("start_year"));
            }

//==========================================================

            System.out.println("=== earliest 5 by start_year ===");
            String sqlBottom5 = "select * from president order by start_year asc limit 5";
            ResultSet rsBottom5 = statement.executeQuery(sqlBottom5);
            while (rsBottom5.next()) {
                System.out.println(
                        "id: " + rsBottom5.getInt("id") +
                                " name: " + rsBottom5.getString("name") +
                                " start_year: " + rsBottom5.getInt("start_year"));
            }

//            ===============================================================

            System.out.println("=== oldest president by start_year ===");
            String sqlOldest = "select * from president order by start_year asc limit 1";
            ResultSet rsOldest = statement.executeQuery(sqlOldest);
            while (rsOldest.next()) {
                System.out.println(
                        "id: " + rsOldest.getInt("id") +
                                " name: " + rsOldest.getString("name") +
                                " start_year: " + rsOldest.getInt("start_year"));
            }

//=====================================================

            System.out.println("===  all rows order by id desc ===");
            String sqlOrderDesc = "select * from president order by id desc";
            ResultSet rsOrderDesc = statement.executeQuery(sqlOrderDesc);
            while (rsOrderDesc.next()) {
                System.out.println(
                        "id: " + rsOrderDesc.getInt("id") +
                                " name: " + rsOrderDesc.getString("name"));
            }

//==================================================
            System.out.println("=== group by country ===");
            String sqlGroup = "select country, count(*) as total from president group by country";
            ResultSet rsGroup = statement.executeQuery(sqlGroup);
            while (rsGroup.next()) {
                System.out.println(
                        "country: " + rsGroup.getString("country") +
                                " total: " + rsGroup.getInt("total"));
            }

//============================================================

            System.out.println("===group by country having count > 2 ===");
            String sqlGroupHaving =
                    "select country, count(*) as total from president " +
                            "group by country having count(*) > 2";
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

