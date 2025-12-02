package com.xworkz.data.query;

import com.xworkz.data.constants.DBConstant;
import com.xworkz.data.contant.SweetEnum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class StreetQuery {

    public static void main(String[] args) {

      try(Connection connection = DriverManager.getConnection(
              SweetEnum.URl.getS(),
              SweetEnum.USERNAME.getS(),
              SweetEnum.PASSWORD.getS());

            Statement statement =connection.createStatement()){

            System.out.println("all rows");
            String sqlAll = "select * from street";
            ResultSet rsAll = statement.executeQuery(sqlAll);
            while(rsAll.next()){
                System.out.println("id:"+rsAll.getInt("street_id")+
                        "name:"+rsAll.getString("stree_name")+
                        "city:"+rsAll.getString("city")+
                        "state:"+rsAll.getString("state"));
            }

            System.out.println("one row (street_id = 1)");
            String sqlOne = "select * from street where street_id = 1";
            ResultSet rsOne = statement.executeQuery(sqlOne);
            while (rsOne.next()) {
                System.out.println(
                        "id: " + rsOne.getInt("street_id") +
                                " name: " + rsOne.getString("stree_name"));
            }

            System.out.println(" one row, one column ");
            String sqlOneCol = "select stree_name from street where street_id = 1";
            ResultSet rsOneCol = statement.executeQuery(sqlOneCol);
            while (rsOneCol.next()) {
                System.out.println("name: " + rsOneCol.getString("stree_name"));
            }

            System.out.println(" two rows ");
            String sqlTwo = "select * from street limit 2";
            ResultSet rsTwo = statement.executeQuery(sqlTwo);
            while (rsTwo.next()) {
                System.out.println(
                        "id: " + rsTwo.getInt("street_id") +
                                " name: " + rsTwo.getString("stree_name"));
            }

            System.out.println(" three rows ");
            String sqlThree = "select * from street limit 3";
            ResultSet rsThree = statement.executeQuery(sqlThree);
            while (rsThree.next()) {
                System.out.println(
                        "id: " + rsThree.getInt("street_id") +
                                " name: " + rsThree.getString("stree_name"));
            }

            System.out.println(" one column, all rows (street_name) ");
            String sqlOneColumnAll = "select stree_name from street";
            ResultSet rsOneColumnAll = statement.executeQuery(sqlOneColumnAll);
            while (rsOneColumnAll.next()) {
                System.out.println("name: " + rsOneColumnAll.getString("stree_name"));
            }

            System.out.println(" distinct city ");
            String sqlDistinctCity = "select distinct city from street";
            ResultSet rsDistinctCity = statement.executeQuery(sqlDistinctCity);
            while (rsDistinctCity.next()) {
                System.out.println("city: " + rsDistinctCity.getString("city"));
            }

            System.out.println(" distinct state ");
            String sqlDistinctState = "select distinct state from street";
            ResultSet rsDistinctState = statement.executeQuery(sqlDistinctState);
            while (rsDistinctState.next()) {
                System.out.println("state: " + rsDistinctState.getString("state"));
            }

            System.out.println(" count(*) ");
            String sqlCount = "select count(*) as total from street";
            ResultSet rsCount = statement.executeQuery(sqlCount);
            while (rsCount.next()) {
                System.out.println("total streets: " + rsCount.getInt("total"));
            }

            System.out.println(" latest row (max street_id) ");
            String sqlLatest = "select * from street order by street_id desc limit 1";
            ResultSet rsLatest = statement.executeQuery(sqlLatest);
            while (rsLatest.next()) {
                System.out.println(
                        "id: " + rsLatest.getInt("street_id") +
                                " name: " + rsLatest.getString("stree_name"));
            }

            System.out.println(" top 3 by length_km ");
            String sqlTopLength = "select * from street order by length_km desc limit 3";
            ResultSet rsTopLength = statement.executeQuery(sqlTopLength);
            while (rsTopLength.next()) {
                System.out.println(
                        "id: " + rsTopLength.getInt("street_id") +
                                " name: " + rsTopLength.getString("stree_name") +
                                " length_km: " + rsTopLength.getDouble("length_km"));
            }

            System.out.println(" top 3 by width_m ");
            String sqlTopWidth = "select * from street order by width_m desc limit 3";
            ResultSet rsTopWidth = statement.executeQuery(sqlTopWidth);
            while (rsTopWidth.next()) {
                System.out.println(
                        "id: " + rsTopWidth.getInt("street_id") +
                                " name: " + rsTopWidth.getString("stree_name") +
                                " width_m: " + rsTopWidth.getDouble("width_m"));
            }

            System.out.println(" top 5 by shops_count ");
            String sqlTopShops = "select * from street order by shops_count desc limit 5";
            ResultSet rsTopShops = statement.executeQuery(sqlTopShops);
            while (rsTopShops.next()) {
                System.out.println(
                        "id: " + rsTopShops.getInt("street_id") +
                                " name: " + rsTopShops.getString("stree_name") +
                                " shops_count: " + rsTopShops.getInt("shops_count"));
            }

            System.out.println(" top 5 by houses_count ");
            String sqlTopHouses = "select * from street order by houses_count desc limit 5";
            ResultSet rsTopHouses = statement.executeQuery(sqlTopHouses);
            while (rsTopHouses.next()) {
                System.out.println(
                        "id: " + rsTopHouses.getInt("street_id") +
                                " name: " + rsTopHouses.getString("stree_name") +
                                " houses_count: " + rsTopHouses.getInt("houses_count"));
            }

            System.out.println(" best cleanliness_rating (highest first) ");
            String sqlClean = "select * from street order by cleanliness_rating desc limit 5";
            ResultSet rsClean = statement.executeQuery(sqlClean);
            while (rsClean.next()) {
                System.out.println(
                        "id: " + rsClean.getInt("street_id") +
                                " name: " + rsClean.getString("stree_name") +
                                " rating: " + rsClean.getDouble("cleanliness_rating"));
            }

            System.out.println(" highest maintenance_cost ");
            String sqlHighCost = "select * from street order by maintenance_cost desc limit 3";
            ResultSet rsHighCost = statement.executeQuery(sqlHighCost);
            while (rsHighCost.next()) {
                System.out.println(
                        "id: " + rsHighCost.getInt("street_id") +
                                " name: " + rsHighCost.getString("stree_name") +
                                " cost: " + rsHighCost.getDouble("maintenance_cost"));
            }

            System.out.println(" all rows order by street_id desc ");
            String sqlOrderDesc = "select * from street order by street_id desc";
            ResultSet rsOrderDesc = statement.executeQuery(sqlOrderDesc);
            while (rsOrderDesc.next()) {
                System.out.println(
                        "id: " + rsOrderDesc.getInt("street_id") +
                                " name: " + rsOrderDesc.getString("stree_name"));
            }

            System.out.println(" group by city ");
            String sqlGroupCity = "select city, count(*) as total from street group by city";
            ResultSet rsGroupCity = statement.executeQuery(sqlGroupCity);
            while (rsGroupCity.next()) {
                System.out.println(
                        "city: " + rsGroupCity.getString("city") +
                                " total: " + rsGroupCity.getInt("total"));
            }

            System.out.println("group by street_type ");
            String sqlGroupType = "select street_type, count(*) as total from street group by street_type";
            ResultSet rsGroupType = statement.executeQuery(sqlGroupType);
            while (rsGroupType.next()) {
                System.out.println(
                        "street_type: " + rsGroupType.getString("street_type") +
                                " total: " + rsGroupType.getInt("total"));
            }

            System.out.println("group by traffic_level ");
            String sqlGroupTraffic = "select traffic_level, count(*) as total from street group by traffic_level";
            ResultSet rsGroupTraffic = statement.executeQuery(sqlGroupTraffic);
            while (rsGroupTraffic.next()) {
                System.out.println(
                        "traffic_level: " + rsGroupTraffic.getString("traffic_level") +
                                " total: " + rsGroupTraffic.getInt("total"));
            }

            System.out.println("group by city having streets > 3");
            String sqlGroupHaving =
                    "select city, count(*) as total from street group by city having count(*) > 3";
            ResultSet rsGroupHaving = statement.executeQuery(sqlGroupHaving);
            while (rsGroupHaving.next()) {
                System.out.println(
                        "city: " + rsGroupHaving.getString("city") +
                                " total: " + rsGroupHaving.getInt("total"));
            }



        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
