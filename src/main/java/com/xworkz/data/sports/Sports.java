package com.xworkz.data.sports;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Sports {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";

        try{


        Connection connection = DriverManager.getConnection(url, username, password);
        System.out.println("Connection:" + connection);

        Statement statement = connection.createStatement();

        System.out.println("inserting");


        statement.addBatch("insert into sports values (1,'cricket','team sport','india',11,'bat, ball','chinna swamy',1,'outdoor',1)");
        statement.addBatch("insert into sports values (2,'football','team sport','england',11,'football','wembley stadium',1,'outdoor',2)");
        statement.addBatch("insert into sports values (3,'hockey','team sport','india',11,'stick, ball','kalinga stadium',1,'outdoor',3)");
        statement.addBatch("insert into sports values (4,'tennis','racquet sport','france',2,'racquet, ball','rod laver arena',1,'outdoor',4)");
        statement.addBatch("insert into sports values (5,'badminton','racquet sport','india',2,'shuttle, racquet','indoor stadium',1,'indoor',5)");
        statement.addBatch("insert into sports values (6,'basketball','team sport','usa',5,'basketball','nba arena',1,'indoor',6)");
        statement.addBatch("insert into sports values (7,'volleyball','team sport','usa',6,'volleyball','national indoor court',1,'indoor/outdoor',7)");
        statement.addBatch("insert into sports values (8,'table tennis','racquet sport','uk',2,'table, paddle','indoor hall',1,'indoor',8)");
        statement.addBatch("insert into sports values (9,'kabaddi','traditional','india',7,'none','mud court',1,'outdoor',9)");
        statement.addBatch("insert into sports values (10,'kho kho','traditional','india',9,'none','outdoor ground',0,'outdoor',10)");
        statement.addBatch("insert into sports values (11,'baseball','team sport','usa',9,'bat, glove, ball','yankee stadium',1,'outdoor',11)");
        statement.addBatch("insert into sports values (12,'rugby','team sport','england',15,'rugby ball','twickenham stadium',1,'outdoor',12)");
        statement.addBatch("insert into sports values (13,'chess','mind sport','india',2,'chessboard','indoor hall',0,'indoor',13)");
        statement.addBatch("insert into sports values (14,'carrom','board game','india',2,'carrom board','indoor club',0,'indoor',14)");
        statement.addBatch("insert into sports values (15,'snooker','cue sport','uk',2,'cues, balls','snooker club',0,'indoor',15)");
        statement.addBatch("insert into sports values (16,'golf','precision','scotland',1,'golf club, ball','st andrews',1,'outdoor',16)");
        statement.addBatch("insert into sports values (17,'boxing','combat sport','usa',2,'gloves','mgm arena',1,'indoor',17)");
        statement.addBatch("insert into sports values (18,'wrestling','combat','greece',2,'none','olympic hall',1,'indoor',18)");
        statement.addBatch("insert into sports values (19,'swimming','individual','australia',1,'swimwear','aquatic centre',1,'indoor/outdoor',19)");
        statement.addBatch("insert into sports values (20,'athletics','track & field','greece',1,'none','olympic track',1,'outdoor',20)");
        statement.addBatch("insert into sports values (21,'archery','target sport','mongolia',1,'bow, arrow','outdoor range',1,'outdoor',21)");
        statement.addBatch("insert into sports values (22,'shooting','precision sport','germany',1,'rifle, pistol','shooting range',1,'indoor',22)");
        statement.addBatch("insert into sports values (23,'cycling','race','france',1,'cycle','velodrome',1,'outdoor',23)");
        statement.addBatch("insert into sports values (24,'skating','rink sport','usa',1,'skates','ice arena',1,'indoor',24)");
        statement.addBatch("insert into sports values (25,'judo','combat','japan',2,'gi uniform','olympic arena',1,'indoor',25)");
        statement.addBatch("insert into sports values (26,'karate','combat sport','japan',2,'gi suit','budokan hall',1,'indoor',26)");
        statement.addBatch("insert into sports values (27,'taekwondo','martial art','korea',2,'dobok, pads','olympic venue',1,'indoor',27)");
        statement.addBatch("insert into sports values (28,'fencing','combat sport','spain',2,'foil, sword','olympic arena',1,'indoor',28)");
        statement.addBatch("insert into sports values (29,'weightlifting','strength','greece',1,'barbell','olympic stage',1,'indoor',29)");
        statement.addBatch("insert into sports values (30,'powerlifting','strength','russia',1,'weights','strength arena',0,'indoor',30)");
        statement.addBatch("insert into sports values (31,'rowing','water sport','england',8,'rowing boat','river course',1,'outdoor',31)");
        statement.addBatch("insert into sports values (32,'canoeing','water sport','canada',1,'canoe, paddle','wild river',1,'outdoor',32)");
        statement.addBatch("insert into sports values (33,'kayaking','water sport','germany',1,'kayak, paddle','rapid river',1,'outdoor',33)");
        statement.addBatch("insert into sports values (34,'surfing','water sport','hawaii',1,'surfboard','ocean beach',1,'outdoor',34)");
        statement.addBatch("insert into sports values (35,'sailing','water sport','portugal',3,'boat, sail','yacht marina',1,'outdoor',35)");
        statement.addBatch("insert into sports values (36,'motor racing','motorsport','france',1,'car','race circuit',0,'outdoor',36)");
        statement.addBatch("insert into sports values (37,'formula one','motorsport','italy',1,'f1 car','monza circuit',0,'outdoor',37)");
        statement.addBatch("insert into sports values (38,'motogp','motorsport','japan',1,'motorbike','moto gp arena',0,'outdoor',38)");
        statement.addBatch("insert into sports values (39,'ice hockey','team sport','canada',6,'stick, puck','ice rink',1,'indoor',39)");
        statement.addBatch("insert into sports values (40,'snowboarding','extreme sport','switzerland',1,'snowboard','snow mountains',1,'outdoor',40)");
        statement.addBatch("insert into sports values (41,'skiing','snow sport','austria',1,'skis','snow alps',1,'outdoor',41)");
        statement.addBatch("insert into sports values (42,'rock climbing','adventure sport','usa',1,'rope, harness','cliff zone',0,'outdoor',42)");
        statement.addBatch("insert into sports values (43,'mountaineering','adventure','nepal',1,'climbing gear','himalayas',0,'outdoor',43)");
        statement.addBatch("insert into sports values (44,'skateboarding','urban sport','usa',1,'skateboard','street park',1,'outdoor',44)");
        statement.addBatch("insert into sports values (45,'parkour','free run','france',1,'none','urban streets',0,'outdoor',45)");
        statement.addBatch("insert into sports values (46,'gymnastics','artistic sport','germany',1,'rings, bars','indoor arena',1,'indoor',46)");
        statement.addBatch("insert into sports values (47,'diving','water sport','australia',1,'swimwear','deep dive pool',1,'indoor',47)");
        statement.addBatch("insert into sports values (48,'handball','team sport','germany',7,'handball','german arena',1,'indoor',48)");
        statement.addBatch("insert into sports values (49,'softball','team sport','usa',9,'bat & ball','softball stadium',1,'outdoor',49)");
        statement.addBatch("insert into sports values (50,'lacrosse','team sport','usa',10,'stick & net','lacrosse field',0,'outdoor',50)");
        statement.addBatch("insert into sports values (51,'equestrian','horse sport','uk',1,'horse','derby ground',1,'outdoor',51)");
        statement.addBatch("insert into sports values (52,'e-sports','gaming','korea',5,'controller','gaming arena',0,'indoor',52)");
        statement.addBatch("insert into sports values (53,'polo','horse sport','india',4,'mallet, horse','polo ground',0,'outdoor',53)");
        statement.addBatch("insert into sports values (54,'bowling','leisure sport','usa',6,'bowling ball','bowling alley',0,'indoor',54)");
        statement.addBatch("insert into sports values (55,'darts','pub sport','england',1,'dartboard','indoor bar',0,'indoor',55)");
        statement.addBatch("insert into sports values (56,'billiards','cue sport','france',2,'cue stick','billiards hall',0,'indoor',56)");
        statement.addBatch("insert into sports values (57,'ultimate frisbee','flying disc game','usa',7,'frisbee','open field',0,'outdoor',57)");
        statement.addBatch("insert into sports values (58,'field archery','target sport','india',1,'bow & arrows','archery ground',0,'outdoor',58)");
        statement.addBatch("insert into sports values (59,'drifting','motorsport','japan',1,'drift car','asphalt track',0,'outdoor',59)");
        statement.addBatch("insert into sports values (60,'triathlon','endurance race','usa',1,'cycle,running,swim','ironman track',1,'outdoor',60)");
        statement.addBatch("insert into sports values (61,'marathon','athletics','greece',1,'running shoes','city road track',1,'outdoor',61)");
        statement.addBatch("insert into sports values (62,'relay race','athletics','greece',4,'baton','race track',1,'outdoor',62)");
        statement.addBatch("insert into sports values (63,'discus throw','athletics','greece',1,'discus','throw field',1,'outdoor',63)");
        statement.addBatch("insert into sports values (64,'javelin throw','athletics','greece',1,'javelin','throw ground',1,'outdoor',64)");
        statement.addBatch("insert into sports values (65,'shot put','strength sport','greece',1,'iron ball','shot ring',1,'outdoor',65)");
        statement.addBatch("insert into sports values (66,'taichi','traditional','china',1,'none','open park',0,'outdoor',66)");
        statement.addBatch("insert into sports values (67,'kite flying','recreational','china',1,'kite','open ground',0,'outdoor',67)");
        statement.addBatch("insert into sports values (68,'paddle boarding','water adventure','hawaii',1,'paddleboard','sea coast',0,'outdoor',68)");
        statement.addBatch("insert into sports values (69,'rafting','river adventure','nepal',8,'raft boat','river rapid',0,'outdoor',69)");
        statement.addBatch("insert into sports values (70,'sandboarding','desert sport','dubai',1,'sand board','desert dunes',0,'outdoor',70)");
        statement.addBatch("insert into sports values (71,'dog sledding','arctic sport','alaska',6,'sled dogs','snow trail',0,'outdoor',71)");
        statement.addBatch("insert into sports values (72,'ice skating','winter sport','finland',1,'skates','frozen lake',1,'indoor/outdoor',72)");
        statement.addBatch("insert into sports values (73,'curling','winter sport','canada',4,'granite stone','ice rink',1,'indoor',73)");
        statement.addBatch("insert into sports values (74,'sumo wrestling','traditional','japan',2,'mawashi','sumo arena',1,'indoor',74)");


        int[] results = statement.executeBatch();

        System.out.println("Inserted Total Rows = " + results.length);
        }
        catch (SQLException sqlException){
            sqlException.printStackTrace();
        }
        System.out.println("insert is done");
    }
}
