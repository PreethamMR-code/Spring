package com.xworkz.data.street;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Street {
    public static void main(String[] args) {


        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";


try {


    Connection connection = DriverManager.getConnection(url, username, password);
    System.out.println("Connection:" + connection);

    Statement statement = connection.createStatement();

    System.out.println("inserting");

    statement.addBatch("insert into street values(1,'MG Road','Bengaluru','Karnataka',560001,2.5,20,'Commercial',120,80,'High',8,250000.00)");
    statement.addBatch("insert into street values(2,'Brigade Road','Bengaluru','Karnataka',560025,1.8,18,'Shopping',200,50,'High',9,300000.00)");
    statement.addBatch("insert into street values(3,'Commercial Street','Bengaluru','Karnataka',560042,1.2,15,'Market',250,70,'High',9,350000.00)");
    statement.addBatch("insert into street values(4,'Linking Road','Mumbai','Maharashtra',400052,3.0,22,'Commercial',300,120,'High',8,450000.00)");
    statement.addBatch("insert into street values(5,'Marine Drive Road','Mumbai','Maharashtra',400002,3.5,25,'Tourist',100,20,'Medium',9,500000.00)");
    statement.addBatch("insert into street values(6,'Park Street','Kolkata','West Bengal',700016,2.1,18,'Commercial',180,90,'High',7,270000.00)");
    statement.addBatch("insert into street values(7,'Esplanade Street','Kolkata','West Bengal',700069,1.9,17,'Market',220,120,'High',8,280000.00)");
    statement.addBatch("insert into street values(8,'Gariahat Road','Kolkata','West Bengal',700019,3.2,23,'Shopping',350,200,'High',7,400000.00)");
    statement.addBatch("insert into street values(9,'Anna Salai','Chennai','Tamil Nadu',600002,4.5,30,'Commercial',500,250,'High',8,750000.00)");
    statement.addBatch("insert into street values(10,'T Nagar Road','Chennai','Tamil Nadu',600017,2.8,20,'Market',320,180,'High',9,500000.00)");
    statement.addBatch("insert into street values(11,'Banjara Hills Road','Hyderabad','Telangana',500034,3.7,28,'Residential',80,300,'Medium',8,420000.00)");
    statement.addBatch("insert into street values(12,'Charminar Market Road','Hyderabad','Telangana',500002,1.6,15,'Market',500,60,'High',7,380000.00)");
    statement.addBatch("insert into street values(13,'Hazratganj Road','Lucknow','Uttar Pradesh',226001,3.0,18,'Commercial',260,150,'High',8,350000.00)");
    statement.addBatch("insert into street values(14,'Aminabad Street','Lucknow','Uttar Pradesh',226018,2.7,17,'Market',300,180,'High',7,330000.00)");
    statement.addBatch("insert into street values(15,'Lal Chowk Road','Srinagar','Jammu & Kashmir',190001,2.0,15,'Market',210,160,'Medium',6,200000.00)");
    statement.addBatch("insert into street values(16,'Mall Road','Shimla','Himachal Pradesh',171001,1.5,14,'Tourist',140,90,'Medium',9,280000.00)");
    statement.addBatch("insert into street values(17,'Civil Lines Road','Prayagraj','Uttar Pradesh',211001,3.8,24,'Commercial',180,250,'Medium',7,360000.00)");
    statement.addBatch("insert into street values(18,'MI Road','Jaipur','Rajasthan',302001,4.1,26,'Market',400,300,'High',8,550000.00)");
    statement.addBatch("insert into street values(19,'Johari Bazaar','Jaipur','Rajasthan',302002,2.2,16,'Jewellery Market',450,200,'High',7,470000.00)");
    statement.addBatch("insert into street values(20,'Chandni Chowk Road','Delhi','Delhi',110006,1.8,14,'Historic Market',700,150,'High',6,600000.00)");
    statement.addBatch("insert into street values(21,'Karol Bagh Road','Delhi','Delhi',110005,2.6,16,'Market',500,300,'High',7,580000.00)");
    statement.addBatch("insert into street values(22,'Connaught Place Road','Delhi','Delhi',110001,3.5,28,'Business Hub',350,260,'High',8,950000.00)");
    statement.addBatch("insert into street values(23,'Sarojini Nagar Road','Delhi','Delhi',110023,2.4,18,'Shopping',270,150,'High',7,500000.00)");
    statement.addBatch("insert into street values(24,'Sector 17 Plaza','Chandigarh','Chandigarh',160017,2.1,20,'Commercial',200,180,'Medium',8,420000.00)");
    statement.addBatch("insert into street values(25,'MG Road','Pune','Maharashtra',411001,2.9,22,'Market',330,210,'High',8,460000.00)");
    statement.addBatch("insert into street values(26,'FC Road','Pune','Maharashtra',411004,3.2,25,'Food & Market',250,200,'High',9,550000.00)");
    statement.addBatch("insert into street values(27,'Law College Road','Pune','Maharashtra',411004,3.8,30,'Residential',100,350,'Low',9,300000.00)");
    statement.addBatch("insert into street values(28,'Salt Lake Sector V Road','Kolkata','West Bengal',700091,4.6,32,'IT Street',150,80,'Medium',8,900000.00)");
    statement.addBatch("insert into street values(29,'Infocity Road','Bhubaneswar','Odisha',751024,3.9,28,'Tech Hub',120,70,'Medium',8,720000.00)");
    statement.addBatch("insert into street values(30,'Patia Road','Bhubaneswar','Odisha',751024,4.1,30,'Residential',200,400,'Low',9,300000.00)");
    statement.addBatch("insert into street values(31,'Kothrud Main Road','Pune','Maharashtra',411038,3.0,24,'Mixed',230,500,'Medium',8,350000.00)");
    statement.addBatch("insert into street values(32,'Viman Nagar Road','Pune','Maharashtra',411014,2.7,21,'Commercial',400,350,'High',9,600000.00)");
    statement.addBatch("insert into street values(33,'Khar West Road','Mumbai','Maharashtra',400052,3.3,23,'Residential',120,270,'Medium',8,800000.00)");
    statement.addBatch("insert into street values(34,'Bandra Hill Road','Mumbai','Maharashtra',400050,3.5,25,'Luxury',80,200,'Medium',9,1200000.00)");
    statement.addBatch("insert into street values(35,'Colaba Causeway','Mumbai','Maharashtra',400005,2.0,19,'Tourist',300,60,'High',8,700000.00)");
    statement.addBatch("insert into street values(36,'Church Street','Bengaluru','Karnataka',560001,1.6,18,'Cafe Street',150,90,'High',9,480000.00)");
    statement.addBatch("insert into street values(37,'Lavelle Road','Bengaluru','Karnataka',560001,2.8,20,'Commercial',200,140,'High',8,520000.00)");
    statement.addBatch("insert into street values(38,'Jayanagar 4th Block','Bengaluru','Karnataka',560041,3.5,26,'Market',320,500,'Medium',9,390000.00)");
    statement.addBatch("insert into street values(39,'Whitefield Main Road','Bengaluru','Karnataka',560066,6.0,32,'IT Hub',140,150,'High',7,1200000.00)");
    statement.addBatch("insert into street values(40,'Koramangala 5th Block','Bengaluru','Karnataka',560095,2.4,20,'Commercial',260,360,'High',9,650000.00)");
    statement.addBatch("insert into street values(41,'Camp Area Road','Pune','Maharashtra',411001,2.5,18,'Market',200,140,'High',7,370000.00)");
    statement.addBatch("insert into street values(42,'Sinhgad Road','Pune','Maharashtra',411051,5.0,30,'Highway Street',180,800,'Medium',8,450000.00)");
    statement.addBatch("insert into street values(43,'Hinjewadi Phase 1 Road','Pune','Maharashtra',411057,7.5,34,'IT Street',210,120,'High',9,1250000.00)");
    statement.addBatch("insert into street values(44,'Hadapsar Road','Pune','Maharashtra',411028,4.8,29,'Commercial',250,600,'Medium',8,600000.00)");
    statement.addBatch("insert into street values(45,'Miyapur Road','Hyderabad','Telangana',500049,6.0,28,'Residential',200,900,'Medium',7,430000.00)");
    statement.addBatch("insert into street values(46,'Kukatpally Road','Hyderabad','Telangana',500072,4.5,24,'Market',300,1000,'High',8,580000.00)");
    statement.addBatch("insert into street values(47,'Hitech City Road','Hyderabad','Telangana',500081,5.2,30,'IT Hub',180,200,'High',9,1400000.00)");
    statement.addBatch("insert into street values(48,'Jubilee Hills Road','Hyderabad','Telangana',500033,4.0,26,'Luxury',100,300,'Medium',9,1800000.00)");
    statement.addBatch("insert into street values(49,'Bashir Bagh Road','Hyderabad','Telangana',500029,3.2,22,'Commercial',280,350,'High',8,540000.00)");
    statement.addBatch("insert into street values(50,'Abids Road','Hyderabad','Telangana',500001,2.2,18,'Market',290,210,'Medium',7,420000.00)");
    statement.addBatch("insert into street values(51,'Sector 49 Road','Gurugram','Haryana',122018,3.1,20,'Residential',200,680,'Medium',8,460000.00)");
    statement.addBatch("insert into street values(52,'Cyber City Road','Gurugram','Haryana',122002,4.8,28,'Corporate Hub',120,90,'High',9,1800000.00)");
    statement.addBatch("insert into street values(53,'Golf Course Road','Gurugram','Haryana',122011,6.2,32,'Luxury',90,150,'Medium',9,2200000.00)");
    statement.addBatch("insert into street values(54,'Sector 14 Market Road','Gurugram','Haryana',122001,2.6,16,'Market',310,190,'High',8,450000.00)");
    statement.addBatch("insert into street values(55,'Sikar Road','Jaipur','Rajasthan',302039,7.0,30,'Highway',250,450,'Medium',7,510000.00)");
    statement.addBatch("insert into street values(56,'Vaishali Nagar Road','Jaipur','Rajasthan',302021,4.2,25,'Mixed',240,390,'Medium',8,460000.00)");
    statement.addBatch("insert into street values(57,'Bapu Bazar Road','Jaipur','Rajasthan',302003,1.9,15,'Shopping',410,230,'High',7,530000.00)");
    statement.addBatch("insert into street values(58,'Ashram Road','Ahmedabad','Gujarat',380009,5.0,28,'Commercial',350,400,'High',8,880000.00)");
    statement.addBatch("insert into street values(59,'CG Road','Ahmedabad','Gujarat',380006,3.9,22,'Market',330,380,'High',8,750000.00)");
    statement.addBatch("insert into street values(60,'Science City Road','Ahmedabad','Gujarat',380060,6.5,32,'Residential',180,350,'Medium',9,620000.00)");
    statement.addBatch("insert into street values(61,'Yelahanka Main Road','Bengaluru','Karnataka',560064,7.2,28,'Residential',250,700,'Low',8,380000.00)");
    statement.addBatch("insert into street values(62,'Rajajinagar Main Road','Bengaluru','Karnataka',560010,4.1,24,'Market',260,420,'Medium',9,490000.00)");
    statement.addBatch("insert into street values(63,'Nehru Place Road','Delhi','Delhi',110019,2.8,24,'IT Market',480,180,'High',8,900000.00)");
    statement.addBatch("insert into street values(64,'Laxmi Nagar Road','Delhi','Delhi',110092,3.0,20,'Commercial',520,650,'High',7,650000.00)");
    statement.addBatch("insert into street values(65,'Sector 62 Road','Noida','Uttar Pradesh',201309,5.8,28,'IT Hub',150,200,'Medium',8,980000.00)");
    statement.addBatch("insert into street values(66,'Noida Expressway','Noida','Uttar Pradesh',201301,8.5,35,'Highway',100,120,'High',9,1200000.00)");
    statement.addBatch("insert into street values(67,'Alkapuri Road','Vadodara','Gujarat',390007,4.0,22,'Commercial',200,350,'Medium',8,430000.00)");
    statement.addBatch("insert into street values(68,'Fatehgunj Road','Vadodara','Gujarat',390002,3.5,20,'Mixed',230,400,'Low',8,375000.00)");
    statement.addBatch("insert into street values(69,'Sadar Market Road','Nagpur','Maharashtra',440001,2.4,18,'Market',310,250,'High',7,420000.00)");
    statement.addBatch("insert into street values(70,'Dharampeth Road','Nagpur','Maharashtra',440010,3.0,22,'Commercial',280,300,'Medium',8,460000.00)");
    statement.addBatch("insert into street values(71,'VIP Road','Raipur','Chhattisgarh',492001,6.2,26,'Premium',190,260,'Medium',9,680000.00)");
    statement.addBatch("insert into street values(72,'Pandri Road','Raipur','Chhattisgarh',492004,3.1,18,'Shopping',300,280,'High',7,520000.00)");
    statement.addBatch("insert into street values(73,'Boring Road','Patna','Bihar',800001,4.0,24,'Commercial',350,300,'Medium',8,470000.00)");
    statement.addBatch("insert into street values(74,'Fraser Road','Patna','Bihar',800001,2.8,20,'Market',410,290,'High',7,450000.00)");
    statement.addBatch("insert into street values(75,'Kankarbagh Main Road','Patna','Bihar',800020,5.5,30,'Residential',200,800,'Medium',9,360000.00)");

    int[] results = statement.executeBatch();

    System.out.println("Inserted Total Rows = " + results.length);
}
catch (SQLException sqlException){
    sqlException.printStackTrace();
}
        System.out.println("insert is done");
    }
}
