package com.xworkz.coreapp.thirtyclass;

import com.xworkz.coreapp.thirtyclass.config.ConfigurationContext;
import com.xworkz.coreapp.thirtyclass.dto.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.util.List;

public class Runner {
    public static void main(String[] args) {

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(ConfigurationContext.class);


        List<Airport> airports = applicationContext.getBean("P1", List.class);
        System.out.println("Airports: " + airports);

        List<Bakery> bakeries = applicationContext.getBean("P2", List.class);
        System.out.println("Bakeries: " + bakeries);

        List<Bank> banks = applicationContext.getBean("P3", List.class);
        System.out.println("Banks: " + banks);

        List<Bicycle> bicycles = applicationContext.getBean("P4", List.class);
        System.out.println("Bicycles: " + bicycles);

        List<Book> books = applicationContext.getBean("P5", List.class);
        System.out.println("Books: " + books);

        List<Bus> buses = applicationContext.getBean("P6", List.class);
        System.out.println("Buses: " + buses);

        List<Camera> cameras = applicationContext.getBean("P7", List.class);
        System.out.println("Cameras: " + cameras);

        List<College> colleges = applicationContext.getBean("P8", List.class);
        System.out.println("Colleges: " + colleges);

        List<Company> companies = applicationContext.getBean("P9", List.class);
        System.out.println("Companies: " + companies);

        List<Game> games = applicationContext.getBean("P10", List.class);
        System.out.println("Games: " + games);

        List<Gym> gyms = applicationContext.getBean("P11", List.class);
        System.out.println("Gyms: " + gyms);

        List<Hospital> hospitals = applicationContext.getBean("P12", List.class);
        System.out.println("Hospitals: " + hospitals);

        List<Hotel> hotels = applicationContext.getBean("P13", List.class);
        System.out.println("Hotels: " + hotels);

        List<House> houses = applicationContext.getBean("P14", List.class);
        System.out.println("Houses: " + houses);

        List<Laptop> laptops = applicationContext.getBean("P15", List.class);
        System.out.println("Laptops: " + laptops);

        List<Library> libraries = applicationContext.getBean("P16", List.class);
        System.out.println("Libraries: " + libraries);

        List<MobilePhone> mobilePhones = applicationContext.getBean("P17", List.class);
        System.out.println("MobilePhones: " + mobilePhones);

        List<Movie> movies = applicationContext.getBean("P18", List.class);
        System.out.println("Movies: " + movies);

        List<MusicAlbum> musicAlbums = applicationContext.getBean("P19", List.class);
        System.out.println("MusicAlbums: " + musicAlbums);

        List<Park> parks = applicationContext.getBean("P20", List.class);
        System.out.println("Parks: " + parks);

        List<Pharmacy> pharmacies = applicationContext.getBean("P21", List.class);
        System.out.println("Pharmacies: " + pharmacies);

        List<Printer> printers = applicationContext.getBean("P22", List.class);
        System.out.println("Printers: " + printers);

        List<Refrigerator> refrigerators = applicationContext.getBean("P23", List.class);
        System.out.println("Refrigerators: " + refrigerators);

        List<Restaurant> restaurants = applicationContext.getBean("P24", List.class);
        System.out.println("Restaurants: " + restaurants);

        List<Scooter> scooters = applicationContext.getBean("P25", List.class);
        System.out.println("Scooters: " + scooters);

        List<Shop> shops = applicationContext.getBean("P26", List.class);
        System.out.println("Shops: " + shops);

        List<SmartWatch> smartWatches = applicationContext.getBean("P27", List.class);
        System.out.println("SmartWatches: " + smartWatches);

        List<Speaker> speakers = applicationContext.getBean("P28", List.class);
        System.out.println("Speakers: " + speakers);

        List<Stadium> stadiums = applicationContext.getBean("P29", List.class);
        System.out.println("Stadiums: " + stadiums);

        List<Student> students = applicationContext.getBean("P30", List.class);
        System.out.println("Students: " + students);

        List<Teacher> teachers = applicationContext.getBean("P31", List.class);
        System.out.println("Teachers: " + teachers);

        List<Television> televisions = applicationContext.getBean("P32", List.class);
        System.out.println("Televisions: " + televisions);

        List<Train> trains = applicationContext.getBean("P33", List.class);
        System.out.println("Trains: " + trains);

        List<WashingMachine> washingMachines = applicationContext.getBean("P34", List.class);
        System.out.println("WashingMachines: " + washingMachines);

        List<Zoo> zoos = applicationContext.getBean("P35", List.class);
        System.out.println("Zoos: " + zoos);
    }

}
