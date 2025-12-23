package com.xworkz.coreapp.sixtyclass;

import com.xworkz.coreapp.sixtyclass.bean.*;
import com.xworkz.coreapp.sixtyclass.sub.*;
import com.xworkz.coreapp.sixtyclass.sub.Process;
import com.xworkz.coreapp.thirtyclass.config.ConfigurationContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class ScopeRunner {

    public static void main(String[] args) {

        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(ConfigurationContext.class);

        Academy academy = applicationContext.getBean(Academy.class);
        System.out.println(academy);

        Learner learner = academy.getLearner();
        System.out.println(learner);
//        =====================================================
        Campus campus = applicationContext.getBean(Campus.class);
        System.out.println(campus);

        Scholar scholar = campus.getScholar();
        System.out.println(scholar);
//        ======================================================


        School school = applicationContext.getBean(School.class);
        System.out.println(school);

        Pupil pupil = school.getPupil();
        System.out.println(pupil);

//        =====================================================

        Lab lab = applicationContext.getBean(Lab.class);
        System.out.println(lab);

        Researcher researcher = lab.getResearcher();
        System.out.println(researcher);
//        ============================================
        Hostel hostel = applicationContext.getBean(Hostel.class);
        System.out.println(hostel);

        Resident resident = hostel.getResident();
        System.out.println(resident);

//        ===================================================


        Cafeteria cafeteria = applicationContext.getBean(Cafeteria.class);
        System.out.println(cafeteria);

        Diner diner = cafeteria.getDiner();
        System.out.println(diner);
//        =======================================


        Gym gym = applicationContext.getBean(Gym.class);
        System.out.println(gym);

        Athlete athlete = gym.getAthlete();
        System.out.println(athlete);
//        ================================================


        Gym gym1 = applicationContext.getBean(Gym.class);
        System.out.println(gym1);

        Athlete athlete1 = gym.getAthlete();
        System.out.println(athlete1);
//        =================================


        Auditorium auditorium = applicationContext.getBean(Auditorium.class);
        System.out.println(auditorium);

        Speaker speaker = auditorium.getSpeaker();
        System.out.println(speaker);

//        =====================================


        Workshop workshop = applicationContext.getBean(Workshop.class);
        System.out.println(workshop);

        Participant participant = workshop.getParticipant();
        System.out.println(participant);
//        =====================================

        Firm firm = applicationContext.getBean(Firm.class);
        System.out.println(firm);

        Worker worker = firm.getWorker();
        System.out.println(worker);
        //        =====================================

        Office office = applicationContext.getBean(Office.class);
        System.out.println(office);

        Staff staff = office.getStaff();
        System.out.println(staff);
        //        =====================================

        Unit unit = applicationContext.getBean(Unit.class);
        System.out.println(unit);

        Operator operator = unit.getOperator();
        System.out.println(operator);
        //        =====================================

        Squad squad = applicationContext.getBean(Squad.class);
        System.out.println(squad);

        Member member = squad.getMember();
        System.out.println(member);
        //        =====================================

        Crew crew = applicationContext.getBean(Crew.class);
        System.out.println(crew);

        Colleague colleague = crew.getColleague();
        System.out.println(colleague);
        //        =====================================

        Group group = applicationContext.getBean(Group.class);
        System.out.println(group);

        Associate associate = group.getAssociate();
        System.out.println(associate);
        //        =====================================

        Cell cell = applicationContext.getBean(Cell.class);
        System.out.println(cell);

        Partner partner = cell.getPartner();
        System.out.println(partner);
        //        =====================================

        Wing wing = applicationContext.getBean(Wing.class);
        System.out.println(wing);

        Ally ally = wing.getAlly();
        System.out.println(ally);
        //        =====================================

        Sector sector = applicationContext.getBean(Sector.class);
        System.out.println(sector);

        Agent agent = sector.getAgent();
        System.out.println(agent);
        //        =====================================

        Zone zone = applicationContext.getBean(Zone.class);
        System.out.println(zone);

        Delegate delegate = zone.getDelegate();
        System.out.println(delegate);
        //        =====================================

        Center center = applicationContext.getBean(Center.class);
        System.out.println(center);

        Healer healer = center.getHealer();
        System.out.println(healer);

        Ward ward = applicationContext.getBean(Ward.class);
        System.out.println(ward);

        Caregiver caregiver = ward.getCaregiver();
        System.out.println(caregiver);

        Units units = applicationContext.getBean(Units.class);
        System.out.println(units);

        Medic medic = units.getMedic();
        System.out.println(medic);

        Bay bay = applicationContext.getBean(Bay.class);
        System.out.println(bay);

        Attendant attendant = bay.getAttendant();
        System.out.println(attendant);

        Room room = applicationContext.getBean(Room.class);
        System.out.println(room);

        Therapist therapist = room.getTherapist();
        System.out.println(therapist);

        Suite suite = applicationContext.getBean(Suite.class);
        System.out.println(suite);

        Specialist specialist = suite.getSpecialist();
        System.out.println(specialist);

        Wings wings = applicationContext.getBean(Wings.class);
        System.out.println(wings);

        Consultant consultant = wings.getConsultant();
        System.out.println(consultant);

        Block block = applicationContext.getBean(Block.class);
        System.out.println(block);

        Physician physician = block.getPhysician();
        System.out.println(physician);

        Floor floor = applicationContext.getBean(Floor.class);
        System.out.println(floor);

        Surgeon surgeon = floor.getSurgeon();
        System.out.println(surgeon);

        Dept dept = applicationContext.getBean(Dept.class);
        System.out.println(dept);

        Radiologist radiologist = dept.getRadiologist();
        System.out.println(radiologist);


        Shop shop = applicationContext.getBean(Shop.class);
        System.out.println(shop);

        Buyer buyer = shop.getBuyer();
        System.out.println(buyer);

        Outlet outlet = applicationContext.getBean(Outlet.class);
        System.out.println(outlet);

        Patron patron = outlet.getPatron();
        System.out.println(patron);

        Mall mall = applicationContext.getBean(Mall.class);
        System.out.println(mall);

        Shopper shopper = mall.getShopper();
        System.out.println(shopper);

        Booth booth = applicationContext.getBean(Booth.class);
        System.out.println(booth);

        Client client = booth.getClient();
        System.out.println(client);

        Kiosk kiosk = applicationContext.getBean(Kiosk.class);
        System.out.println(kiosk);

        Visitor visitor = kiosk.getVisitor();
        System.out.println(visitor);

        Stand stand = applicationContext.getBean(Stand.class);
        System.out.println(stand);

        Guest guest = stand.getGuest();
        System.out.println(guest);

        Counter counter = applicationContext.getBean(Counter.class);
        System.out.println(counter);

        Walker walker = counter.getWalker();
        System.out.println(walker);

        Shelf shelf = applicationContext.getBean(Shelf.class);
        System.out.println(shelf);

        Browser browser = shelf.getBrowser();
        System.out.println(browser);

        Aisle aisle = applicationContext.getBean(Aisle.class);
        System.out.println(aisle);

        Picker picker = aisle.getPicker();
        System.out.println(picker);

        Rack rack = applicationContext.getBean(Rack.class);
        System.out.println(rack);

        Selector selector = rack.getSelector();
        System.out.println(selector);


        Hub hub = applicationContext.getBean(Hub.class);
        System.out.println(hub);

        User user = hub.getUser();
        System.out.println(user);

        Portal portal = applicationContext.getBean(Portal.class);
        System.out.println(portal);

        Guests guests = portal.getGuests();
        System.out.println(guests);

        Node node = applicationContext.getBean(Node.class);
        System.out.println(node);

        Device device = node.getDevice();
        System.out.println(device);

        Gateway gateway = applicationContext.getBean(Gateway.class);
        System.out.println(gateway);

        Terminal terminal = gateway.getTerminal();
        System.out.println(terminal);

        Cluster cluster = applicationContext.getBean(Cluster.class);
        System.out.println(cluster);

        Server server = cluster.getServer();
        System.out.println(server);

        Racks racks = applicationContext.getBean(Racks.class);
        System.out.println(racks);

        Processor processor = racks.getProcessor();
        System.out.println(processor);

        Farm farm = applicationContext.getBean(Farm.class);
        System.out.println(farm);

        Instance instance = farm.getInstance();
        System.out.println(instance);

        Pool pool = applicationContext.getBean(Pool.class);
        System.out.println(pool);

        Threads threads = pool.getThreads();
        System.out.println(threads);

        Grid grid = applicationContext.getBean(Grid.class);
        System.out.println(grid);

        Workers workers = grid.getWorkers();
        System.out.println(workers);

        Mesh mesh = applicationContext.getBean(Mesh.class);
        System.out.println(mesh);

        Link link = mesh.getLink();
        System.out.println(link);

        Net net = applicationContext.getBean(Net.class);
        System.out.println(net);

        Socket socket = net.getSocket();
        System.out.println(socket);

        Web web = applicationContext.getBean(Web.class);
        System.out.println(web);

        Browsers browsers = web.getBrowsers();
        System.out.println(browser);

        Cloud cloud = applicationContext.getBean(Cloud.class);
        System.out.println(cloud);

        Pod pod = cloud.getPod();
        System.out.println(pod);

        Stack stack = applicationContext.getBean(Stack.class);
        System.out.println(stack);

        Layer layer = stack.getLayer();
        System.out.println(layer);

        Pipe pipe = applicationContext.getBean(Pipe.class);
        System.out.println(pipe);

        Stream stream = pipe.getStream();
        System.out.println(stream);

        Buses buses = applicationContext.getBean(Buses.class);
        System.out.println(buses);

        Signal signal = buses.getSignal();
        System.out.println(signal);

        Core core = applicationContext.getBean(Core.class);
        System.out.println(core);

        Task task = core.getTask();
        System.out.println(task);

        Kernel kernel = applicationContext.getBean(Kernel.class);
        System.out.println(kernel);

        Process process = kernel.getProcess();
        System.out.println(process);

        Engine engine = applicationContext.getBean(Engine.class);
        System.out.println(engine);

        Job job = engine.getJob();
        System.out.println(job);

        Motor motor = applicationContext.getBean(Motor.class);
        System.out.println(motor);

        Queue queue = motor.getQueue();
        System.out.println(queue);






    }
}
