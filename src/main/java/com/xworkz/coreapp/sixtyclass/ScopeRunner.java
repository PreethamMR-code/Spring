package com.xworkz.coreapp.sixtyclass;

import com.xworkz.coreapp.sixtyclass.bean.*;
import com.xworkz.coreapp.sixtyclass.sub.*;
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



    }
}
