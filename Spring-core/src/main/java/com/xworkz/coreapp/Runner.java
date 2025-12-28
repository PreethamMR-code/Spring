package com.xworkz.coreapp;

import com.xworkz.coreapp.autowired.airport.Airport;
import com.xworkz.coreapp.autowired.terminal.Terminal;
import com.xworkz.coreapp.config.InternetConfig;
import com.xworkz.coreapp.internet.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.util.List;



public class Runner {
    public static void main(String[] args) {

        System.out.println("main started");

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(InternetConfig.class);


        Internet internet = applicationContext.getBean(Internet.class);
        internet.setId(1);
        internet.setName("preethu");
        System.out.println("id and name :"+internet);
//        ============================================================

        Cricket cricket = applicationContext.getBean(Cricket.class);
        cricket.setName("Virat");
        cricket.setAge(37);
        System.out.println("name and age:"+cricket);
//        =================================================================

        Gym gym = applicationContext.getBean(Gym.class);
        gym.setGymName("cultFit");
        gym.setGymOwner("Cult company");
        System.out.println("gym name and its owner:"+ gym);

//        =====================================================

        Sweet sweet = applicationContext.getBean(Sweet.class);
        sweet.setSweetName("champakali");
        sweet.setPrice(250);
        System.out.println("sweet and price:"+sweet);

//        ====================================================

        Street street = applicationContext.getBean(Street.class);
        street.setStreetName("MG Road");
        street.setCity("Bengaluru");
        System.out.println("street and city:"+street);
//        ===============================================

        Sports sports = applicationContext.getBean(Sports.class);
        sports.setSportsName("Soccer");
        sports.setEquipment("Foot ball");
        System.out.println(" sports name and euipment:"+sports);
//        =======================================================

        President president =applicationContext.getBean(President.class);
        president.setPresidentName("MODI");
        president.setCountry("INdia");
        System.out.println("name and country:"+president);
//        ========================================

        Watch watch = applicationContext.getBean(Watch.class);
        watch.setName("Seiko");
        watch.setPrice(30000);
        System.out.println(watch);
//        ================================================

        Hospital hospital = applicationContext.getBean(Hospital.class);
        hospital.setName("Apollo");
        hospital.setLocation("Bengaluru");
        System.out.println(hospital);
//        ==================================================

        College college = applicationContext.getBean(College.class);
        college.setName("Presidency");
        college.setLocation("HEbbala");
        System.out.println(college);
//        ===================================================

        Travel travel = applicationContext.getBean(Travel.class);
        travel.setAgencyName("Durgamba");
        travel.setLocation("Benagaluru");
        System.out.println(travel);
//        ================================================

        Sneakers sneakers = applicationContext.getBean(Sneakers.class);
        sneakers.setSneakerName("NIKE");
        sneakers.setPrice(25000);
        System.out.println(sneakers);
//        ========================================================

        Universe universe = applicationContext.getBean(Universe.class);
        universe.setGalaxyName("MILKY WAY");
        universe.setPlanet("EARTH");
        System.out.println(universe);
//        ===============================================

        Racing racing = applicationContext.getBean(Racing.class);
        racing.setRacingType("F1");
        racing.setCar("FERRARI");
        System.out.println(racing);
//        ===================================================

        Cars cars = applicationContext.getBean(Cars.class);
        cars.setCarName("PORSCHE");
        cars.setPrice(30000000);
        System.out.println(cars);
//        =================================================

        Bikes bikes = applicationContext.getBean(Bikes.class);
        bikes.setBikeName("BMW");
        bikes.setMileage(10);
        System.out.println(bikes);
//        ====================================================

        Villa villa = applicationContext.getBean(Villa.class);
        villa.setVillaName("raj");
        villa.setHasPool(true);
        System.out.println(villa);
//        ===========================================

        Person person = applicationContext.getBean(Person.class);
        person.setPersonName("preethu");
        person.setMobileNo(123456789);
        System.out.println(person);
//        ==============================================

        City city =applicationContext.getBean(City.class);
        city.setName("Benagaluru");
        city.setHasMetro(true);
        System.out.println(city);
//        ========================================

        Rocket rocket =applicationContext.getBean(Rocket.class);
        rocket.setName("Ashoka");
        rocket.setSpeed(500.58);
        System.out.println(rocket);
//        =====================================

        Laptop laptop = applicationContext.getBean(Laptop.class);
        laptop.setName("HP");
        laptop.setIntel(true);
        System.out.println(laptop);
//        ==================================

        Mobile mobile =applicationContext.getBean(Mobile.class);
        mobile.setCompany("SAMSUNG");
        mobile.setPrice(30000);
        System.out.println(mobile);

//        =================================================

        States states =applicationContext.getBean(States.class);
        states.setName("karnataka");
        states.setCapital("bengaluru");
        System.out.println(states);
//        ===========================================

        Country country=applicationContext.getBean(Country.class);
        country.setName("INDIA");
        country.setCapital("DElhi");
        System.out.println(country);

//        ======================================================

        Bags bags = applicationContext.getBean(Bags.class);
//        bags.setBrand("Wildcraft");
//        bags.setPrice(2000);
        System.out.println(bags);
//        ======================================================

        Pens pens = applicationContext.getBean(Pens.class);
        pens.setType("Ballpoint");
        pens.setPrice(20);
        System.out.println(pens);
//        ======================================================

        TVs tvs = applicationContext.getBean(TVs.class);
        tvs.setBrand("Samsung");
        tvs.setPrice(45000);
        System.out.println(tvs);
//        ==================================================

        Houses houses = applicationContext.getBean(Houses.class);
        houses.setLocation("Bangalore");
        houses.setPrice(7500000);
        System.out.println(houses);
//        ===============================================

        Books books = applicationContext.getBean(Books.class);
        books.setTitle("Java Basics");
        books.setPrice(500);
        System.out.println(books);
//        =========================================================



        String Name = applicationContext.getBean("getName",String.class);
        System.out.println(Name);


        Integer age = applicationContext.getBean("getAge",Integer.class);
        System.out.println(age);

//        Integer pinCode = applicationContext.getBean("pinCode",Integer.class);
//        System.out.println(pinCode);

        List<String>  cafe = applicationContext.getBean("getCafeName",List.class);
        System.out.println(cafe);

        long  number = applicationContext.getBean("P1",long.class);
        System.out.println(number);

        double  weight = applicationContext.getBean("P2",double.class);
        System.out.println(weight);

        char  lastName = applicationContext.getBean("P3",char.class);
        System.out.println(lastName);

        List<College>  colleges = applicationContext.getBean("P4",List.class);
        System.out.println(colleges);

        List<Bikes> bikes1 = applicationContext.getBean("P5",List.class);
        System.out.println(bikes1);

        List<Cars> cars1 =applicationContext.getBean("P6",List.class);
        System.out.println(cars1);


        Airport airport = applicationContext.getBean(Airport.class);

        airport.setAirportName("asdfghgfds");


        Terminal terminal = airport.getTerminal();
        terminal.setName("asdfgh");

        System.out.println(airport);




//        System.out.println(terminal);

        System.out.println("main ended");
    }

}
