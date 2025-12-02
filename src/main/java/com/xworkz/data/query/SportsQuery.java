package com.xworkz.data.query;

import com.xworkz.data.constants.DBConstant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SportsQuery {

    public static void main(String[] args) {

        try(Connection connection = DriverManager.getConnection(DBConstant.URL,DBConstant.USERNAME,DBConstant.PASSWORD);

            Statement statement = connection.createStatement()){

            System.out.println("all rows ");
            String sqlAll = "Select * from sports";
            ResultSet rsall = statement.executeQuery(sqlAll);
            while (rsall.next()){
                System.out.println(
                        "id:" +rsall.getInt("sport_id")+
                                "name:" +rsall.getString("sport_name") +
                                "category:" + rsall.getString("category") +
                                "origin_country:" + rsall.getString("origin_country"));
            }

            System.out.println("one row sport id");
            String sqlOne = "select * from sports where sport_id=1";

            ResultSet rsOne= statement.executeQuery(sqlOne);
            while(rsOne.next()){
                System.out.println("id:"+rsOne.getInt("sport_id")+ "name:"+rsOne.getString("sport_name"));
            }

            System.out.println("one row and one column");
            String sqlCol = "select Sport_name from sports where sport_id=1";
            ResultSet rsCol = statement.executeQuery(sqlCol);

            while(rsCol.next()){
                System.out.println("name:"+rsCol.getString("sport_name"));
            }

            System.out.println("three rows");
            String sqlTwo = "select * from sports limit 2";
            ResultSet rsTwo = statement.executeQuery(sqlTwo);

            while(rsTwo.next()){
                System.out.println("id:"+ rsTwo.getInt("sport_id")+ "name:"+rsTwo.getString("sport_name"));
            }

            System.out.println("three rows");
            String sqlThree = "select * from sports limit 3";
            ResultSet rsThree = statement.executeQuery(sqlThree);

            while(rsThree.next()){
                System.out.println("id:"+rsThree.getInt("sport_id")+"name:"+rsThree.getString("sport_name"));
            }

            System.out.println("one column all rows sports_name");
            String sqlColAll = "select sport_name from sports";
            ResultSet rsColAll = statement.executeQuery(sqlColAll);
            while(rsColAll.next()){
                System.out.println("name:"+rsColAll.getString("sport_name"));
            }

            System.out.println("distinct category");
            String sqlDistinct = "select distinct origin_country from sports";
            ResultSet rsDistinct = statement.executeQuery(sqlDistinct);

            while(rsDistinct.next()){
                System.out.println("origin country:"+rsDistinct.getString("origin_country"));
            }

            System.out.println("count");
            String sqlCount = "SELECT COUNT(*) AS total FROM sports";
            ResultSet rsCount = statement.executeQuery(sqlCount);
            while (rsCount.next()) {
                System.out.println("total sports: " + rsCount.getInt("total"));
            }

            System.out.println("latest row max sport id");
            String sqlLatest = "SELECT * FROM sports ORDER BY sport_id DESC LIMIT 1";
            ResultSet rsLatest = statement.executeQuery(sqlLatest);
            while (rsLatest.next()) {
                System.out.println(
                        "id: " + rsLatest.getInt("sport_id") +
                                " name: " + rsLatest.getString("sport_name"));
            }

            System.out.println("top 3 by players count");
            String sqlTopPlayers = "SELECT * FROM sports ORDER BY players_count DESC LIMIT 3";
            ResultSet rsTopPlayers = statement.executeQuery(sqlTopPlayers);
            while (rsTopPlayers.next()) {
                System.out.println(
                        "id: " + rsTopPlayers.getInt("sport_id") +
                                " name: " + rsTopPlayers.getString("sport_name") +
                                " players_count: " + rsTopPlayers.getInt("players_count"));
            }

            System.out.println("top 5 by popularity_rank (1 is most popular)");
            String sqlTopPopular = "SELECT * FROM sports ORDER BY popularity_rank ASC LIMIT 5";
            ResultSet rsTopPopular = statement.executeQuery(sqlTopPopular);
            while (rsTopPopular.next()) {
                System.out.println(
                        "id: " + rsTopPopular.getInt("sport_id") +
                                " name: " + rsTopPopular.getString("sport_name") +
                                " rank: " + rsTopPopular.getInt("popularity_rank"));
            }

            System.out.println("all rows order by sport_id desc");
            String sqlOrderDesc = "SELECT * FROM sports ORDER BY sport_id DESC";
            ResultSet rsOrderDesc = statement.executeQuery(sqlOrderDesc);
            while (rsOrderDesc.next()) {
                System.out.println(
                        "id: " + rsOrderDesc.getInt("sport_id") +
                                " name: " + rsOrderDesc.getString("sport_name"));
            }

            System.out.println(" group by category");
            String sqlGroupCategory =
                    "SELECT category, COUNT(*) AS total FROM sports GROUP BY category";
            ResultSet rsGroupCategory = statement.executeQuery(sqlGroupCategory);
            while (rsGroupCategory.next()) {
                System.out.println(
                        "category: " + rsGroupCategory.getString("category") +
                                " total: " + rsGroupCategory.getInt("total"));
            }

            System.out.println("group by origin_country ");
            String sqlGroupCountry =
                    "SELECT origin_country, COUNT(*) AS total FROM sports GROUP BY origin_country";
            ResultSet rsGroupCountry = statement.executeQuery(sqlGroupCountry);
            while (rsGroupCountry.next()) {
                System.out.println(
                        "origin_country: " + rsGroupCountry.getString("origin_country") +
                                " total: " + rsGroupCountry.getInt("total"));
            }

            System.out.println(" group by indoor_outdoor");
            String sqlGroupIndoorOutdoor =
                    "SELECT indoor_outdoor, COUNT(*) AS total FROM sports GROUP BY indoor_outdoor";
            ResultSet rsGroupIndoorOutdoor = statement.executeQuery(sqlGroupIndoorOutdoor);
            while (rsGroupIndoorOutdoor.next()) {
                System.out.println(
                        "type: " + rsGroupIndoorOutdoor.getString("indoor_outdoor") +
                                " total: " + rsGroupIndoorOutdoor.getInt("total"));
            }

            System.out.println("=== Olympic sports only ===");
            String sqlOlympic =
                    "SELECT * FROM sports WHERE olympic_game = 'YES'";
            ResultSet rsOlympic = statement.executeQuery(sqlOlympic);
            while (rsOlympic.next()) {
                System.out.println(
                        "id: " + rsOlympic.getInt("sport_id") +
                                " name: " + rsOlympic.getString("sport_name") +
                                " olympic_game: " + rsOlympic.getString("olympic_game"));
            }


        }catch (Exception e){
            e.printStackTrace();
        }

    }


}
