package com.xworkz.eventapp.repository;


import com.xworkz.eventapp.entity.EventEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.Collections;
import java.util.List;


public class EventDaoImpl implements EventDAO {


    @Override
    public boolean save(EventEntity eventEntity) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(eventEntity);
        entityManager.getTransaction().commit();
        entityManagerFactory.close();
        entityManager.close();
        return true;
    }

    @Override
    public EventEntity getById(int id) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EventEntity eventEntity = entityManager.find(EventEntity.class, id);

        entityManagerFactory.close();
        entityManager.close();
        return eventEntity;
    }

    @Override
    public boolean updateByID(int id, EventEntity eventEntity) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.merge(eventEntity);
        entityManager.getTransaction().commit();
        entityManagerFactory.close();
        entityManager.close();
        return true;
    }

    @Override
    public boolean deleteById(int id) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        EventEntity eventEntity = entityManager.find(EventEntity.class, id);
        if (eventEntity != null) {
            entityManager.remove(eventEntity);
            entityManager.getTransaction().commit();
        }

        entityManagerFactory.close();
        entityManager.close();
        return true;

    }

    @Override
    public boolean updateManagerByID(int id, String manager) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        EventEntity eventEntity = entityManager.find(EventEntity.class, id);

        if (eventEntity != null) {
            eventEntity.setEventManager(manager);
            entityManager.merge(eventEntity);
        }
        entityManager.getTransaction().commit();

        entityManager.close();
        return true;
    }

    @Override
    public EventEntity getEventBYEventName(String eventName) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getEventBYEventName");

        query.setParameter("en", eventName);
        EventEntity eventEntity = (EventEntity) query.getSingleResult();
        return eventEntity;
    }

    @Override
    public EventEntity getEventByManager(String manager) {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getEventByManager");
        query.setParameter("eM", manager);
        EventEntity eventEntity = (EventEntity) query.getSingleResult();
        return eventEntity;
    }

    @Override
    public EventEntity getManagerById(int id) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getManagerById");
        query.setParameter("id", id);
        EventEntity eventEntity = (EventEntity) query.getSingleResult();
        return eventEntity;
    }

    @Override
    public Object[] getManagerAndTimeByEventName(String eventName) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getManagerAndTimeByEventName");
        query.setParameter("eName", eventName);
        Object[] result = (Object[]) query.getSingleResult();
        return result;

    }

    @Override
    public List<String> getAllManagerNames() {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getAllManagerNames");
        List<String> strings = (List<String>) query.getResultList();
        return strings;

    }

    @Override
    public List<String> getAllEvents() {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getAllEvents");
        List<String> strings =  query.getResultList();
        return strings;
    }

    @Override
    public List<EventEntity> getAllEvent() {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery("getAllEvent");
        List<EventEntity> entities =  query.getResultList();
        return entities;

    }

    @Override
    public String getEventNameByManager(String manager) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createQuery("select ref.eventName   from EventEntity ref where  ref.eventManager =: eMan");
        query.setParameter("eMan", manager);
        String managerName= (String) query.getSingleResult();
        return managerName;
    }

    @Override
    public boolean updateManagerByEventNameAndTime(String manager, String eventName, String time) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        Query query= entityManager.createQuery("update EventEntity ref set ref.eventManager =:eM  where ref.eventName =:eName and ref.eventTime =:eT");
        query.setParameter("eM", manager).
                setParameter("eName" , eventName).
                setParameter("eT",time);
      int rowsUpdated =query.executeUpdate();
      entityManager.getTransaction().commit();
      if(rowsUpdated >0){
          return true;
      }
        return false;
    }

    @Override
    public boolean updateEventTimeByEventName(String eventTime, String eventName) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        Query query = entityManager.createQuery("update EventEntity ref set ref.eventTime =:eTime where ref.eventName=:en");
        query.setParameter("eTime",eventTime).setParameter("en",eventName);
        int rowUpdate = query.executeUpdate();
        entityManager.getTransaction().commit();
        if(rowUpdate >0){
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteByEventName(String eventName) {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("xworkz");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        Query query = entityManager.createQuery("delete EventEntity ref where ref.eventName =:eN");
        query.setParameter("eN",eventName);
        int rowDelete = query.executeUpdate();
        entityManager.getTransaction().commit();
        if(rowDelete >0){
            return true;
        }
        return false;
    }


}

