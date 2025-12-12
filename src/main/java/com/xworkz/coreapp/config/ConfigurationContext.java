package com.xworkz.coreapp.config;


import com.xworkz.coreapp.dto.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;


@Configuration
@ComponentScan(basePackages = "com.xworkz.coreapp")
public class ConfigurationContext {

    public ConfigurationContext(){
        System.out.println("config con created");
    }

    @Bean("P1")
    public List<Airport> getAirports() {
        List<Airport> airports = new ArrayList<>();
        airports.add(new Airport("Kempegowda International", "Bangalore", 3, 2, 350000, true, 5000, 2008));
        airports.add(new Airport("Chhatrapati Shivaji Maharaj", "Mumbai", 4, 3, 450000, true, 6000, 1942));
        airports.add(new Airport("Indira Gandhi International", "Delhi", 3, 2, 600000, true, 8000, 1962));
        airports.add(new Airport("Rajiv Gandhi International", "Hyderabad", 2, 2, 250000, true, 4000, 2008));
        airports.add(new Airport("Chennai International", "Chennai", 4, 3, 300000, true, 5500, 1948));
        airports.add(new Airport("Cochin International", "Kochi", 2, 1, 120000, true, 2500, 1999));
        airports.add(new Airport("Dabolim", "Goa", 1, 2, 80000, true, 1200, 1966));
        airports.add(new Airport("Calicut International", "Kozhikode", 2, 3, 150000, true, 3000, 1988));
        airports.add(new Airport("Trivandrum International", "Thiruvananthapuram", 2, 2, 100000, true, 2200, 1991));
        airports.add(new Airport("Mangalore International", "Mangalore", 1, 1, 50000, true, 1000, 2005));
        airports.add(new Airport("Pune International", "Pune", 2, 2, 180000, true, 3500, 1966));
        airports.add(new Airport("Ahmedabad International", "Ahmedabad", 2, 2, 200000, true, 4000, 1937));
        airports.add(new Airport("Jaipur International", "Jaipur", 1, 1, 90000, true, 2000, 1973));
        airports.add(new Airport("Lucknow International", "Lucknow", 2, 2, 120000, true, 2800, 1966));
        airports.add(new Airport("Varanasi International", "Varanasi", 1, 1, 70000, true, 1500, 1964));

        return airports;
    }


    @Bean("P2")
    public List<Bakery> getBakeries() {
        List<Bakery> bakeries = new ArrayList<>();
        bakeries.add(new Bakery("Sweet Treats", "MG Road", 15, true, 120, 4.5, 9876543210L, 1998));
        bakeries.add(new Bakery("Bread Basket", "Brigade Road", 10, false, 80, 4.0, 8765432109L, 2005));
        bakeries.add(new Bakery("Fresh Bake", "Jayanagar", 12, true, 100, 4.7, 7654321098L, 2000));
        bakeries.add(new Bakery("Golden Crust", "Koramangala", 18, true, 150, 4.3, 6543210987L, 1995));
        bakeries.add(new Bakery("Morning Glory", "Indiranagar", 8, false, 60, 4.2, 5432109876L, 2010));
        bakeries.add(new Bakery("Cake Corner", "Whitefield", 20, true, 200, 4.6, 4321098765L, 2002));
        bakeries.add(new Bakery("Pastry Palace", "Malleshwaram", 14, true, 110, 4.4, 3210987654L, 1997));
        bakeries.add(new Bakery("Dough Delights", "BTM Layout", 11, false, 90, 4.1, 2109876543L, 2008));
        bakeries.add(new Bakery("Sweet Slice", "HSR Layout", 16, true, 140, 4.8, 1098765432L, 2003));
        bakeries.add(new Bakery("Baking Bliss", "Marathahalli", 13, true, 130, 4.5, 987654321L, 2006));
        bakeries.add(new Bakery("Flour Power", "Electronic City", 9, false, 70, 4.0, 876543210L, 2012));
        bakeries.add(new Bakery("Crumbly Corner", "Banashankari", 17, true, 160, 4.6, 765432109L, 1999));
        bakeries.add(new Bakery("Yeast Feast", "Rajajinagar", 10, true, 85, 4.3, 654321098L, 2001));
        bakeries.add(new Bakery("Bun Bonanza", "Vijayanagar", 12, false, 95, 4.2, 543210987L, 2007));
        bakeries.add(new Bakery("Oven Fresh", "JP Nagar", 15, true, 125, 4.7, 432109876L, 2004));
        return bakeries;
    }

    @Bean("P3")
    public List<Bank> getBanks() {
        List<Bank> banks = new ArrayList<>();
        banks.add(new Bank("State Bank", "MG Road", 123456789012L, 100, true, 500000.50, "Ramesh Kumar", 1950));
        banks.add(new Bank("HDFC Bank", "Whitefield", 987654321098L, 75, true, 300000.75, "Anita Sharma", 1990));
        banks.add(new Bank("ICICI Bank", "Koramangala", 456789012345L, 90, true, 450000.25, "Vikram Singh", 1994));
        banks.add(new Bank("Axis Bank", "Indiranagar", 789012345678L, 65, false, 250000.80, "Priya Menon", 1993));
        banks.add(new Bank("Kotak Mahindra", "Jayanagar", 234567890123L, 80, true, 380000.90, "Suresh Reddy", 2003));
        banks.add(new Bank("Punjab National", "Malleshwaram", 567890123456L, 110, true, 520000.30, "Geeta Patel", 1969));
        banks.add(new Bank("Canara Bank", "Banashankari", 890123456789L, 95, false, 280000.45, "Mohan Das", 1906));
        banks.add(new Bank("Bank of Baroda", "Rajajinagar", 12345678901L, 85, true, 410000.60, "Lata Devi", 1908));
        banks.add(new Bank("Yes Bank", "BTM Layout", 345678901234L, 70, true, 320000.15, "Arjun Rao", 2004));
        banks.add(new Bank("Federal Bank", "HSR Layout", 678901234567L, 60, false, 220000.70, "Meera Nair", 1931));
        banks.add(new Bank("Union Bank", "Marathahalli", 901234567890L, 105, true, 480000.20, "Rajesh Gupta", 1919));
        banks.add(new Bank("Vijaya Bank", "Electronic City", 123456789012L, 55, true, 260000.85, "Sunita Joshi", 1931));
        banks.add(new Bank("Karur Vysya", "JP Nagar", 456789012345L, 88, false, 370000.40, "Karthik Babu", 1911));
        banks.add(new Bank("South Indian Bank", "Vijayanagar", 789012345678L, 72, true, 290000.95, "Divya Rani", 1929));
        banks.add(new Bank("City Union Bank", "Basaveshwaranagar", 234567890123L, 68, true, 340000.10, "Prakash Pai", 1904));
        return banks;
    }

    @Bean("P4")
    public List<Bicycle> getBicycles() {
        List<Bicycle> bicycles = new ArrayList<>();
        bicycles.add(new Bicycle("Giant", "Mountain", 21, 26.0, 14.5, "Red", 15000.0, "Disc"));
        bicycles.add(new Bicycle("Trek", "Road", 18, 28.0, 12.0, "Blue", 25000.0, "Caliper"));
        bicycles.add(new Bicycle("Specialized", "Hybrid", 24, 27.5, 13.2, "Green", 18000.0, "Disc"));
        bicycles.add(new Bicycle("Scott", "MTB", 27, 29.0, 15.8, "Black", 32000.0, "Hydraulic"));
        bicycles.add(new Bicycle("Merida", "City", 7, 26.0, 11.5, "White", 12000.0, "V-Brake"));
        bicycles.add(new Bicycle("Cannondale", "Road", 22, 700.0, 8.9, "Yellow", 45000.0, "Disc"));
        bicycles.add(new Bicycle("Orbea", "Gravel", 20, 650.0, 10.2, "Orange", 28000.0, "Disc"));
        bicycles.add(new Bicycle("Cube", "Touring", 24, 28.0, 14.0, "Silver", 22000.0, "Rim"));
        bicycles.add(new Bicycle("Kona", "Fat Bike", 10, 26.0, 16.5, "Matte Black", 35000.0, "Disc"));
        bicycles.add(new Bicycle("GT", "BMX", 1, 20.0, 9.8, "Pink", 8000.0, "V-Brake"));
        bicycles.add(new Bicycle("Santa Cruz", "Downhill", 27, 29.0, 17.2, "Purple", 65000.0, "Hydraulic"));
        bicycles.add(new Bicycle("Raleigh", "Classic", 3, 26.0, 12.8, "Brown", 14000.0, "Coaster"));
        bicycles.add(new Bicycle("Fuji", "Track", 1, 700.0, 8.5, "Gold", 30000.0, "Caliper"));
        bicycles.add(new Bicycle("Bianchi", "Road", 20, 700.0, 9.2, "Celeste", 40000.0, "Disc"));
        bicycles.add(new Bicycle("Pinarello", "Racing", 22, 700.0, 7.8, "Blue", 75000.0, "Disc"));
        return bicycles;
    }

    @Bean("P5")
    public List<Book> getBooks() {
        List<Book> books = new ArrayList<>();
        books.add(new Book("The Alchemist", "Paulo Coelho", 208, "Fiction", 299.99, "HarperOne", 1, "English"));
        books.add(new Book("Thinking, Fast and Slow", "Daniel Kahneman", 499, "Psychology", 499.00, "Farrar", 1, "English"));
        books.add(new Book("Sapiens", "Yuval Noah Harari", 443, "History", 599.00, "Harper", 1, "English"));
        books.add(new Book("Atomic Habits", "James Clear", 320, "Self-Help", 399.00, "Penguin", 1, "English"));
        books.add(new Book("1984", "George Orwell", 328, "Dystopian", 299.00, "Secker", 1, "English"));
        books.add(new Book("To Kill a Mockingbird", "Harper Lee", 281, "Fiction", 350.00, "Lippincott", 1, "English"));
        books.add(new Book("The Great Gatsby", "F. Scott Fitzgerald", 180, "Fiction", 250.00, "Scribner", 1, "English"));
        books.add(new Book("Pride and Prejudice", "Jane Austen", 432, "Romance", 299.00, "T Egerton", 1, "English"));
        books.add(new Book("The Catcher in the Rye", "J.D. Salinger", 277, "Fiction", 349.00, "Little Brown", 1, "English"));
        books.add(new Book("Brave New World", "Aldous Huxley", 288, "Dystopian", 399.00, "Chatto", 1, "English"));
        books.add(new Book("The Hobbit", "J.R.R. Tolkien", 310, "Fantasy", 450.00, "Allen & Unwin", 1, "English"));
        books.add(new Book("Dune", "Frank Herbert", 412, "Sci-Fi", 599.00, "Chilton", 1, "English"));
        books.add(new Book("Fahrenheit 451", "Ray Bradbury", 249, "Dystopian", 299.00, "Ballantine", 1, "English"));
        books.add(new Book("Animal Farm", "George Orwell", 112, "Satire", 199.00, "Secker", 1, "English"));
        books.add(new Book("Lord of the Rings", "J.R.R. Tolkien", 1178, "Fantasy", 999.00, "Allen & Unwin", 1, "English"));
        return books;
    }

    @Bean("P6")
    public List<Bus> getBuses() {
        List<Bus> buses = new ArrayList<>();
        buses.add(new Bus("Volvo", "City Center to Airport", 40, true, 150.0, 2018, "Ravi Kumar", true));
        buses.add(new Bus("Ashok Leyland", "Station to Mall", 50, false, 180.0, 2015, "Suresh Patil", false));
        buses.add(new Bus("Tata Motors", "BTM to Electronic City", 45, true, 160.0, 2020, "Anil Yadav", true));
        buses.add(new Bus("Mahindra", "Koramangala to Whitefield", 42, false, 170.0, 2017, "Vijay Singh", false));
        buses.add(new Bus("Eicher", "Jayanagar to Malleshwaram", 48, true, 155.0, 2019, "Ramesh Gowda", true));
        buses.add(new Bus("BharatBenz", "Indiranagar to HSR", 55, true, 200.0, 2021, "Prakash Shetty", true));
        buses.add(new Bus("Scania", "MG Road to Brigade Road", 38, true, 140.0, 2016, "Mohan Das", false));
        buses.add(new Bus("Force Motors", "Banashankari to JP Nagar", 52, false, 165.0, 2014, "Geeta Devi", true));
        buses.add(new Bus("Kamataka RTC", "Rajajinagar to Vijayanagar", 60, false, 190.0, 2013, "Sunita Rani", false));
        buses.add(new Bus("BMW Coaches", "Marathahalli to Bellandur", 35, true, 130.0, 2022, "Arjun Reddy", true));
        buses.add(new Bus("Leyland Metro", "Basaveshwaranagar to Yeshwanthpur", 47, false, 175.0, 2018, "Kavya Nair", false));
        buses.add(new Bus("Volvo 9400", "Airport to Silk Board", 44, true, 145.0, 2020, "Siddharth Pai", true));
        buses.add(new Bus("Tata Starbus", "Hebbal to KR Puram", 50, true, 185.0, 2019, "Divya Sharma", true));
        buses.add(new Bus("Eicher Pro", "Yelahanka to Hebbal", 41, false, 152.0, 2017, "Rajesh Kumar", false));
        buses.add(new Bus("Mercedes Benz", "ITPL to Whitefield", 39, true, 135.0, 2021, "Priya Menon", true));
        return buses;
    }

    @Bean("P7")
    public List<Camera> getCameras() {
        List<Camera> cameras = new ArrayList<>();
        cameras.add(new Camera("Sony Alpha", "Sony", 12, "DSLR", 2021, 1.5, 75000.0, "English"));
        cameras.add(new Camera("Canon EOS", "Canon", 15, "Mirrorless", 2020, 1.3, 68000.0, "English"));
        cameras.add(new Camera("Nikon Z6", "Nikon", 18, "Mirrorless", 2019, 1.8, 72000.0, "English"));
        cameras.add(new Camera("Fujifilm X-T4", "Fujifilm", 20, "Mirrorless", 2020, 1.2, 65000.0, "English"));
        cameras.add(new Camera("Panasonic Lumix", "Panasonic", 22, "Mirrorless", 2021, 1.4, 59000.0, "English"));
        cameras.add(new Camera("Olympus OM-D", "Olympus", 16, "Mirrorless", 2019, 1.6, 48000.0, "English"));
        cameras.add(new Camera("Sigma fp", "Sigma", 24, "Mirrorless", 2020, 1.1, 55000.0, "English"));
        cameras.add(new Camera("Leica SL2", "Leica", 47, "Mirrorless", 2019, 2.0, 150000.0, "English"));
        cameras.add(new Camera("Sony RX100", "Sony", 20, "Compact", 2021, 0.8, 35000.0, "English"));
        cameras.add(new Camera("Canon G7X", "Canon", 18, "Compact", 2020, 0.9, 32000.0, "English"));
        cameras.add(new Camera("GoPro Hero10", "GoPro", 23, "Action", 2021, 0.5, 28000.0, "English"));
        cameras.add(new Camera("DJI Osmo", "DJI", 12, "Pocket", 2020, 0.6, 22000.0, "English"));
        cameras.add(new Camera("Insta360 One", "Insta360", 8, "360", 2021, 1.0, 40000.0, "English"));
        cameras.add(new Camera("Blackmagic Pocket", "Blackmagic", 25, "Cinema", 2020, 2.5, 85000.0, "English"));
        cameras.add(new Camera("RED Komodo", "RED", 40, "Cinema", 2021, 3.0, 250000.0, "English"));
        return cameras;
    }

    @Bean("P8")
    public List<College> getColleges() {
        List<College> colleges = new ArrayList<>();
        colleges.add(new College("ABC College", "State University", 10, 2000, 4.2, 1985, "Bangalore", true));
        colleges.add(new College("XYZ College", "Central University", 15, 2500, 4.5, 1990, "Mumbai", false));
        colleges.add(new College("BMS College", "VTU", 14, 4500, 4.2, 1946, "Bangalore", false));
        colleges.add(new College("Christ University", "Deemed", 18, 6000, 4.6, 1969, "Bangalore", true));
        colleges.add(new College("NITK Surathkal", "VTU", 10, 3500, 4.7, 1960, "Mangalore", true));
        colleges.add(new College("MIT Manipal", "Deemed", 16, 5500, 4.4, 1957, "Manipal", true));
        colleges.add(new College("VIT Vellore", "Deemed", 20, 8000, 4.5, 1984, "Vellore", true));
        colleges.add(new College("IIT Madras", "Autonomous", 12, 3000, 4.9, 1959, "Chennai", true));
        colleges.add(new College("SRM Institute", "Deemed", 22, 9000, 4.3, 1985, "Chennai", true));
        colleges.add(new College("COEP Pune", "Autonomous", 13, 4200, 4.4, 1854, "Pune", false));
        colleges.add(new College("VJTI Mumbai", "Autonomous", 11, 3800, 4.3, 1887, "Mumbai", true));
        colleges.add(new College("NIT Trichy", "Autonomous", 9, 3200, 4.8, 1964, "Trichy", true));
        colleges.add(new College("IIT Bombay", "Autonomous", 8, 2800, 4.9, 1958, "Mumbai", true));
        colleges.add(new College("Anna University", "State", 25, 10000, 4.2, 1978, "Chennai", true));
        colleges.add(new College("Thapar University", "Deemed", 17, 5800, 4.4, 1956, "Patiala", true));
        return colleges;
    }

    @Bean("P9")
    public List<Company> getCompanies() {
        List<Company> companies = new ArrayList<>();
        companies.add(new Company("TechSoft", "Software", 500, "Bangalore", 50.0, 2000, "Sundar Pichai", true));
        companies.add(new Company("AutoWorks", "Automobile", 300, "Pune", 30.0, 1995, "Anil Kumar", false));
        companies.add(new Company("Wipro", "IT", 200000, "Bangalore", 12000.0, 1945, "Srinivas Pallia", true));
        companies.add(new Company("HCL Tech", "IT", 220000, "Noida", 14000.0, 1976, "C Vijayakumar", true));
        companies.add(new Company("Tech Mahindra", "IT", 150000, "Pune", 8000.0, 1986, "CP Gurnani", true));
        companies.add(new Company("L&T Infotech", "IT", 80000, "Mumbai", 6000.0, 1997, "Debashis Chatterjee", true));
        companies.add(new Company("Mphasis", "IT", 30000, "Bangalore", 2000.0, 1998, "Mukund Rajaram", true));
        companies.add(new Company("Reliance Jio", "Telecom", 40000, "Mumbai", 10000.0, 2010, "Mukesh Ambani", true));
        companies.add(new Company("Bharti Airtel", "Telecom", 25000, "Delhi", 9000.0, 1995, "Gopal Vittal", true));
        companies.add(new Company("Tata Steel", "Steel", 65000, "Jamshedpur", 35000.0, 1907, "TV Narendran", true));
        companies.add(new Company("JSW Steel", "Steel", 40000, "Mumbai", 20000.0, 1994, "Sajjan Jindal", true));
        companies.add(new Company("Adani Group", "Infra", 35000, "Ahmedabad", 15000.0, 1988, "Gautam Adani", true));
        companies.add(new Company("UltraTech", "Cement", 30000, "Mumbai", 12000.0, 2001, "K Cement", true));
        companies.add(new Company("Apollo Hospitals", "Healthcare", 80000, "Chennai", 18000.0, 1983, "Prathap Reddy", true));
        companies.add(new Company("HDFC Bank", "Banking", 200000, "Mumbai", 50000.0, 1994, "Atanu Chakraborty", true));
        return companies;
    }

    @Bean("P10")
    public List<Game> getGames() {
        List<Game> games = new ArrayList<>();
        games.add(new Game("Valorant", "FPS", 4.8, "PC", 2020, 20.0, true, "Riot Games"));
        games.add(new Game("Among Us", "Puzzle", 4.3, "Mobile", 2018, 0.25, true, "InnerSloth"));
        games.add(new Game("GTA V", "Open World", 4.9, "PC/PS", 2013, 90.0, true, "Rockstar"));
        games.add(new Game("Minecraft", "Sandbox", 4.7, "All", 2011, 1.0, true, "Mojang"));
        games.add(new Game("Fortnite", "Battle Royale", 4.6, "All", 2017, 80.0, true, "Epic Games"));
        games.add(new Game("Cyberpunk 2077", "RPG", 4.4, "PC/PS", 2020, 70.0, false, "CD Projekt"));
        games.add(new Game("Red Dead Redemption 2", "Open World", 4.9, "PC/PS", 2018, 120.0, true, "Rockstar"));
        games.add(new Game("The Witcher 3", "RPG", 4.9, "PC/PS", 2015, 50.0, false, "CD Projekt"));
        games.add(new Game("Elden Ring", "Action RPG", 4.8, "PC/PS", 2022, 60.0, false, "FromSoftware"));
        games.add(new Game("God of War", "Action", 4.9, "PS", 2018, 45.0, false, "Santa Monica"));
        games.add(new Game("Call of Duty MW2", "FPS", 4.7, "PC/PS", 2022, 130.0, true, "Infinity Ward"));
        games.add(new Game("FIFA 23", "Sports", 4.3, "All", 2022, 50.0, true, "EA Sports"));
        games.add(new Game("Candy Crush", "Puzzle", 4.2, "Mobile", 2012, 0.15, true, "King"));
        games.add(new Game("PUBG Mobile", "Battle Royale", 4.6, "Mobile", 2018, 2.0, true, "Tencent"));
        games.add(new Game("League of Legends", "MOBA", 4.7, "PC", 2009, 16.0, true, "Riot Games"));
        return games;
    }

    @Bean("P11")
    public List<Gym> getGyms() {
        List<Gym> gyms = new ArrayList<>();
        gyms.add(new Gym("Fitness Plus", "Koramangala", 10, true, 1500.0, 20, "6 AM", "10 PM"));
        gyms.add(new Gym("Muscle Factory", "Indiranagar", 8, false, 1200.0, 15, "7 AM", "9 PM"));
        gyms.add(new Gym("Cult Fit", "Whitefield", 10, false, 1500.0, 20, "6 AM", "10 PM"));
        gyms.add(new Gym("MuscleBlaze", "Jayanagar", 8, true, 2000.0, 18, "7 AM", "9 PM"));
        gyms.add(new Gym("PowerZone", "BTM", 14, true, 2200.0, 22, "5 AM", "11 PM"));
        gyms.add(new Gym("FitIndia", "HSR Layout", 11, false, 1800.0, 15, "6 AM", "10 PM"));
        gyms.add(new Gym("BodyCraft", "Marathahalli", 9, true, 2800.0, 28, "5 AM", "12 AM"));
        gyms.add(new Gym("IronMan Gym", "Electronic City", 13, true, 1900.0, 20, "6 AM", "10 PM"));
        gyms.add(new Gym("Flex Fitness", "Malleshwaram", 10, false, 1600.0, 16, "7 AM", "9 PM"));
        gyms.add(new Gym("CrossFit Zone", "Banashankari", 16, true, 3500.0, 35, "6 AM", "10 PM"));
        gyms.add(new Gym("YogaFit", "Rajajinagar", 7, true, 1200.0, 12, "6 AM", "9 PM"));
        gyms.add(new Gym("PowerHouse", "Vijayanagar", 12, true, 2400.0, 24, "5 AM", "11 PM"));
        gyms.add(new Gym("FitZone", "JP Nagar", 9, false, 1700.0, 17, "7 AM", "10 PM"));
        gyms.add(new Gym("MuscleMax", "Basaveshwaranagar", 14, true, 2600.0, 26, "6 AM", "11 PM"));
        gyms.add(new Gym("Elite Fitness", "Yeshwanthpur", 11, true, 2300.0, 22, "5 AM", "10 PM"));
        return gyms;
    }

    @Bean("P12")
    public List<Hospital> getHospitals() {
        List<Hospital> hospitals = new ArrayList<>();
        hospitals.add(new Hospital("City Hospital", "Bangalore", 50, 100, 200, true, 1975, 9876543210L));
        hospitals.add(new Hospital("Global Health", "Delhi", 80, 150, 300, false, 1980, 8765432109L));
        hospitals.add(new Hospital("Fortis Hospital", "Bangalore", 150, 300, 800, true, 1996, 7654321098L));
        hospitals.add(new Hospital("Manipal Hospital", "Bangalore", 120, 250, 600, true, 1991, 6543210987L));
        hospitals.add(new Hospital("Aster CMI", "Bangalore", 180, 350, 1000, true, 2015, 5432109876L));
        hospitals.add(new Hospital("Columbia Asia", "Bangalore", 100, 200, 500, false, 2005, 4321098765L));
        hospitals.add(new Hospital("Sakra World", "Bangalore", 140, 280, 700, true, 2014, 3210987654L));
        hospitals.add(new Hospital("Sparsh Hospital", "Bangalore", 110, 220, 550, true, 2006, 2109876543L));
        hospitals.add(new Hospital("Ramaiah Hospital", "Bangalore", 160, 320, 900, true, 1997, 1098765432L));
        hospitals.add(new Hospital("KMC Hospital", "Mangalore", 130, 260, 650, false, 1980, 987654321L));
        hospitals.add(new Hospital("Yenepoya Hospital", "Mangalore", 90, 180, 450, true, 1991, 876543210L));
        hospitals.add(new Hospital("Father Muller", "Mangalore", 105, 210, 500, true, 1880, 765432109L));
        hospitals.add(new Hospital("AIIMS Delhi", "Delhi", 500, 1000, 3000, true, 1956, 654321098L));
        hospitals.add(new Hospital("PGIMER", "Chandigarh", 400, 800, 2500, true, 1962, 543210987L));
        hospitals.add(new Hospital("CMC Vellore", "Vellore", 350, 700, 2200, true, 1900, 432109876L));
        return hospitals;
    }

    @Bean("P13")
    public List<Hotel> getHotels() {
        List<Hotel> hotels = new ArrayList<>();
        hotels.add(new Hotel("Grand Plaza", 120, "Bangalore", 4.5, true, true, 3500.0, 75));
        hotels.add(new Hotel("Royal Stay", 90, "Mumbai", 4.0, true, false, 2800.0, 60));
        hotels.add(new Hotel("The Oberoi", 180, "Bangalore", 4.9, true, true, 15000.0, 200));
        hotels.add(new Hotel("JW Marriott", 220, "Bangalore", 4.6, true, true, 9000.0, 280));
        hotels.add(new Hotel("Leela Palace", 300, "Bangalore", 4.8, true, true, 18000.0, 400));
        hotels.add(new Hotel("Taj Lands End", 400, "Mumbai", 4.7, true, true, 11000.0, 500));
        hotels.add(new Hotel("JW Marriott Mumbai", 350, "Mumbai", 4.6, true, true, 9500.0, 450));
        hotels.add(new Hotel("ITC Grand Central", 280, "Mumbai", 4.8, true, true, 13000.0, 350));
        hotels.add(new Hotel("The Taj Mahal Palace", 500, "Mumbai", 4.9, true, true, 20000.0, 600));
        hotels.add(new Hotel("Oberoi Mumbai", 320, "Mumbai", 4.7, true, true, 14000.0, 380));
        hotels.add(new Hotel("Trident Chennai", 150, "Chennai", 4.5, true, false, 7000.0, 180));
        hotels.add(new Hotel("ITC Grand Chola", 400, "Chennai", 4.8, true, true, 16000.0, 450));
        hotels.add(new Hotel("Taj Coromandel", 200, "Chennai", 4.6, true, true, 8500.0, 220));
        hotels.add(new Hotel("Hyatt Regency", 180, "Chennai", 4.5, true, false, 7500.0, 200));
        hotels.add(new Hotel("Park Hyatt", 220, "Chennai", 4.7, true, true, 12000.0, 260));
        return hotels;
    }

    @Bean("P14")
    public List<House> getHouses() {
        List<House> houses = new ArrayList<>();
        houses.add(new House("John Doe", "Whitefield", 2, 5, true, 1800.0, 8000000.0, 2010));
        houses.add(new House("Jane Smith", "Koramangala", 3, 7, false, 2500.0, 12000000.0, 2015));
        houses.add(new House("Amit Patel", "Indiranagar", 4, 6, false, 2800.0, 18000000.0, 2020));
        houses.add(new House("Sneha Reddy", "Jayanagar", 2, 3, true, 1500.0, 6500000.0, 2012));
        houses.add(new House("Vikram Singh", "HSR Layout", 3, 4, true, 2000.0, 9500000.0, 2016));
        houses.add(new House("Divya Nair", "BTM Layout", 2, 3, false, 1400.0, 5500000.0, 2014));
        houses.add(new House("Rajesh Gowda", "Marathahalli", 4, 5, true, 2500.0, 14000000.0, 2019));
        houses.add(new House("Meera Joshi", "Electronic City", 3, 4, true, 1900.0, 7500000.0, 2017));
        houses.add(new House("Karthik Babu", "Malleshwaram", 5, 7, false, 3200.0, 22000000.0, 2021));
        houses.add(new House("Anita Devi", "Banashankari", 2, 3, true, 1600.0, 7000000.0, 2013));
        houses.add(new House("Suresh Pai", "Rajajinagar", 3, 5, true, 2100.0, 10000000.0, 2016));
        houses.add(new House("Geeta Rani", "Vijayanagar", 4, 6, false, 2700.0, 16000000.0, 2020));
        houses.add(new House("Mohan Das", "JP Nagar", 2, 4, true, 1700.0, 7800000.0, 2015));
        houses.add(new House("Lata Menon", "Basaveshwaranagar", 3, 5, true, 2300.0, 13000000.0, 2018));
        houses.add(new House("Arjun Rao", "Yeshwanthpur", 4, 6, true, 2900.0, 19000000.0, 2022));
        return houses;
    }

    @Bean("P15")
    public List<Laptop> getLaptops() {
        List<Laptop> laptops = new ArrayList<>();
        laptops.add(new Laptop("Dell", "Inspiron", 55000, 8, 512, "Intel i5", 2.1, "Black"));
        laptops.add(new Laptop("HP", "Pavilion", 65000, 16, 1024, "Intel i7", 1.8, "Silver"));
        laptops.add(new Laptop("Lenovo", "ThinkPad X1", 110000, 32, 1024, "i7 11th", 1.4, "Carbon Black"));
        laptops.add(new Laptop("Apple", "MacBook Air", 105000, 16, 512, "M2", 1.24, "Space Gray"));
        laptops.add(new Laptop("Asus", "ZenBook 14", 85000, 16, 512, "Ryzen 7", 1.3, "Pine Grey"));
        laptops.add(new Laptop("Acer", "Predator Helios", 130000, 32, 1024, "i9 12th", 2.5, "Black"));
        laptops.add(new Laptop("MSI", "CreatorPro", 140000, 64, 2048, "i9 12th", 2.1, "White"));
        laptops.add(new Laptop("Razer", "Blade 15", 160000, 32, 1024, "i7 12th", 2.0, "Mercury"));
        laptops.add(new Laptop("Samsung", "Galaxy Book", 90000, 16, 512, "i7 11th", 1.1, "Gray"));
        laptops.add(new Laptop("Microsoft", "Surface Laptop", 115000, 16, 512, "i7 11th", 1.3, "Platinum"));
        laptops.add(new Laptop("Dell", "Inspiron 15", 55000, 8, 512, "i5 11th", 1.8, "Black"));
        laptops.add(new Laptop("HP", "Pavilion 14", 65000, 16, 512, "Ryzen 5", 1.4, "Silver"));
        laptops.add(new Laptop("Lenovo", "IdeaPad 3", 45000, 8, 256, "i5 11th", 1.6, "Arctic Grey"));
        laptops.add(new Laptop("Acer", "Aspire 5", 50000, 8, 512, "i5 12th", 1.7, "Charcoal Black"));
        laptops.add(new Laptop("Asus", "VivoBook 15", 60000, 16, 512, "Ryzen 7", 1.8, "Cool Silver"));
        return laptops;
    }

    @Bean("P16")
    public List<Library> getLibraries() {
        List<Library> libraries = new ArrayList<>();
        libraries.add(new Library("City Library", "MG Road", 50000, 20, true, 5000, 1990, "9 AM - 7 PM"));
        libraries.add(new Library("Central Library", "Brigade Road", 75000, 30, false, 7000, 1985, "8 AM - 8 PM"));
        libraries.add(new Library("Raja Ram Mohan", "Jayanagar", 40000, 20, true, 8000, 1965, "10 AM-6 PM"));
        libraries.add(new Library("Bombay Karnataka", "Kempegowda Rd", 35000, 18, false, 7000, 1955, "9 AM-7 PM"));
        libraries.add(new Library("Tagore Cultural", "Basavanagudi", 28000, 15, true, 6000, 1970, "10 AM-8 PM"));
        libraries.add(new Library("City Central", "Shivajinagar", 45000, 22, false, 9000, 1980, "9 AM-6 PM"));
        libraries.add(new Library("University Library", "Malleshwaram", 60000, 30, true, 12000, 1920, "8 AM-8 PM"));
        libraries.add(new Library("District Library", "Jayanagar", 32000, 16, false, 6500, 1968, "10 AM-7 PM"));
        libraries.add(new Library("Working Women's", "Koramangala", 25000, 12, true, 5000, 1975, "9 AM-6 PM"));
        libraries.add(new Library("Seshadripuram", "Malleshwaram", 38000, 19, false, 7500, 1960, "10 AM-8 PM"));
        libraries.add(new Library("National Library", "Kolkata", 2000000, 100, true, 50000, 1836, "9 AM-7 PM"));
        libraries.add(new Library("Delhi Public", "Delhi", 150000, 50, true, 25000, 1951, "10 AM-8 PM"));
        libraries.add(new Library("Asiatic Society", "Kolkata", 80000, 25, true, 10000, 1784, "11 AM-6 PM"));
        libraries.add(new Library("Connemara", "Chennai", 650000, 40, true, 20000, 1896, "9 AM-7 PM"));
        libraries.add(new Library("Khuda Bakhsh", "Patna", 210000, 30, false, 15000, 1891, "10 AM-6 PM"));
        return libraries;
    }

    @Bean("P17")
    public List<MobilePhone> getMobilePhones() {
        List<MobilePhone> phones = new ArrayList<>();
        phones.add(new MobilePhone("Samsung", "Galaxy S21", 6.2, 4000, 8, 256, 70000.0, "Phantom Gray"));
        phones.add(new MobilePhone("Apple", "iPhone 13", 6.1, 3095, 6, 128, 90000.0, "Midnight"));
        phones.add(new MobilePhone("Google", "Pixel 8", 6.2, 4575, 8, 256, 65000.0, "Obsidian"));
        phones.add(new MobilePhone("OnePlus", "12", 6.8, 5400, 16, 512, 70000.0, "Silky Black"));
        phones.add(new MobilePhone("Xiaomi", "14 Pro", 6.73, 4880, 12, 256, 85000.0, "Titanium Black"));
        phones.add(new MobilePhone("Vivo", "X100 Pro", 6.78, 5400, 16, 512, 90000.0, "Asteroid Black"));
        phones.add(new MobilePhone("Oppo", "Find X7", 6.78, 5000, 12, 256, 78000.0, "Black"));
        phones.add(new MobilePhone("Realme", "GT5 Pro", 6.78, 6500, 16, 512, 60000.0, "Titanium"));
        phones.add(new MobilePhone("Motorola", "Edge 50 Pro", 6.7, 4500, 12, 256, 55000.0, "Black Beauty"));
        phones.add(new MobilePhone("Nothing", "Phone 2", 6.7, 4700, 12, 512, 50000.0, "White"));
        phones.add(new MobilePhone("iQOO", "12 Pro", 6.78, 4880, 16, 512, 65000.0, "Legend"));
        phones.add(new MobilePhone("Honor", "Magic 6 Pro", 6.8, 5600, 12, 512, 72000.0, "Black"));
        phones.add(new MobilePhone("Nokia", "G42", 6.56, 5000, 8, 256, 18000.0, "Gray"));
        phones.add(new MobilePhone("Sony", "Xperia 5 V", 6.1, 5000, 8, 128, 85000.0, "Black"));
        phones.add(new MobilePhone("Asus", "ROG Phone 8", 6.78, 5500, 16, 512, 95000.0, "Phantom Black"));
        return phones;
    }

    @Bean("P18")
    public List<Movie> getMovies() {
        List<Movie> movies = new ArrayList<>();
        movies.add(new Movie("Inception", "Christopher Nolan", 148, "Sci-Fi", 8.8, 2010, "English", 160_000_000));
        movies.add(new Movie("The Dark Knight", "Christopher Nolan", 152, "Action", 9.0, 2008, "English", 185_000_000));
        movies.add(new Movie("Interstellar", "Christopher Nolan", 169, "Sci-Fi", 8.7, 2014, "English", 165000000.0));
        movies.add(new Movie("Oppenheimer", "Christopher Nolan", 180, "Biography", 8.4, 2023, "English", 100000000.0));
        movies.add(new Movie("Avengers Endgame", "Russo Brothers", 181, "Action", 8.4, 2019, "English", 356000000.0));
        movies.add(new Movie("Spider-Man No Way Home", "Jon Watts", 148, "Action", 8.2, 2021, "English", 200000000.0));
        movies.add(new Movie("RRR", "SS Rajamouli", 187, "Action", 7.8, 2022, "Telugu", 72000000.0));
        movies.add(new Movie("Baahubali 2", "SS Rajamouli", 167, "Action", 8.2, 2017, "Telugu", 180000000.0));
        movies.add(new Movie("Dangal", "Nitesh Tiwari", 161, "Biography", 8.3, 2016, "Hindi", 70000000.0));
        movies.add(new Movie("3 Idiots", "Rajkumar Hirani", 170, "Comedy", 8.4, 2009, "Hindi", 25000000.0));
        movies.add(new Movie("Lagaan", "Ashutosh Gowariker", 224, "Sports", 8.1, 2001, "Hindi", 11000000.0));
        movies.add(new Movie("Parasite", "Bong Joon-ho", 132, "Thriller", 8.5, 2019, "Korean", 11000000.0));
        movies.add(new Movie("Schindler's List", "Steven Spielberg", 195, "History", 9.0, 1993, "English", 22000000.0));
        movies.add(new Movie("The Godfather", "Francis Ford Coppola", 175, "Crime", 9.2, 1972, "English", 6000000.0));
        movies.add(new Movie("Pulp Fiction", "Quentin Tarantino", 154, "Crime", 8.9, 1994, "English", 8000000.0));
        return movies;
    }

    @Bean("P19")
    public List<MusicAlbum> getMusicAlbums() {
        List<MusicAlbum> albums = new ArrayList<>();
        albums.add(new MusicAlbum("Abbey Road", "The Beatles", 17, "Rock", 1969, 47.23, 299.99, "English"));
        albums.add(new MusicAlbum("Thriller", "Michael Jackson", 9, "Pop", 1982, 42.19, 399.99, "English"));
        albums.add(new MusicAlbum("Back in Black", "AC/DC", 10, "Rock", 1980, 42.0, 299.99, "English"));
        albums.add(new MusicAlbum("The Dark Side", "Pink Floyd", 10, "Rock", 1973, 43.0, 349.99, "English"));
        albums.add(new MusicAlbum("Nevermind", "Nirvana", 13, "Grunge", 1991, 42.0, 299.99, "English"));
        albums.add(new MusicAlbum("Rumours", "Fleetwood Mac", 11, "Pop Rock", 1977, 40.0, 279.99, "English"));
        albums.add(new MusicAlbum("The Bodyguard", "Whitney Houston", 11, "Pop", 1992, 46.0, 349.99, "English"));
        albums.add(new MusicAlbum("Bad", "Michael Jackson", 11, "Pop", 1987, 48.0, 399.99, "English"));
        albums.add(new MusicAlbum("21", "Adele", 11, "Pop", 2011, 48.0, 399.99, "English"));
        albums.add(new MusicAlbum("Born This Way", "Lady Gaga", 17, "Pop", 2011, 55.0, 349.99, "English"));
        albums.add(new MusicAlbum("Divide", "Ed Sheeran", 16, "Pop", 2017, 46.0, 299.99, "English"));
        albums.add(new MusicAlbum("Lemonade", "Beyoncé", 12, "R&B", 2016, 64.0, 399.99, "English"));
        albums.add(new MusicAlbum("Folklore", "Taylor Swift", 16, "Folk Pop", 2020, 63.0, 349.99, "English"));
        albums.add(new MusicAlbum("Sour", "Olivia Rodrigo", 11, "Pop", 2021, 34.0, 299.99, "English"));
        albums.add(new MusicAlbum("Midnights", "Taylor Swift", 13, "Pop", 2022, 44.0, 349.99, "English"));
        return albums;
    }

    @Bean("P20")
    public List<Park> getParks() {
        List<Park> parks = new ArrayList<>();
        parks.add(new Park("Cubbon Park", "Bangalore", true, true, 5000, 300.0, "6 AM", "9 PM"));
        parks.add(new Park("Lalbagh", "Bangalore", true, false, 4000, 240.0, "6 AM", "8 PM"));
        parks.add(new Park("Nandi Hills", "Bangalore", false, true, 2000, 150.0, "6 AM", "6 PM"));
        parks.add(new Park("Bannerghatta", "Bangalore", true, true, 8000, 1000.0, "9 AM", "5 PM"));
        parks.add(new Park("Sankey Tank", "Bangalore", false, true, 1500, 50.0, "6 AM", "8 PM"));
        parks.add(new Park("Ulsoor Lake Park", "Bangalore", true, false, 1200, 40.0, "6 AM", "7 PM"));
        parks.add(new Park("Jayanagar Park", "Bangalore", true, true, 800, 10.0, "5 AM", "10 PM"));
        parks.add(new Park("M.G. Road Park", "Bangalore", false, true, 600, 8.0, "6 AM", "9 PM"));
        parks.add(new Park("Marine Drive", "Mumbai", false, true, 3000, 200.0, "24 Hrs", "24 Hrs"));
        parks.add(new Park("Juhu Beach", "Mumbai", true, false, 2500, 180.0, "24 Hrs", "24 Hrs"));
        parks.add(new Park("Hanging Gardens", "Mumbai", true, true, 1000, 20.0, "5 AM", "10 PM"));
        parks.add(new Park("Sanjay Gandhi Park", "Mumbai", true, true, 15000, 2700.0, "7 AM", "7 PM"));
        parks.add(new Park("Eden Gardens", "Kolkata", false, true, 5000, 400.0, "6 AM", "8 PM"));
        parks.add(new Park("Maidan", "Kolkata", false, true, 10000, 1000.0, "24 Hrs", "24 Hrs"));
        parks.add(new Park("Brindavan Gardens", "Mysore", true, false, 3000, 150.0, "9 AM", "8 PM"));
        return parks;
    }

    @Bean("P21")
    public List<Pharmacy> getPharmacies() {
        List<Pharmacy> pharmacies = new ArrayList<>();
        pharmacies.add(new Pharmacy("HealthPlus", "MG Road", true, 10, 1000, 9876543210L, true, 1995));
        pharmacies.add(new Pharmacy("CareWell", "Brigade Road", false, 8, 850, 8765432109L, false, 2000));
        pharmacies.add(new Pharmacy("1mg", "Koramangala", true, 12, 1200, 7654321098L, true, 2015));
        pharmacies.add(new Pharmacy("Netmeds", "Indiranagar", true, 15, 1500, 6543210987L, true, 2012));
        pharmacies.add(new Pharmacy("PharmEasy", "Whitefield", true, 9, 900, 5432109876L, true, 2016));
        pharmacies.add(new Pharmacy("Medlife", "HSR Layout", false, 7, 700, 4321098765L, true, 2014));
        pharmacies.add(new Pharmacy("Guardian Pharmacy", "BTM Layout", true, 11, 1100, 3210987654L, false, 1998));
        pharmacies.add(new Pharmacy("Healthmug", "Marathahalli", true, 13, 1300, 2109876543L, true, 2010));
        pharmacies.add(new Pharmacy("Practo Pharmacy", "Electronic City", true, 10, 950, 1098765432L, true, 2018));
        pharmacies.add(new Pharmacy("Medikabazaar", "Malleshwaram", false, 6, 650, 987654321L, false, 2005));
        pharmacies.add(new Pharmacy("Aster Pharmacy", "Banashankari", true, 14, 1400, 876543210L, true, 2002));
        pharmacies.add(new Pharmacy("Care Hospitals", "Rajajinagar", false, 8, 800, 765432109L, false, 1990));
        pharmacies.add(new Pharmacy("Fortis Pharmacy", "Vijayanagar", true, 12, 1150, 654321098L, true, 1996));
        pharmacies.add(new Pharmacy("Manipal Pharmacy", "JP Nagar", true, 9, 920, 543210987L, true, 1991));
        pharmacies.add(new Pharmacy("Narayana Pharmacy", "Basaveshwaranagar", true, 11, 1050, 432109876L, true, 2000));
        return pharmacies;
    }

    @Bean("P22")
    public List<Printer> getPrinters() {
        List<Printer> printers = new ArrayList<>();
        printers.add(new Printer("HP", "LaserJet", true, 20, true, 15000.0, "M281fdw", 2));
        printers.add(new Printer("Canon", "InkJet", false, 15, false, 8000.0, "PIXMA", 1));
        printers.add(new Printer("Epson", "EcoTank", true, 20, true, 22000.0, "L3250", 2));
        printers.add(new Printer("Brother", "HL-L2350DW", false, 34, true, 15000.0, "HL-L2350DW", 1));
        printers.add(new Printer("Samsung", "Xpress", true, 28, true, 12000.0, "M3320ND", 2));
        printers.add(new Printer("Ricoh", "SP 330SFN", true, 30, true, 25000.0, "SP 330SFN", 3));
        printers.add(new Printer("Kyocera", "ECOSYS", false, 40, true, 30000.0, "P2040dn", 3));
        printers.add(new Printer("Xerox", "WorkCentre", true, 35, true, 35000.0, "6515", 2));
        printers.add(new Printer("Konica Minolta", "bizhub", true, 32, true, 40000.0, "C224i", 3));
        printers.add(new Printer("Toshiba", "e-STUDIO", true, 38, true, 28000.0, "2518A", 2));
        printers.add(new Printer("Panasonic", "KX-MB", true, 22, false, 9500.0, "2540", 1));
        printers.add(new Printer("Lexmark", "CS331", true, 26, true, 16000.0, "CS331dw", 2));
        printers.add(new Printer("OKI", "C542dn", true, 35, true, 32000.0, "C542dn", 3));
        printers.add(new Printer("Zebra", "ZD420", false, 150, true, 45000.0, "ZD420", 2));
        printers.add(new Printer("Dymo", "LabelWriter", false, 50, false, 8000.0, "450", 1));
        return printers;
    }

    @Bean("P23")
    public List<Refrigerator> getRefrigerators() {
        List<Refrigerator> refrigerators = new ArrayList<>();
        refrigerators.add(new Refrigerator("LG", 250, true, "5 Star", "Silver", 35000.0, 180.0, 70.0));
        refrigerators.add(new Refrigerator("Samsung", 190, false, "4 Star", "White", 28000.0, 160.0, 65.0));
        refrigerators.add(new Refrigerator("Whirlpool", 330, true, "5 Star", "Grey", 45000.0, 190.0, 70.0));
        refrigerators.add(new Refrigerator("Godrej", 240, true, "3 Star", "White", 25000.0, 165.0, 60.0));
        refrigerators.add(new Refrigerator("Haier", 420, true, "5 Star", "Stainless", 55000.0, 200.0, 75.0));
        refrigerators.add(new Refrigerator("Voltas Beko", 300, true, "4 Star", "Blue", 35000.0, 180.0, 68.0));
        refrigerators.add(new Refrigerator("Hitachi", 500, true, "5 Star", "Silver", 65000.0, 210.0, 80.0));
        refrigerators.add(new Refrigerator("Bosch", 360, true, "5 Star", "Black Steel", 70000.0, 195.0, 72.0));
        refrigerators.add(new Refrigerator("Electrolux", 280, false, "3 Star", "White", 32000.0, 170.0, 66.0));
        refrigerators.add(new Refrigerator("Panasonic", 410, true, "4 Star", "Glass Door", 48000.0, 205.0, 78.0));
        refrigerators.add(new Refrigerator("Sharp", 220, false, "2 Star", "Red", 22000.0, 162.0, 62.0));
        refrigerators.add(new Refrigerator("TCL", 340, true, "5 Star", "Gold", 40000.0, 185.0, 71.0));
        refrigerators.add(new Refrigerator("Lloyd", 270, true, "4 Star", "Grey", 29000.0, 172.0, 67.0));
        refrigerators.add(new Refrigerator("Videocon", 200, false, "3 Star", "White", 24000.0, 158.0, 64.0));
        refrigerators.add(new Refrigerator("Blue Star", 450, true, "5 Star", "Silver", 58000.0, 208.0, 79.0));
        return refrigerators;
    }

    @Bean("P24")
    public List<Restaurant> getRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        restaurants.add(new Restaurant("Spice Hub", "MG Road", 50, 25, "Indian", 4.3, true, 9876543210L));
        restaurants.add(new Restaurant("Pizzeria", "Brigade Road", 30, 15, "Italian", 4.8, false, 8765432109L));
        restaurants.add(new Restaurant("Empire", "Church Street", 40, 20, "Continental", 4.2, true, 7654321098L));
        restaurants.add(new Restaurant("Karavalli", "Residency Road", 35, 18, "Coastal", 4.7, false, 6543210987L));
        restaurants.add(new Restaurant("Mavalli Tiffin", "Lalbagh Road", 60, 30, "South Indian", 4.6, true, 5432109876L));
        restaurants.add(new Restaurant("Olive Bar", "Ashok Nagar", 25, 12, "Mediterranean", 4.8, false, 4321098765L));
        restaurants.add(new Restaurant("Toit", "Indiranagar", 45, 22, "Brew Pub", 4.9, true, 3210987654L));
        restaurants.add(new Restaurant("Social", "St Marks Road", 55, 28, "Fusion", 4.4, true, 2109876543L));
        restaurants.add(new Restaurant("Truffles", "Brigade Road", 38, 19, "Burgers", 4.5, true, 1098765432L));
        restaurants.add(new Restaurant("Farzi Cafe", "UB City", 32, 16, "Modern Indian", 4.6, false, 987654321L));
        restaurants.add(new Restaurant("By2 Coffee", "Jayanagar", 28, 14, "Cafe", 4.3, true, 876543210L));
        restaurants.add(new Restaurant("Arbor Brewing", "Whitefield", 42, 21, "Brew Pub", 4.7, true, 765432109L));
        restaurants.add(new Restaurant("Hatti Kaapi", "Malleshwaram", 65, 32, "South Indian", 4.4, true, 654321098L));
        restaurants.add(new Restaurant("Gufha", "Banashankari", 36, 18, "North Indian", 4.2, false, 543210987L));
        restaurants.add(new Restaurant("Vijayalaya's", "HSR Layout", 52, 26, "Chettinad", 4.8, true, 432109876L));
        return restaurants;
    }

    @Bean("P25")
    public List<Scooter> getScooters() {
        List<Scooter> scooters = new ArrayList<>();
        scooters.add(new Scooter("Honda", "Activa 6G", 109, 45.0, 65000.0, "Matte Black", 85, true));
        scooters.add(new Scooter("TVS", "Jupiter", 110, 50.0, 62000.0, "Metallic Red", 83, false));
        scooters.add(new Scooter("Suzuki", "Access 125", 124, 45.0, 80000.0, "Pearl Matte Black", 88, true));
        scooters.add(new Scooter("Hero", "Pleasure Plus", 110, 55.0, 70000.0, "Cool Mint Green", 82, true));
        scooters.add(new Scooter("Yamaha", "Fascino 125", 125, 52.0, 82000.0, "Cyber Green", 87, true));
        scooters.add(new Scooter("Bajaj", "Chetak", 125, 45.0, 100000.0, "Brooklyn Black", 90, true));
        scooters.add(new Scooter("Ather", "450X", 0, 90.0, 140000.0, "Cosmic Black", 90, true));
        scooters.add(new Scooter("Ola", "S1 Pro", 0, 118.0, 130000.0, "Metallic Black", 120, true));
        scooters.add(new Scooter("Simple", "One", 0, 212.0, 145000.0, "Nebula Red", 105, true));
        scooters.add(new Scooter("Bounce", "Infinity E1", 0, 85.0, 95000.0, "Red", 75, true));
        scooters.add(new Scooter("Honda", "Activa 125", 123, 47.0, 90000.0, "Matte Axis Grey", 92, true));
        scooters.add(new Scooter("TVS", "Ntorq 125", 124, 46.0, 88000.0, "Lightning Blue", 95, true));
        scooters.add(new Scooter("Suzuki", "Burgman Street", 125, 44.0, 92000.0, "Metallic Matte Black", 88, true));
        scooters.add(new Scooter("Hero", "Destini 125", 125, 56.0, 75000.0, "Stellar Blue", 85, true));
        scooters.add(new Scooter("Yamaha", "Ray ZR 125", 125, 51.0, 86000.0, "Racing Blue", 89, true));
        return scooters;
    }

    @Bean("P26")
    public List<Shop> getShops() {
        List<Shop> shops = new ArrayList<>();
        shops.add(new Shop("Raju", "Grocery", "Jayanagar", 50000.0, 10, 2005, true, 9876543210L));
        shops.add(new Shop("Meena", "Electronics", "Indiranagar", 150000.0, 15, 2010, false, 8765432109L));
        shops.add(new Shop("Suresh", "Clothing", "Koramangar", 80000.0, 8, 2008, true, 7654321098L));
        shops.add(new Shop("Priya", "Stationery", "Whitefield", 30000.0, 5, 2012, false, 6543210987L));
        shops.add(new Shop("Anil", "Pharmacy", "HSR Layout", 120000.0, 12, 2003, true, 5432109876L));
        shops.add(new Shop("Geeta", "Bakery", "BTM Layout", 45000.0, 6, 2007, true, 4321098765L));
        shops.add(new Shop("Vijay", "Hardware", "Marathahalli", 90000.0, 9, 2001, false, 3210987654L));
        shops.add(new Shop("Lata", "Jewelry", "Malleshwaram", 200000.0, 20, 1998, false, 2109876543L));
        shops.add(new Shop("Kiran", "Mobile Shop", "Electronic City", 180000.0, 18, 2011, true, 1098765432L));
        shops.add(new Shop("Sunita", "Book Store", "Banashankari", 60000.0, 7, 2006, false, 987654321L));
        shops.add(new Shop("Mohan", "Footwear", "Rajajinagar", 75000.0, 11, 2009, true, 876543210L));
        shops.add(new Shop("Divya", "Cosmetics", "Vijayanagar", 110000.0, 14, 2004, true, 765432109L));
        shops.add(new Shop("Ramesh", "Furniture", "JP Nagar", 250000.0, 25, 1999, false, 654321098L));
        shops.add(new Shop("Anita", "Vegetable", "Basaveshwaranagar", 35000.0, 4, 2013, true, 543210987L));
        shops.add(new Shop("Prakash", "Sports Goods", "Yeshwanthpur", 95000.0, 13, 2002, false, 432109876L));
        return shops;
    }

    @Bean("P27")
    public List<SmartWatch> getSmartWatches() {
        List<SmartWatch> watches = new ArrayList<>();
        watches.add(new SmartWatch("Apple", "Watch Series 7", 1.9, true, true, 18, "Silicone", 45000.0));
        watches.add(new SmartWatch("Samsung", "Galaxy Watch 4", 1.4, true, true, 24, "Leather", 25000.0));
        watches.add(new SmartWatch("Google", "Pixel Watch 2", 1.2, true, true, 24, "Silicone", 35000.0));
        watches.add(new SmartWatch("Garmin", "Venu 3", 1.4, true, true, 14, "Leather", 52000.0));
        watches.add(new SmartWatch("Fitbit", "Sense 2", 1.58, true, false, 6, "Silicone", 25000.0));
        watches.add(new SmartWatch("Huawei", "Watch GT 4", 1.43, true, true, 14, "Steel", 22000.0));
        watches.add(new SmartWatch("Amazfit", "GTR 4", 1.43, true, true, 14, "Leather", 18000.0));
        watches.add(new SmartWatch("OnePlus", "Watch 2", 1.43, true, true, 12, "Silicone", 20000.0));
        watches.add(new SmartWatch("Noise", "ColorFit Pro 5", 1.85, true, false, 7, "Silicone", 5000.0));
        watches.add(new SmartWatch("Boat", "Xtend Sport", 1.69, true, false, 7, "Silicone", 4500.0));
        watches.add(new SmartWatch("Fossil", "Gen 6", 1.28, true, true, 24, "Steel", 30000.0));
        watches.add(new SmartWatch("TicWatch", "Pro 5", 1.43, true, true, 80, "Silicone", 28000.0));
        watches.add(new SmartWatch("Xiaomi", "Watch S3", 1.43, true, true, 15, "Steel", 15000.0));
        watches.add(new SmartWatch("Realme", "Watch S2", 1.43, true, true, 20, "Leather", 12000.0));
        watches.add(new SmartWatch("Fire-Boltt", "Phoenix Ultra", 1.39, true, false, 7, "Metal", 4000.0));
        return watches;
    }

    @Bean("P28")
    public List<Speaker> getSpeakers() {
        List<Speaker> speakers = new ArrayList<>();
        speakers.add(new Speaker("Bose", "SoundLink", 30, true, false, 12000.0, "Black", 10));
        speakers.add(new Speaker("JBL", "Flip 5", 20, true, true, 6000.0, "Blue", 12));
        speakers.add(new Speaker("Sony", "SRS-XB43", 40, true, true, 15000.0, "Black", 24));
        speakers.add(new Speaker("Ultimate Ears", "Wonderboom 3", 14, true, true, 7000.0, "Blue", 14));
        speakers.add(new Speaker("Anker", "Soundcore 3", 24, true, true, 5000.0, "Black", 24));
        speakers.add(new Speaker("Tribit", "StormBox Micro 2", 10, true, true, 4500.0, "Red", 12));
        speakers.add(new Speaker("Marshall", "Emberton II", 20, true, false, 12000.0, "Cream", 34));
        speakers.add(new Speaker("Bang & Olufsen", "A1 2nd Gen", 30, true, true, 25000.0, "Gold", 18));
        speakers.add(new Speaker("Harman Kardon", "Onyx Studio 8", 50, true, false, 18000.0, "Black", 8));
        speakers.add(new Speaker("Audio Pro", "Addon C10 MkII", 80, true, false, 35000.0, "Walnut", -1));
        speakers.add(new Speaker("Sonos", "Roam 2", 8, true, true, 22000.0, "White", 10));
        speakers.add(new Speaker("Google", "Nest Mini 2", 15, true, false, 4500.0, "Charcoal", -1));
        speakers.add(new Speaker("Amazon", "Echo Dot 5", 20, true, false, 5000.0, "Blue", -1));
        speakers.add(new Speaker("Mi", "Portable Bluetooth", 16, true, true, 2000.0, "Blue", 13));
        speakers.add(new Speaker("Boat", "Stone 1200", 14, true, true, 3000.0, "Red", 9));
        return speakers;
    }

    @Bean("P29")
    public List<Stadium> getStadiums() {
        List<Stadium> stadiums = new ArrayList<>();
        stadiums.add(new Stadium("Wankhede", "Mumbai", 33000, "Mumbai Indians", false, 1974, 25000.0, true));
        stadiums.add(new Stadium("M. Chinnaswamy", "Bangalore", 40000, "Royal Challengers", true, 1969, 28000.0, true));
        stadiums.add(new Stadium("Eden Gardens", "Kolkata", 68000, "KKR", true, 1864, 50000.0, true));
        stadiums.add(new Stadium("Feroz Shah Kotla", "Delhi", 41000, "DC", true, 1883, 20000.0, true));
        stadiums.add(new Stadium("DY Patil", "Navi Mumbai", 55000, "MI", true, 2008, 35000.0, true));
        stadiums.add(new Stadium("Ekana", "Lucknow", 50000, "LSG", true, 2017, 30000.0, true));
        stadiums.add(new Stadium("Narendra Modi", "Ahmedabad", 132000, "GT", true, 1982, 80000.0, true));
        stadiums.add(new Stadium("Punjab Cricket", "Mohali", 26000, "PBKS", true, 2000, 18000.0, true));
        stadiums.add(new Stadium("Greenfield", "Dharamshala", 23000, "HP", false, 2002, 15000.0, true));
        stadiums.add(new Stadium("JSCA", "Ranchi", 39000, "Jharkhand", true, 2011, 25000.0, true));
        stadiums.add(new Stadium("Vidarbha Cricket", "Nagpur", 45000, "Vidarbha", true, 2008, 30000.0, true));
        stadiums.add(new Stadium("Rajiv Gandhi", "Hyderabad", 39000, "SRH", true, 2004, 22000.0, true));
        stadiums.add(new Stadium("MA Chidambaram", "Chennai", 38000, "CSK", true, 1916, 20000.0, true));
        stadiums.add(new Stadium("HPCA Dharamshala", "Dharamshala", 23000, "HP", false, 2010, 15000.0, true));
        stadiums.add(new Stadium("Barabati", "Cuttack", 45000, "Odisha", false, 1958, 28000.0, true));
        return stadiums;
    }

    @Bean("P30")
    public List<Student> getStudents() {
        List<Student> students = new ArrayList<>();
        students.add(new Student("Rohan", 21, "Computer Science", 101, "ABC College", 78.5, "Indiranagar", 9876543210L));
        students.add(new Student("Anita", 22, "Mechanical Engineering", 102, "XYZ College", 82.0, "BTM Layout", 8765432109L));
        students.add(new Student("Vikram Singh", 22, "B.E Mech", 103, "BMSCE", 82.0, "Koramangala", 7654321098L));
        students.add(new Student("Priya Reddy", 19, "BCA", 104, "Christ Uni", 88.7, "Whitefield", 6543210987L));
        students.add(new Student("Arjun Gowda", 21, "B.E Civil", 105, "NITK", 79.5, "Mangalore", 5432109876L));
        students.add(new Student("Sneha Nair", 20, "B.Sc Bio", 106, "St Aloysius", 84.3, "Mangalore", 4321098765L));
        students.add(new Student("Karthik Babu", 23, "MCA", 107, "MIT Manipal", 87.2, "Manipal", 3210987654L));
        students.add(new Student("Divya Joshi", 19, "B.Com", 108, "St Joseph", 76.8, "Langford Town", 2109876543L));
        students.add(new Student("Rahul Kumar", 22, "B.E ISE", 109, "VIT Vellore", 83.9, "Vellore", 1098765432L));
        students.add(new Student("Meera Devi", 20, "B.Arch", 110, "CEPT", 81.4, "Ahmedabad", 987654321L));
        students.add(new Student("Siddharth Pai", 21, "MBA", 111, "IIMB", 89.1, "Bannerghatta Rd", 876543210L));
        students.add(new Student("Kavya Menon", 19, "BA English", 112, "St Marks", 77.6, "St Marks Rd", 765432109L));
        students.add(new Student("Nikhil Rao", 22, "B.E EEE", 113, "RVCE", 80.2, "Jayanagar", 654321098L));
        students.add(new Student("Pooja Rani", 20, "BDS", 114, "Rajarajeswari", 86.5, "Kumbalgodu", 543210987L));
        students.add(new Student("Amit Gupta", 23, "M.Tech", 115, "IISc", 91.2, "Malleshwaram", 432109876L));
        return students;
    }

    @Bean("P31")
    public List<Teacher> getTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        teachers.add(new Teacher("Mr. Kumar", 10, "Mathematics", "M.Sc", 45000.0, 45, "Science", 9876543210L));
        teachers.add(new Teacher("Ms. Patel", 8, "Physics", "PhD", 50000.0, 35, "Science", 8765432109L));
        teachers.add(new Teacher("Anil Reddy", 18, "Chemistry", "PhD", 70000.0, 52, "Science", 7654321098L));
        teachers.add(new Teacher("Priya Sharma", 8, "Biology", "M.Sc", 48000.0, 35, "Science", 6543210987L));
        teachers.add(new Teacher("Vijay Singh", 20, "Computer Science", "M.Tech PhD", 75000.0, 50, "CSE", 5432109876L));
        teachers.add(new Teacher("Sunita Devi", 10, "English", "MA", 45000.0, 38, "Languages", 4321098765L));
        teachers.add(new Teacher("Kiran Gowda", 14, "Hindi", "MA PhD", 52000.0, 45, "Languages", 3210987654L));
        teachers.add(new Teacher("Meera Joshi", 9, "Kannada", "MA", 46000.0, 36, "Languages", 2109876543L));
        teachers.add(new Teacher("Suresh Babu", 16, "History", "MA PhD", 58000.0, 47, "Arts", 1098765432L));
        teachers.add(new Teacher("Lata Nair", 11, "Economics", "M.Com", 50000.0, 40, "Commerce", 987654321L));
        teachers.add(new Teacher("Mohan Das", 22, "Accountancy", "CA M.Com", 80000.0, 55, "Commerce", 876543210L));
        teachers.add(new Teacher("Divya Rani", 7, "Statistics", "M.Sc", 47000.0, 34, "Maths", 765432109L));
        teachers.add(new Teacher("Rajesh Pai", 13, "Mechanical Engg", "M.Tech", 62000.0, 44, "Mechanical", 654321098L));
        teachers.add(new Teacher("Anita Menon", 17, "Electronics", "M.Tech PhD", 68000.0, 49, "ECE", 543210987L));
        teachers.add(new Teacher("Prakash Rao", 19, "Civil Engg", "M.Tech", 64000.0, 51, "Civil", 432109876L));
        return teachers;
    }

    @Bean("P32")
    public List<Television> getTelevisions() {
        List<Television> tvs = new ArrayList<>();
        tvs.add(new Television("Sony", 55.0, "4K", true, "LED", 90000.0, 4, "Black"));
        tvs.add(new Television("LG", 43.0, "Full HD", false, "OLED", 60000.0, 3, "Silver"));
        tvs.add(new Television("LG", 43.0, "Full HD", false, "LED", 35000.0, 3, "White"));
        tvs.add(new Television("TCL", 75.0, "4K", true, "QLED", 85000.0, 4, "Black"));
        tvs.add(new Television("Mi", 55.0, "4K", true, "LED", 45000.0, 3, "Grey"));
        tvs.add(new Television("OnePlus", 55.0, "4K", true, "QLED", 65000.0, 4, "Blue"));
        tvs.add(new Television("Realme", 43.0, "Full HD", true, "LED", 28000.0, 2, "Black"));
        tvs.add(new Television("Vu", 65.0, "4K", true, "LED", 55000.0, 4, "Silver"));
        tvs.add(new Television("Motorola", 50.0, "4K", false, "LED", 40000.0, 3, "Black"));
        tvs.add(new Television("Philips", 43.0, "Full HD", true, "LED", 32000.0, 3, "Black"));
        tvs.add(new Television("Panasonic", 55.0, "4K", true, "LED", 52000.0, 4, "Silver"));
        tvs.add(new Television("Sharp", 75.0, "8K", true, "LED", 120000.0, 5, "Black"));
        tvs.add(new Television("Hisense", 65.0, "4K", true, "QLED", 70000.0, 4, "Gold"));
        tvs.add(new Television("Kodak", 43.0, "Full HD", false, "LED", 25000.0, 2, "White"));
        tvs.add(new Television("Infinix", 32.0, "HD", false, "LED", 15000.0, 2, "Black"));
        return tvs;
    }

    @Bean("P33")
    public List<Train> getTrains() {
        List<Train> trains = new ArrayList<>();
        trains.add(new Train("Shatabdi Express", 12001, "Bangalore", "Delhi", 16, 130.0, true, "Mon-Sat"));
        trains.add(new Train("Rajdhani Express", 12951, "Mumbai", "New Delhi", 20, 140.0, true, "Daily"));
        trains.add(new Train("Duronto Express", 12221, "Pune", "Howrah", 18, 150.0, true, "Mon,Wed,Fri"));
        trains.add(new Train("Vande Bharat", 22201, "Delhi", "Varanasi", 16, 160.0, true, "Daily"));
        trains.add(new Train("Tejas Express", 22119, "Mumbai", "Karmali", 12, 130.0, true, "Fri,Sat,Sun"));
        trains.add(new Train("Gatimaan Express", 12049, "Delhi", "Agra", 8, 160.0, true, "Daily"));
        trains.add(new Train("Humsafar Express", 12501, "Barauni", "Pune", 22, 120.0, true, "Tue,Fri"));
        trains.add(new Train("Yuva Express", 12249, "Bhubaneswar", "New Delhi", 20, 125.0, true, "Mon,Wed"));
        trains.add(new Train("Garib Rath", 12511, "Prayagraj", "New Delhi", 16, 130.0, false, "Daily"));
        trains.add(new Train("Sampark Kranti", 12627, "Karnataka", "New Delhi", 24, 115.0, true, "Daily"));
        trains.add(new Train("Kerala Express", 12625, "Thiruvananthapuram", "New Delhi", 28, 110.0, false, "Daily"));
        trains.add(new Train("Konkan Kanya", 20111, "Mumbai", "Madgaon", 14, 120.0, true, "Sat"));
        trains.add(new Train("Mysore Express", 22636, "Mysore", "Bangalore", 6, 100.0, false, "Daily"));
        trains.add(new Train("Udyan Express", 11301, "Mumbai", "Bangalore", 32, 90.0, false, "Daily"));
        trains.add(new Train("Cholan Express", 12684, "Chennai", "Coimbatore", 14, 110.0, false, "Daily"));
        return trains;
    }

    @Bean("P34")
    public List<WashingMachine> getWashingMachines() {
        List<WashingMachine> machines = new ArrayList<>();
        machines.add(new WashingMachine("Bosch", "Front Load", 7.0, true, "5 Star", 45000.0, "White", 3));
        machines.add(new WashingMachine("LG", "Top Load", 6.0, false, "4 Star", 35000.0, "Silver", 2));
        machines.add(new WashingMachine("Whirlpool", "Front Load", 9.0, true, "5 Star", 48000.0, "Grey", 4));
        machines.add(new WashingMachine("Bosch", "Front Load", 8.0, true, "5 Star", 65000.0, "Black", 5));
        machines.add(new WashingMachine("IFB", "Front Load", 7.0, true, "5 Star", 42000.0, "White", 4));
        machines.add(new WashingMachine("Godrej", "Top Load", 6.5, false, "4 Star", 28000.0, "Blue", 3));
        machines.add(new WashingMachine("Haier", "Top Load", 7.5, false, "5 Star", 35000.0, "Silver", 3));
        machines.add(new WashingMachine("Panasonic", "Front Load", 8.5, true, "5 Star", 52000.0, "White", 4));
        machines.add(new WashingMachine("Voltas Beko", "Top Load", 6.0, false, "4 Star", 25000.0, "Grey", 2));
        machines.add(new WashingMachine("Electrolux", "Front Load", 9.0, true, "5 Star", 58000.0, "Stainless", 5));
        machines.add(new WashingMachine("Hitachi", "Top Load", 7.0, false, "4 Star", 30000.0, "White", 3));
        machines.add(new WashingMachine("Lloyd", "Semi Auto", 7.0, false, "3 Star", 18000.0, "Blue", 2));
        machines.add(new WashingMachine("Onida", "Top Load", 6.2, false, "3 Star", 22000.0, "Grey", 2));
        machines.add(new WashingMachine("Videocon", "Semi Auto", 6.5, false, "2 Star", 15000.0, "White", 1));
        machines.add(new WashingMachine("Bajaj", "Top Load", 5.5, false, "3 Star", 20000.0, "Black", 2));
        return machines;
    }

    @Bean("P35")
    public List<Zoo> getZoos() {
        List<Zoo> zoos = new ArrayList<>();
        zoos.add(new Zoo("Bannerghatta", "Bangalore", 1500, 100, true, 1970, 300.0, 9876543210L));
        zoos.add(new Zoo("Nehru Zoological Park", "Hyderabad", 2000, 120, false, 1963, 350.0, 8765432109L));
        zoos.add(new Zoo("Nandankanan", "Bhubaneswar", 800, 100, true, 1964, 400.0, 7654321098L));
        zoos.add(new Zoo("Trivandrum Zoo", "Thiruvananthapuram", 900, 80, false, 1857, 60.0, 6543210987L));
        zoos.add(new Zoo("Mysore Zoo", "Mysore", 700, 90, true, 1892, 157.0, 5432109876L));
        zoos.add(new Zoo("Alipore Zoological Garden", "Kolkata", 1200, 110, false, 1876, 40.0, 4321098765L));
        zoos.add(new Zoo("Arignar Anna", "Chennai", 1700, 140, true, 1894, 1300.0, 3210987654L));
        zoos.add(new Zoo("Maharaj Zoo", "Vadodara", 300, 70, false, 1870, 32.0, 2109876543L));
        zoos.add(new Zoo("Kamla Nehru", "Pune", 400, 60, false, 1898, 15.0, 1098765432L));
        zoos.add(new Zoo("Patna Zoo", "Patna", 900, 85, true, 1917, 36.0, 987654321L));
        zoos.add(new Zoo("Ramoji Film City Zoo", "Hyderabad", 500, 75, true, 1996, 50.0, 876543210L));
        zoos.add(new Zoo("Guindy National Park", "Chennai", 600, 65, false, 1977, 670.0, 765432109L));
        zoos.add(new Zoo("Visakhapatnam Zoo", "Vizag", 800, 95, true, 1972, 25.0, 654321098L));
        zoos.add(new Zoo("Sri Chamarajendra", "Mysore", 700, 90, true, 1892, 157.0, 543210987L));
        zoos.add(new Zoo("Hajipur Zoo", "Hajipur", 350, 55, false, 1977, 20.0, 432109876L));
        return zoos;
    }



}
