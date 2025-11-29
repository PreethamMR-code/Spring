package com.xworkz.data.hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Hospital {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";
try {


    Connection connection = DriverManager.getConnection(url, username, password);
    System.out.println("Connection:" + connection);

    Statement statement = connection.createStatement();

    System.out.println("inserting");

    statement.addBatch("insert into hospital values(1,'Apollo Hospital','Chennai',1000,250,500,1983,'private',4.8,'Multi-Speciality')");
    statement.addBatch("insert into hospital values(2,'Fortis Hospital','Delhi',850,200,450,1996,'private',4.7,'Cardiology')");
    statement.addBatch("insert into hospital values(3,'AIIMS','Delhi',3000,700,1200,1956,'government',4.9,'All Departments')");
    statement.addBatch("insert into hospital values(4,'Narayana Health','Bangalore',1200,300,600,2000,'private',4.6,'Heart Surgery')");
    statement.addBatch("insert into hospital values(5,'Manipal Hospital','Udupi',900,180,400,1953,'private',4.5,'Cancer Treatment')");
    statement.addBatch("insert into hospital values(6,'Max Hospital','Delhi',750,160,350,2000,'private',4.4,'General Surgery')");
    statement.addBatch("insert into hospital values(7,'Columbia Asia','Bangalore',650,140,300,2004,'private',4.3,'Neurology')");
    statement.addBatch("insert into hospital values(8,'Tata Memorial Hospital','Mumbai',2000,450,900,1941,'government',4.9,'Oncology')");
    statement.addBatch("insert into hospital values(9,'Kasturba Medical Hospital','Manipal',950,210,420,1965,'private',4.4,'Orthopedics')");
    statement.addBatch("insert into hospital values(10,'CMC','Vellore',1500,350,700,1900,'private',4.8,'Research & Multi')");
    statement.addBatch("insert into hospital values(11,'Global Hospital','Hyderabad',800,170,360,1998,'private',4.3,'Kidney Transplant')");
    statement.addBatch("insert into hospital values(12,'Ruby Hall Clinic','Pune',700,160,330,1959,'private',4.2,'Cardiology')");
    statement.addBatch("insert into hospital values(13,'KIMS','Thiruvananthapuram',1100,240,500,1951,'private',4.4,'Neuroscience')");
    statement.addBatch("insert into hospital values(14,'Lilavati Hospital','Mumbai',900,200,410,1978,'private',4.6,'Pediatric')");
    statement.addBatch("insert into hospital values(15,'JIPMER','Puducherry',1800,390,780,1956,'government',4.8,'All Specialties')");
    statement.addBatch("insert into hospital values(16,'Ramaiah Hospital','Bangalore',850,170,350,1984,'private',4.2,'General Medicine')");
    statement.addBatch("insert into hospital values(17,'Sparsh Hospital','Bangalore',600,130,290,2005,'private',4.1,'Bone & Joint')");
    statement.addBatch("insert into hospital values(18,'Metro Hospital','Noida',650,140,300,1998,'private',4.0,'Diabetes')");
    statement.addBatch("insert into hospital values(19,'Medanta','Gurgaon',1200,280,600,2009,'private',4.7,'Liver Transplant')");
    statement.addBatch("insert into hospital values(20,'Care Hospital','Hyderabad',700,160,320,1997,'private',4.3,'Heart Care')");
    statement.addBatch("insert into hospital values(21,'Sunshine Hospital','Hyderabad',650,150,300,2009,'private',4.2,'Joint Replacement')");
    statement.addBatch("insert into hospital values(22,'Aster Hospital','Kochi',950,190,420,2013,'private',4.6,'Critical Care')");
    statement.addBatch("insert into hospital values(23,'Sri Sathya Sai Institute','Puttaparthi',1000,230,500,1971,'government',4.8,'Free Service')");
    statement.addBatch("insert into hospital values(24,'Rajiv Gandhi Hospital','Chennai',1400,300,650,1982,'government',4.1,'General')");
    statement.addBatch("insert into hospital values(25,'St. Johns Medical College Hospital','Bangalore',1300,290,610,1968,'private',4.5,'Medical Teaching')");
    statement.addBatch("insert into hospital values(26,'HCG Cancer Centre','Bangalore',700,160,350,2008,'private',4.7,'Cancer')");
    statement.addBatch("insert into hospital values(27,'BM Birla Heart Hospital','Kolkata',750,170,330,1967,'private',4.3,'Heart')");
    statement.addBatch("insert into hospital values(28,'Shifa Hospital','Kerala',550,120,260,2004,'private',4.1,'General')");
    statement.addBatch("insert into hospital values(29,'Sahyadri Hospital','Pune',700,160,350,2001,'private',4.2,'Neurology')");
    statement.addBatch("insert into hospital values(30,'Sir Ganga Ram Hospital','Delhi',900,210,430,1954,'private',4.7,'All Specialty')");
    statement.addBatch("insert into hospital values(31,'SevenHills Hospital','Mumbai',1700,360,800,1986,'private',4.6,'Emergency')");
    statement.addBatch("insert into hospital values(32,'Yashoda Hospitals','Hyderabad',1600,350,780,1989,'private',4.5,'General')");
    statement.addBatch("insert into hospital values(33,'NIMHANS','Bangalore',1800,400,900,1954,'government',4.9,'Neuro & Psych')");
    statement.addBatch("insert into hospital values(34,'Breach Candy Hospital','Mumbai',750,170,320,1950,'private',4.6,'Women Care')");
    statement.addBatch("insert into hospital values(35,'PD Hinduja Hospital','Mumbai',900,200,440,1951,'private',4.7,'Advanced Surgery')");
    statement.addBatch("insert into hospital values(36,'Sterling Hospital','Ahmedabad',700,160,330,2001,'private',4.3,'ICU')");
    statement.addBatch("insert into hospital values(37,'AMRI Hospitals','Kolkata',850,200,410,1996,'private',4.4,'Multi Care')");
    statement.addBatch("insert into hospital values(38,'Bowring Hospital','Bangalore',1500,320,680,1868,'government',4.0,'General')");
    statement.addBatch("insert into hospital values(39,'Victoria Hospital','Bangalore',1600,350,720,1901,'government',4.1,'General')");
    statement.addBatch("insert into hospital values(40,'ESI Hospital','Bangalore',700,150,320,1985,'government',3.9,'Public Employees')");
    statement.addBatch("insert into hospital values(41,'Rainbow Children Hospital','Hyderabad',600,130,290,1999,'private',4.5,'Child Care')");
    statement.addBatch("insert into hospital values(42,'Cloudnine Hospital','Bangalore',450,110,230,2007,'private',4.6,'Maternity')");
    statement.addBatch("insert into hospital values(43,'BirthRight by Rainbow','Bangalore',500,120,260,2011,'private',4.4,'Women & Child')");
    statement.addBatch("insert into hospital values(44,'Motherhood Hospital','Chennai',550,130,270,2010,'private',4.5,'Gynecology')");
    statement.addBatch("insert into hospital values(45,'Vasan Eye Care','India',800,170,350,2002,'private',4.6,'Ophthalmology')");
    statement.addBatch("insert into hospital values(46,'LV Prasad Eye Institute','Hyderabad',900,200,410,1987,'private',4.9,'Eye Specialist')");
    statement.addBatch("insert into hospital values(47,'Aravind Eye Hospital','Madurai',1500,300,620,1976,'private',4.8,'Eye Care')");
    statement.addBatch("insert into hospital values(48,'Shankar Netralaya','Chennai',1200,280,550,1978,'private',4.9,'Ophthalmology')");
    statement.addBatch("insert into hospital values(49,'Asian Heart Institute','Mumbai',800,170,350,2002,'private',4.8,'Cardiac')");
    statement.addBatch("insert into hospital values(50,'Fortis Escorts','Delhi',950,190,420,1988,'private',4.7,'Heart Care')");
    statement.addBatch("insert into hospital values(51,'Sankara Cancer Hospital','Bangalore',1000,230,480,1984,'private',4.6,'Cancer')");
    statement.addBatch("insert into hospital values(52,'Kempegowda Institute Hospital','Bangalore',1100,250,510,1979,'government',4.1,'General')");
    statement.addBatch("insert into hospital values(53,'Bowring Institute Medical','Bangalore',900,200,410,1990,'government',4.0,'General')");
    statement.addBatch("insert into hospital values(54,'Command Hospital','Bangalore',1500,330,720,1963,'government',4.4,'Army Medical')");
    statement.addBatch("insert into hospital values(55,'Army Research Hospital','Pune',1400,320,650,1978,'government',4.5,'Defense Medical')");
    statement.addBatch("insert into hospital values(56,'Indian Naval Hospital','Mumbai',1300,310,620,1965,'government',4.6,'Navy Medical')");
    statement.addBatch("insert into hospital values(57,'Airforce Command Hospital','Delhi',1200,290,580,1969,'government',4.5,'Airforce Medical')");
    statement.addBatch("insert into hospital values(58,'Railway Medical College Hospital','Chennai',1100,270,550,1988,'government',4.2,'Railway Medical')");
    statement.addBatch("insert into hospital values(59,'Bharat Sevashram Hospital','Kolkata',900,210,430,1933,'government',4.3,'Poor Welfare')");
    statement.addBatch("insert into hospital values(60,'Holy Family Hospital','Delhi',800,180,380,1953,'private',4.2,'General & Heart')");
    statement.addBatch("insert into hospital values(61,'St. Theresa Hospital','Hyderabad',750,170,360,1995,'private',4.1,'Mother & Child')");
    statement.addBatch("insert into hospital values(62,'Apollo Cradle','Bangalore',450,100,220,2008,'private',4.4,'Maternity')");
    statement.addBatch("insert into hospital values(63,'Deepam Eye Clinic','Chennai',550,130,260,2011,'private',4.3,'Eye Surgery')");
    statement.addBatch("insert into hospital values(64,'Suyog Hospital','Pune',500,110,240,2010,'private',4.1,'General')");
    statement.addBatch("insert into hospital values(65,'Mahavir Hospital','Mumbai',850,190,420,1985,'private',4.2,'Dialysis')");
    statement.addBatch("insert into hospital values(66,'Sunrise Hospital','Kerala',600,140,300,2005,'private',4.4,'General')");
    statement.addBatch("insert into hospital values(67,'Noble Hospital','Pune',900,210,430,2007,'private',4.5,'Orthopedic')");
    statement.addBatch("insert into hospital values(68,'Jayadeva Institute','Bangalore',1400,300,600,1973,'government',4.9,'Cardiac')");
    statement.addBatch("insert into hospital values(69,'HCG Cancer Centre','Mumbai',1200,260,550,2008,'private',4.8,'Cancer')");
    statement.addBatch("insert into hospital values(70,'Mission Hospital','Durgapur',1000,230,500,2003,'private',4.3,'Medicare')");
    statement.addBatch("insert into hospital values(71,'KEM Hospital','Mumbai',2200,450,900,1926,'government',4.7,'General')");
    statement.addBatch("insert into hospital values(72,'Sion Hospital','Mumbai',2000,420,850,1950,'government',4.5,'General')");
    statement.addBatch("insert into hospital values(73,'Rajendra Institute Medical Sciences','Ranchi',1800,390,780,1960,'government',4.4,'Research')");
    statement.addBatch("insert into hospital values(74,'PGI Chandigarh','Chandigarh',2500,520,1000,1962,'government',4.9,'All Specialist')");
    statement.addBatch("insert into hospital values(75,'AMU Medical Hospital','Aligarh',1650,350,740,1951,'government',4.6,'Medical Education')");


    int[] results = statement.executeBatch();

    System.out.println("Inserted Total Rows = " + results.length);
}
catch (SQLException sqlException){
    sqlException.printStackTrace();
}
        System.out.println("insert id completed");
    }
}
