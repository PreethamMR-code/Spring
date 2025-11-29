package com.xworkz.data.president;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class President {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/matrimony_db";
        String username = "root";
        String password = "0000";

try {


    Connection connection = DriverManager.getConnection(url, username, password);
    System.out.println("Connection:" + connection);

    Statement statement = connection.createStatement();

    System.out.println("inserting");

    statement.addBatch("insert into president values(1,'Narendra Modi','India',2014,2029,74,'BJP','Jashodaben Modi','Political Science','Digital India, Make in India','Champions of Earth Award',3,'Gujarat',300000000,'Chief Minister',78.1)");
    statement.addBatch("insert into president values(2,'Joe Biden','USA',2021,2025,81,'Democratic','Jill Biden','Law','Infrastructure Bill','Presidential Medal of Freedom',1,'Pennsylvania',9000000,'Vice President',52.5)");
    statement.addBatch("insert into president values(3,'Barack Obama','USA',2009,2017,62,'Democratic','Michelle Obama','Harvard Law','Affordable Care Act','Nobel Peace Prize',2,'Hawaii',70000000,'Senator',66.3)");
    statement.addBatch("insert into president values(4,'Donald Trump','USA',2017,2021,78,'Republican','Melania Trump','Wharton Business School','Tax Reform Plan','Time Person of Year',1,'New York',2500000000,'Businessman',55.6)");
    statement.addBatch("insert into president values(5,'George W. Bush','USA',2001,2009,78,'Republican','Laura Bush','Yale University','War on Terror Leadership','Liberty Medal',2,'Connecticut',40000000,'Governor of Texas',48.0)");
    statement.addBatch("insert into president values(6,'Bill Clinton','USA',1993,2001,78,'Democratic','Hillary Clinton','Yale Law School','Balanced Budget Act','Presidential Citizens Medal',2,'Arkansas',120000000,'Governor of Arkansas',60.4)");
    statement.addBatch("insert into president values(7,'Pranab Mukherjee','India',2012,2017,82,'INC','Suvra Mukherjee','History, Political Science','GST Framework Support','Bharat Ratna',1,'West Bengal',15000000,'Finance Minister',72.2)");
    statement.addBatch("insert into president values(8,'APJ Abdul Kalam','India',2002,2007,83,'Independent','Unmarried','Aerospace Engineering','Missile Man of India','Bharat Ratna',1,'Tamil Nadu',8000000,'DRDO Scientist',90.1)");
    statement.addBatch("insert into president values(9,'Ram Nath Kovind','India',2017,2022,79,'BJP','Savita Kovind','Law','Empowering Dalit communities','Honorary Doctorate',1,'Uttar Pradesh',4500000,'Governor',65.8)");
    statement.addBatch("insert into president values(10,'Droupadi Murmu','India',2022,2027,66,'BJP','Shyam Charan Murmu','BA','First Tribal Woman President','State Excellence Award',1,'Odisha',3200000,'Governor of Jharkhand',72.5)");
    statement.addBatch("insert into president values(11,'Xi Jinping','China',2013,2033,70,'CPC','Peng Liyuan','Chemical Engineering','Belt and Road Initiative','Order of Friendship',3,'Beijing',1500000000,'Vice President',82.3)");
    statement.addBatch("insert into president values(12,'Vladimir Putin','Russia',2000,2025,71,'United Russia','Lyudmila Putina','Law','Crimean Integration','Time Person of Year',4,'Saint Petersburg',70000000000,'KGB Officer',75.0)");
    statement.addBatch("insert into president values(13,'Volodymyr Zelensky','Ukraine',2019,2029,46,'Servant of People','Olena Zelenska','Law','Ukraine Defense Leadership','Time Person of the Year',2,'Kryvyi Rih',8000000,'Actor & Entrepreneur',85.1)");
    statement.addBatch("insert into president values(14,'Imran Khan','Pakistan',2018,2022,71,'PTI','Bushra Bibi','Oxford','Anti-Corruption Campaign','ICC Hall of Fame',1,'Lahore',50000000,'Cricketer & Philanthropist',58.4)");
    statement.addBatch("insert into president values(15,'Shehbaz Sharif','Pakistan',2022,2024,73,'PML-N','Nusrat Shehbaz','Economics','Economic Revival Scheme','Pakistan Leadership Award',1,'Lahore',35000000,'Chief Minister',54.7)");
    statement.addBatch("insert into president values(16,'Rishi Sunak','UK',2022,2029,44,'Conservative','Akshata Murthy','Stanford MBA','Inflation Reduction Policies','Young Global Leader',1,'Southampton',810000000,'Chancellor of Treasury',62.9)");
    statement.addBatch("insert into president values(17,'Liz Truss','UK',2022,2022,48,'Conservative','Hugh O Leary','PPE Oxford','Tax Cuts Proposal','Leadership Medal',1,'Oxford',58000000,'Foreign Secretary',40.2)");
    statement.addBatch("insert into president values(18,'Boris Johnson','UK',2019,2022,60,'Conservative','Carrie Johnson','Classics Oxford','Covid Vaccine Rollout','Churchill Award',1,'New York',20000000,'Mayor of London',56.4)");
    statement.addBatch("insert into president values(19,'Tony Blair','UK',1997,2007,71,'Labour','Cherie Blair','Law','Northern Ireland Peace Deal','Presidential Medal of Freedom',3,'Edinburgh',60000000,'Opposition Leader',65.5)");
    statement.addBatch("insert into president values(20,'Theresa May','UK',2016,2019,68,'Conservative','Philip May','Geography','Brexit Negotiations','Women Leadership Award',1,'Eastbourne',5000000,'Home Secretary',51.3)");
    statement.addBatch("insert into president values(21,'Emmanuel Macron','France',2017,2032,46,'La République En Marche','Brigitte Macron','Philosophy','Labor Reforms','Charlemagne Prize',2,'Amiens',40000000,'Finance Minister',59.6)");
    statement.addBatch("insert into president values(22,'Angela Merkel','Germany',2005,2021,69,'CDU','Joachim Sauer','Physics','Refugee Policy Reform','Presidential Medal of Freedom',4,'Hamburg',11500000,'Scientist',71.2)");
    statement.addBatch("insert into president values(23,'Frank-Walter Steinmeier','Germany',2017,2027,68,'SPD','Elke Büdenbender','Law','European Unity Diplomacy','German National Award',2,'Detmold',3500000,'Foreign Minister',67.9)");
    statement.addBatch("insert into president values(24,'Sergio Mattarella','Italy',2015,2022,82,'Independent','Marisa Mattarella','Law','Constitutional Reforms','Golden Eagle',2,'Sicily',5000000,'Judge',63.3)");
    statement.addBatch("insert into president values(25,'Giorgia Meloni','Italy',2022,2032,47,'Brothers of Italy','Andrea Giambruno','Political Science','Economic Reform Agenda','Leadership Award',2,'Rome',9000000,'Parliament Member',69.1)");
    statement.addBatch("insert into president values(26,'Pedro Sánchez','Spain',2018,2028,52,'PSOE','Maria Begoña','Economics','Minimum Wage Increase','National Leadership Award',2,'Madrid',9000000,'Opposition Leader',64.8)");
    statement.addBatch("insert into president values(27,'Luis Arce','Bolivia',2020,2028,60,'MAS','Rosalinda Arce','Economics','Economic Stabilization','National Merit Award',1,'La Paz',7000000,'Finance Minister',57.1)");
    statement.addBatch("insert into president values(28,'Gabriel Boric','Chile',2022,2029,38,'Social Convergence','Irina Karamanos','Political Science','Social Equity Reforms','Global Young Leader',1,'Punta Arenas',1500000,'Student Leader',62.4)");
    statement.addBatch("insert into president values(29,'Justin Trudeau','Canada',2015,2029,52,'Liberal','Sophie Trudeau','Literature','Cannabis Legalization','Global Diversity Award',3,'Ottawa',12000000,'Member of Parliament',66.7)");
    statement.addBatch("insert into president values(30,'Andrés Manuel López Obrador','Mexico',2018,2024,71,'MORENA','Beatriz Müller','Political Science','Corruption Control Drives','National Honor Award',1,'Tabasco',3000000,'Mayor',60.2)");
    statement.addBatch("insert into president values(31,'Nayib Bukele','El Salvador',2019,2034,43,'Nuevas Ideas','Gabriela Bukele','Marketing','Bitcoin Legalization','Global Innovation Award',2,'San Salvador',15000000,'Mayor',84.2)");
    statement.addBatch("insert into president values(32,'Daniel Ortega','Nicaragua',2007,2030,78,'FSLN','Rosario Murillo','Law','Social Assistance Programs','Order of Carlos Fonseca',4,'La Libertad',6000000,'Revolutionary Leader',55.1)");
    statement.addBatch("insert into president values(33,'Alberto Fernández','Argentina',2019,2023,65,'Justicialist','Fabiola Yáñez','Law','Debt Restructure Negotiation','State Excellence Award',1,'Buenos Aires',4500000,'Chief of Cabinet',53.9)");
    statement.addBatch("insert into president values(34,'Javier Milei','Argentina',2023,2032,53,'Libertarian','Fátima Flores','Economics','Economic Free Market Reform','Leadership Distinction Medal',1,'Buenos Aires',2000000,'Economist',59.0)");
    statement.addBatch("insert into president values(35,'Luiz Inácio Lula da Silva','Brazil',2023,2028,78,'Workers Party','Rosangela Lula','Labour Law','Poverty Reduction Program','Time Hero Award',3,'Pernambuco',9000000,'Union Leader',61.4)");
    statement.addBatch("insert into president values(36,'Nicolás Maduro','Venezuela',2013,2026,61,'PSUV','Cilia Flores','Law','Food Distribution Reforms','Honorary Peace Medal',3,'Caracas',2500000,'Vice President',45.7)");
    statement.addBatch("insert into president values(37,'Gustavo Petro','Colombia',2022,2030,64,'Colombia Humana','Verónica Alcocer','Economics','Tax Reform & Peace Talks','National Order of Merit',1,'Córdoba',8000000,'Mayor of Bogotá',55.3)");
    statement.addBatch("insert into president values(38,'Guillermo Lasso','Ecuador',2021,2023,68,'CREO','María de Lourdes','Finance','Vaccination Acceleration Plan','Business Excellence Award',1,'Guayaquil',1200000000,'Banker',46.9)");
    statement.addBatch("insert into president values(39,'Evo Morales','Bolivia',2006,2019,64,'MAS','Unmarried','Agricultural Studies','Indigenous Rights Movement','UN Earth Award',3,'Oruro',3000000,'Activist',58.8)");
    statement.addBatch("insert into president values(40,'Horacio Cartes','Paraguay',2013,2018,67,'Colorado Party','Maria Montaña','Business Admin','Economic Stabilization Reform','National Leadership Award',1,'Asunción',2100000000,'Businessman',52.1)");
    statement.addBatch("insert into president values(41,'Fidel Castro','Cuba',1959,2008,90,'Communist','Celia Sánchez','Law','Cuban Revolution Victory','Hero of Soviet Union',4,'Birán',900000000,'Revolution Leader',72.2)");
    statement.addBatch("insert into president values(42,'Miguel Díaz-Canel','Cuba',2018,2030,63,'Communist Party','Lis Cuesta','Electronics Engineering','Economic Modernization','State Honor of Cuba',2,'Placetas',5000000,'Vice President',55.4)");
    statement.addBatch("insert into president values(43,'Mahmoud Abbas','Palestine',2005,2029,88,'Fatah','Amina Abbas','History','Peace Negotiation Leadership','UN Peace Medal',4,'Safed',10000000,'Prime Minister',49.3)");
    statement.addBatch("insert into president values(44,'Recep Tayyip Erdoğan','Turkey',2014,2033,70,'AKP','Emine Erdogan','Economics','Economic Growth Drive','Global Power Leadership Award',3,'Istanbul',520000000,'Prime Minister',71.6)");
    statement.addBatch("insert into president values(45,'Isaac Herzog','Israel',2021,2028,63,'Labor Party','Michal Herzog','Law','Political Unification Efforts','Jewish Leadership Award',2,'Tel Aviv',12000000,'Opposition Leader',58.7)");
    statement.addBatch("insert into president values(46,'King Charles III','UK Monarch',2022,2050,75,'Royal Family','Camilla Parker','Royal Education','Global Cultural Preservation','Royal Order of Merit',1,'London',1800000000,'Prince of Wales',79.8)");
    statement.addBatch("insert into president values(47,'King Willem-Alexander','Netherlands',2013,2045,56,'Royal','Queen Máxima','History','Water Management Advocacy','Royal Honor Cross',2,'Utrecht',300000000,'Prince',63.5)");
    statement.addBatch("insert into president values(48,'King Felipe VI','Spain',2014,2044,55,'Royal House','Queen Letizia','Military Science','Catalonia Mediation Effort','Royal Order of Golden Fleece',2,'Madrid',150000000,'Prince of Asturias',69.9)");
    statement.addBatch("insert into president values(49,'Mohammed bin Salman','Saudi Arabia',2017,2055,39,'Royal House','Princess Sara','Engineering','Vision 2030 Reform','King Abdulaziz Medal',1,'Riyadh',500000000000,'Crown Prince',83.4)");
    statement.addBatch("insert into president values(50,'Sheikh Mohamed bin Zayed','UAE',2022,2045,63,'Royal Family','Salama bint Hamdan','Military Academy','Global Peace Diplomacy','Order of Zayed',1,'Abu Dhabi',200000000000,'Crown Prince',81.6)");
    statement.addBatch("insert into president values(51,'Shavkat Mirziyoyev','Uzbekistan',2016,2035,66,'Liberal Democratic Party','Ziroatkhon Mirziyoyeva','Engineering','Economic Liberalization','Order of Friendship',3,'Jizzakh',4500000,'Prime Minister',61.5)");
    statement.addBatch("insert into president values(52,'Kassym-Jomart Tokayev','Kazakhstan',2019,2030,70,'Nur Otan','Nadezhda Tokayeva','International Relations','Political Stability Reforms','Golden Eagle Award',2,'Almaty',6000000,'Senate Chairman',58.9)");
    statement.addBatch("insert into president values(53,'Serdar Berdimuhamedow','Turkmenistan',2022,2040,42,'Democratic Party','Ogulgerek Atayeva','Engineering','Technology Modernization','State Medal of Turkmenistan',1,'Ashgabat',1500000000,'Deputy PM',62.2)");
    statement.addBatch("insert into president values(54,'Alexander Lukashenko','Belarus',1994,2030,70,'Independent','Galina Lukashenko','Agricultural Economics','Longest Serving Leader','Hero of Belarus',5,'Kopys',800000000,'Agriculture Director',46.5)");
    statement.addBatch("insert into president values(55,'Ilham Aliyev','Azerbaijan',2003,2033,62,'New Azerbaijan Party','Mehriban Aliyeva','History','Karabakh Conflict Leadership','Heydar Aliyev Order',4,'Baku',9000000000,'Prime Minister',67.4)");
    statement.addBatch("insert into president values(56,'Nicol Pashinyan','Armenia',2018,2025,48,'Civil Contract Party','Anna Hakobyan','Journalism','Anti-Corruption Reform','State Medal for Courage',1,'Ijevan',4500000,'Editor',54.2)");
    statement.addBatch("insert into president values(57,'Ebrahim Raisi','Iran',2021,2028,64,'Conservative','Jamileh Alamolhoda','Islamic Jurisprudence','Anti-Corruption Drive','Islamic Revolution Medal',1,'Mashhad',5500000,'Chief Justice',49.1)");
    statement.addBatch("insert into president values(58,'Joko Widodo','Indonesia',2014,2029,62,'PDI-P','Iriana Widodo','Forestry Engineering','Infrastructure Expansion','ASEAN Leadership Award',2,'Surakarta',30000000,'Governor of Jakarta',73.8)");
    statement.addBatch("insert into president values(59,'Ferdinand Marcos Jr','Philippines',2022,2032,66,'Federal Party','Louise Marcos','Political Science','Food Security Reforms','National Unity Award',1,'Ilocos Norte',35000000,'Senator',68.0)");
    statement.addBatch("insert into president values(60,'Hun Sen','Cambodia',1985,2023,71,'CPP','Bun Rany','Political Studies','Longest Ruling Asian Leader','Royal Order of Cambodia',7,'Kampong Cham',12000000,'Prime Minister',55.0)");
    statement.addBatch("insert into president values(61,'Muhammadu Buhari','Nigeria',2015,2023,81,'APC','Aisha Buhari','Defence Studies','Anti-Corruption War','UN Leadership Award',2,'Daura',5000000,'Military Head of State',48.9)");
    statement.addBatch("insert into president values(62,'Paul Kagame','Rwanda',2000,2035,66,'RPF','Jeannette Kagame','Business Admin','Economic Revival after Genocide','African Peace Award',5,'Tambwe',20000000,'Army Chief',79.2)");
    statement.addBatch("insert into president values(63,'William Ruto','Kenya',2022,2027,57,'UDA','Rachel Ruto','Botany','Agricultural Subsidy Reforms','African Governance Award',1,'Sambut',8500000,'Deputy President',61.6)");
    statement.addBatch("insert into president values(64,'Samia Suluhu Hassan','Tanzania',2021,2030,64,'CCM','Hafidh Ameir','Public Administration','First Female President of Tanzania','African Icon Award',1,'Zanzibar',5000000,'Vice President',70.4)");
    statement.addBatch("insert into president values(65,'Yoweri Museveni','Uganda',1986,2030,79,'NRM','Janet Museveni','Economics','Longest Ruling African President','African Leadership Prize',7,'Ntungamo',12000000,'Rebel Leader',50.5)");
    statement.addBatch("insert into president values(66,'Hakainde Hichilema','Zambia',2021,2029,61,'UPND','Mutinta Hichilema','Economics','Debt Relief & Stabilization','African Democracy Medal',1,'Monze',15000000,'Businessman',67.3)");
    statement.addBatch("insert into president values(67,'George Weah','Liberia',2018,2023,58,'CDC','Clar Weah','Sports Education','Economic Development Programs','Ballon d Or Award',1,'Monrovia',3500000,'Footballer',59.7)");
    statement.addBatch("insert into president values(68,'Lazarus Chakwera','Malawi',2020,2027,69,'MCP','Monica Chakwera','Theology','Anti-Graft Reform','African Renaissance Prize',1,'Lilongwe',2000000,'Pastor',56.0)");
    statement.addBatch("insert into president values(69,'Macky Sall','Senegal',2012,2024,62,'APR','Marieme Sall','Geology','Infrastructure Growth Projects','National Order of Merit',2,'Fatick',8000000,'Prime Minister',65.2)");
    statement.addBatch("insert into president values(70,'Alassane Ouattara','Ivory Coast',2010,2025,82,'RDR','Dominique Ouattara','Economics','Economic Boom in Ivory Coast','African Leadership Honor',3,'Abidjan',25000000,'Prime Minister',72.1)");
    statement.addBatch("insert into president values(71,'Faure Gnassingbé','Togo',2005,2030,58,'UNIR','Unmarried','Business Management','West African Integration','National Grand Medal',4,'Lome',18000000,'Defense Minister',47.8)");
    statement.addBatch("insert into president values(72,'Denis Sassou Nguesso','Congo',1997,2033,80,'PCT','Antoinette Nguesso','Law','Longest Serving Congo Leader','Order of Congo Merit',7,'Edou','9000000','Army Leader',45.6)");
    statement.addBatch("insert into president values(73,'João Lourenço','Angola',2017,2030,69,'MPLA','Ana Lourenco','History','Oil Sector Reform','National Honor Medal',2,'Luanda',6000000,'Defense Minister',50.9)");
    statement.addBatch("insert into president values(74,'Isaias Afwerki','Eritrea',1993,2035,78,'PFDJ','Saba Haile','Engineering','Independence Freedom Fighter','National Liberation Honor',6,'Asmara',4500000,'Rebel Leader',42.3)");
    statement.addBatch("insert into president values(75,'Hassan Rouhani','Iran',2013,2021,75,'Moderate Alliance','Sahebeh Rouhani','Civil Law','Iran Nuclear Agreement','UN Peace Recognition',2,'Sorkheh',6000000,'National Security Advisor',55.8)");


    int[] results = statement.executeBatch();

    System.out.println("Inserted Total Rows = " + results.length);
}
catch (SQLException sqlException){
    sqlException.printStackTrace();
        }

        System.out.println("insert is done");
    }
}
