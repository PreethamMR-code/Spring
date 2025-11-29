package com.xworkz.data.sweets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Sweet {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";


        try{
        Connection connection =DriverManager.getConnection(url,username,password);
        System.out.println("Connection"+connection);

        System.out.println("Connected Successfully ✓");
        Statement statement = connection.createStatement();

      //  String sql="INSERT INTO sweet VALUES (1,'Kaju Katli',220,250,'Sri Sweets','Cashew','2025-01-01')";

            statement.addBatch("INSERT INTO sweet VALUES (1,'Kaju Katli',220,250,'Sri Sweets','Cashew','2025-01-01')");
            statement.addBatch("INSERT INTO sweet VALUES (2,'Rasgulla',150,500,'Bengali House','Milk','2025-01-02')");
            statement.addBatch("INSERT INTO sweet VALUES (3,'Gulab Jamun',180,450,'Mithai Mahal','Milk','2025-01-03')");
            statement.addBatch("INSERT INTO sweet VALUES (4,'Mysore Pak',200,300,'Sri Sweets','Ghee','2025-01-04')");
            statement.addBatch("INSERT INTO sweet VALUES (5,'Laddu',120,400,'Anand Sweets','Gram Flour','2025-01-05')");
            statement.addBatch("INSERT INTO sweet VALUES (6,'Jalebi',100,350,'com.xworkz.data.sweets.Sweet Palace','Sugar','2025-01-06')");
            statement.addBatch("INSERT INTO sweet VALUES (7,'Barfi',160,200,'Mithai Stop','Milk','2025-01-07')");
            statement.addBatch("INSERT INTO sweet VALUES (8,'Dry Fruit Barfi',300,250,'Royal com.xworkz.data.sweets.Sweet House','Dry Fruit','2025-01-08')");
            statement.addBatch("INSERT INTO sweet VALUES (9,'Peda',140,300,'Gowri Sweets','Milk','2025-01-09')");
            statement.addBatch("INSERT INTO sweet VALUES (10,'Badam Halwa',270,350,'Sri Sweets','Almond','2025-01-10')");
            statement.addBatch("INSERT INTO sweet VALUES (11,'Soan Papdi',130,500,'com.xworkz.data.sweets.Sweet Mall','Gram Flour','2025-01-11')");
            statement.addBatch("INSERT INTO sweet VALUES (12,'Kheer Kadam',180,350,'Bengali House','Milk','2025-01-12')");
            statement.addBatch("INSERT INTO sweet VALUES (13,'Cham Cham',170,300,'Bengali House','Milk','2025-01-13')");
            statement.addBatch("INSERT INTO sweet VALUES (14,'Motichoor Laddu',200,350,'Mithai Mahal','Gram Flour','2025-01-14')");
            statement.addBatch("INSERT INTO sweet VALUES (15,'Malai Barfi',220,300,'com.xworkz.data.sweets.Sweet Palace','Milk','2025-01-15')");
            statement.addBatch("INSERT INTO sweet VALUES (16,'Basundi',210,450,'Sri Sweets','Milk','2025-01-16')");
            statement.addBatch("INSERT INTO sweet VALUES (17,'Kesar Peda',240,350,'Anand Sweets','Saffron','2025-01-17')");
            statement.addBatch("INSERT INTO sweet VALUES (18,'Coconut Laddu',150,300,'Mithai Stop','Coconut','2025-01-18')");
            statement.addBatch("INSERT INTO sweet VALUES (19,'Chocolate Barfi',260,250,'Royal com.xworkz.data.sweets.Sweet House','Chocolate','2025-01-19')");
            statement.addBatch("INSERT INTO sweet VALUES (20,'Milk Cake',190,300,'com.xworkz.data.sweets.Sweet Palace','Milk','2025-01-20')");
            statement.addBatch("INSERT INTO sweet VALUES (21,'Paneer Jalebi',210,350,'Bengali House','Milk','2025-01-21')");
            statement.addBatch("INSERT INTO sweet VALUES (22,'Rabri',250,450,'Anand Sweets','Milk','2025-01-22')");
            statement.addBatch("INSERT INTO sweet VALUES (23,'Kalakand',230,300,'Gowri Sweets','Milk','2025-01-23')");
            statement.addBatch("INSERT INTO sweet VALUES (24,'Malpua',180,280,'com.xworkz.data.sweets.Sweet Mall','Sugar','2025-01-24')");
            statement.addBatch("INSERT INTO sweet VALUES (25,'Sandal Halwa',300,250,'Royal com.xworkz.data.sweets.Sweet House','Dry Fruit','2025-01-25')");
            statement.addBatch("INSERT INTO sweet VALUES (26,'Pista Roll',320,240,'Anand Sweets','Pista','2025-01-26')");
            statement.addBatch("INSERT INTO sweet VALUES (27,'Dry Fruit Laddu',350,350,'Sri Sweets','Dry Fruit','2025-01-27')");
            statement.addBatch("INSERT INTO sweet VALUES (28,'Rose Peda',210,300,'Mithai Stop','Rose','2025-01-28')");
            statement.addBatch("INSERT INTO sweet VALUES (29,'Kesari Bath',100,250,'Gowri Sweets','Semolina','2025-01-29')");
            statement.addBatch("INSERT INTO sweet VALUES (30,'Choco Laddu',180,250,'Anand Sweets','Chocolate','2025-01-30')");
            statement.addBatch("INSERT INTO sweet VALUES (31,'Fruit Halwa',260,350,'com.xworkz.data.sweets.Sweet Palace','Fruit Mix','2025-01-31')");
            statement.addBatch("INSERT INTO sweet VALUES (32,'Mango Barfi',240,250,'Mithai Mahal','Mango','2025-02-01')");
            statement.addBatch("INSERT INTO sweet VALUES (33,'Banana Halwa',200,300,'Sri Sweets','Banana','2025-02-02')");
            statement.addBatch("INSERT INTO sweet VALUES (34,'Apple Barfi',210,260,'com.xworkz.data.sweets.Sweet Stop','Apple','2025-02-03')");
            statement.addBatch("INSERT INTO sweet VALUES (35,'Kaju Roll',350,250,'Royal com.xworkz.data.sweets.Sweet House','Cashew','2025-02-04')");
            statement.addBatch("INSERT INTO sweet VALUES (36,'Fig Barfi',300,240,'Anand Sweets','Fig','2025-02-05')");
            statement.addBatch("INSERT INTO sweet VALUES (37,'Badusha',160,350,'com.xworkz.data.sweets.Sweet Palace','Sugar','2025-02-06')");
            statement.addBatch("INSERT INTO sweet VALUES (38,'Kesari Laddu',200,300,'Mithai Mahal','Saffron','2025-02-07')");
            statement.addBatch("INSERT INTO sweet VALUES (39,'Cashew Halwa',350,250,'Sri Sweets','Cashew','2025-02-08')");
            statement.addBatch("INSERT INTO sweet VALUES (40,'Pineapple Barfi',230,250,'Gowri Sweets','Pineapple','2025-02-09')");
            statement.addBatch("INSERT INTO sweet VALUES (41,'Dry Fruit Halwa',320,300,'Royal com.xworkz.data.sweets.Sweet House','Dry Fruit','2025-02-10')");
            statement.addBatch("INSERT INTO sweet VALUES (42,'Milk Mysore Pak',210,250,'Mithai Stop','Milk','2025-02-11')");
            statement.addBatch("INSERT INTO sweet VALUES (43,'Carrot Halwa',220,300,'com.xworkz.data.sweets.Sweet Mall','Carrot','2025-02-12')");
            statement.addBatch("INSERT INTO sweet VALUES (44,'Honey Barfi',260,250,'com.xworkz.data.sweets.Sweet Stop','Honey','2025-02-13')");
            statement.addBatch("INSERT INTO sweet VALUES (45,'Dry Fruit Chikki',190,200,'Mithai Mahal','Dry Fruit','2025-02-14')");
            statement.addBatch("INSERT INTO sweet VALUES (46,'Til Laddu',150,300,'Sri Sweets','Sesame','2025-02-15')");
            statement.addBatch("INSERT INTO sweet VALUES (47,'Chocolate Roll',280,250,'Anand Sweets','Chocolate','2025-02-16')");
            statement.addBatch("INSERT INTO sweet VALUES (48,'Kesar Halwa',260,250,'Gowri Sweets','Saffron','2025-02-17')");
            statement.addBatch("INSERT INTO sweet VALUES (49,'Anjeer Laddu',350,260,'com.xworkz.data.sweets.Sweet Stop','Fig','2025-02-18')");
            statement.addBatch("INSERT INTO sweet VALUES (50,'Mawa Barfi',230,260,'com.xworkz.data.sweets.Sweet Palace','Milk','2025-02-19')");
            statement.addBatch("INSERT INTO sweet VALUES (51,'Orange Barfi',220,240,'Royal com.xworkz.data.sweets.Sweet House','Orange','2025-02-20')");
            statement.addBatch("INSERT INTO sweet VALUES (52,'Walnut Barfi',360,230,'Anand Sweets','Walnut','2025-02-21')");
            statement.addBatch("INSERT INTO sweet VALUES (53,'Ragi Laddu',140,260,'Sri Sweets','Ragi','2025-02-22')");
            statement.addBatch("INSERT INTO sweet VALUES (54,'Dry Coconut Burfi',200,250,'Mithai Stop','Coconut','2025-02-23')");
            statement.addBatch("INSERT INTO sweet VALUES (55,'Oreo Laddu',260,250,'com.xworkz.data.sweets.Sweet Mall','Chocolate','2025-02-24')");
            statement.addBatch("INSERT INTO sweet VALUES (56,'Blueberry Barfi',320,240,'Mithai Mahal','Blueberry','2025-02-25')");
            statement.addBatch("INSERT INTO sweet VALUES (57,'Kiwi Barfi',330,230,'Royal com.xworkz.data.sweets.Sweet House','Kiwi','2025-02-26')");
            statement.addBatch("INSERT INTO sweet VALUES (58,'Chocolate Mysore Pak',300,240,'Anand Sweets','Chocolate','2025-02-27')");
            statement.addBatch("INSERT INTO sweet VALUES (59,'Dry Pineapple Halwa',270,250,'Gowri Sweets','Pineapple','2025-02-28')");
            statement.addBatch("INSERT INTO sweet VALUES (60,'Chocolate Peda',250,250,'com.xworkz.data.sweets.Sweet Stop','Milk','2025-03-01')");
            statement.addBatch("INSERT INTO sweet VALUES (61,'Oats Laddu',150,250,'Sri Sweets','Oats','2025-03-02')");
            statement.addBatch("INSERT INTO sweet VALUES (62,'Hazelnut Barfi',350,230,'Royal com.xworkz.data.sweets.Sweet House','Hazelnut','2025-03-03')");
            statement.addBatch("INSERT INTO sweet VALUES (63,'Rose Coconut Laddu',240,260,'Anand Sweets','Coconut','2025-03-04')");
            statement.addBatch("INSERT INTO sweet VALUES (64,'Strawberry Barfi',280,240,'Mithai Mahal','Strawberry','2025-03-05')");
            statement.addBatch("INSERT INTO sweet VALUES (65,'Cashew Orange Barfi',350,230,'com.xworkz.data.sweets.Sweet Palace','Cashew','2025-03-06')");
            statement.addBatch("INSERT INTO sweet VALUES (66,'Vanilla Peda',210,250,'Mithai Stop','Milk','2025-03-07')");
            statement.addBatch("INSERT INTO sweet VALUES (67,'Coffee Barfi',260,250,'com.xworkz.data.sweets.Sweet Mall','Coffee','2025-03-08')");
            statement.addBatch("INSERT INTO sweet VALUES (68,'Honey Almond Laddu',330,260,'Royal com.xworkz.data.sweets.Sweet House','Almond','2025-03-09')");
            statement.addBatch("INSERT INTO sweet VALUES (69,'Butter Scotch Laddu',250,240,'Anand Sweets','Butter Scotch','2025-03-10')");
            statement.addBatch("INSERT INTO sweet VALUES (70,'Pista Mysore Pak',300,250,'Sri Sweets','Pista','2025-03-11')");
            statement.addBatch("INSERT INTO sweet VALUES (71,'Kaju Mango Barfi',340,240,'com.xworkz.data.sweets.Sweet Stop','Cashew','2025-03-12')");
            statement.addBatch("INSERT INTO sweet VALUES (72,'Mixed Fruit Laddu',260,260,'com.xworkz.data.sweets.Sweet Palace','Fruit','2025-03-13')");
            statement.addBatch("INSERT INTO sweet VALUES (73,'Kesar Pista Halwa',370,250,'Anand Sweets','Pista','2025-03-14')");
            statement.addBatch("INSERT INTO sweet VALUES (74,'Dry Anjeer Barfi',390,240,'Royal com.xworkz.data.sweets.Sweet House','Fig','2025-03-15')");
            statement.addBatch("INSERT INTO sweet VALUES (75,'Mango Laddu',290,250,'Mithai Mahal','Mango','2025-03-16')");


            int[] results = statement.executeBatch();

            System.out.println("Inserted Total Rows = " + results.length);


    }
        catch (SQLException sqlException){
        sqlException.printStackTrace();
    }
        System.out.println("insert is done");
}


    }




// int rowsAffected =statement.executeUpdate(sql);
// System.out.println("rowsAffected:"+rowsAffected);

//String sql="DELETE FROM sweet WHERE sweet_id=1 ";


