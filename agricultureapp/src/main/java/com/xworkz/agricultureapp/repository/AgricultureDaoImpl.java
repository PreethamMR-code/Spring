package com.xworkz.agricultureapp.repository;

import com.xworkz.agricultureapp.entity.AgricultureEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class AgricultureDaoImpl implements AgricultureDAO{


    @Override
    public boolean save(AgricultureEntity entity) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("xworkz");
        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();

        em.close();
        emf.close();
        return true;
    }

    @Override
    public AgricultureEntity getById(int id) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("xworkz");
        EntityManager em = emf.createEntityManager();

        AgricultureEntity entity = em.find(AgricultureEntity.class, id);

        em.close();
        emf.close();
        return entity;
    }

    @Override
    public boolean updateByID(int id, AgricultureEntity entity) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("xworkz");
        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();
        em.merge(entity);
        em.getTransaction().commit();

        em.close();
        emf.close();
        return true;
    }

    @Override
    public boolean deleteById(int id) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("xworkz");
        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();

        AgricultureEntity entity = em.find(AgricultureEntity.class, id);
        if (entity != null) {
            em.remove(entity);
        }

        em.getTransaction().commit();
        em.close();
        emf.close();
        return true;
    }

    @Override
    public boolean updateFarmerByID(int id, String farmerName) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("xworkz");
        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();

        AgricultureEntity entity = em.find(AgricultureEntity.class, id);
        if (entity != null) {
            entity.setFarmerName(farmerName);
            em.merge(entity);
        }

        em.getTransaction().commit();
        em.close();
        emf.close();
        return true;
    }
}
