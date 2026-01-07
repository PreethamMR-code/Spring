package com.xworkz.eventapp.repository;


import com.xworkz.eventapp.entity.EventEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;



public class EventDaoImpl implements EventDAO {


    @Override
    public boolean save(EventEntity eventEntity) {

        Configuration configuration = new Configuration();
        configuration.configure();
        configuration.addAnnotatedClass(EventEntity.class);
        SessionFactory sessionFactory = configuration.buildSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.save(eventEntity);
        transaction.commit();
        return true;
    }

    @Override
    public EventEntity getById(int id) {

        Configuration configuration = new Configuration();
        configuration.configure();
        configuration.addAnnotatedClass(EventEntity.class);
        SessionFactory sessionFactory = configuration.buildSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        EventEntity eventEntity = session.get(EventEntity.class, id);
       if(eventEntity!=null){
           return eventEntity;
       }
        return null;

    }

    @Override
    public boolean updateByID(int id, EventEntity e) {
        Configuration configuration = new Configuration();
        configuration.configure();
        configuration.addAnnotatedClass(EventEntity.class);
        SessionFactory sessionFactory = configuration.buildSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        EventEntity eventEntity = session.get(EventEntity.class, id);
        if(eventEntity!=null){
          eventEntity.setEventManager(e.getEventManager());
          eventEntity.setEventTime(e.getEventTime());
          eventEntity.setEventName(e.getEventName());
          session.update(eventEntity);
          transaction.commit();
          return true;
        }
        return false;
    }

    @Override
    public boolean deleteById(int id) {


            Configuration configuration = new Configuration();
            configuration.configure();
            configuration.addAnnotatedClass(EventEntity.class);

            SessionFactory sessionFactory = configuration.buildSessionFactory();
            Session session = sessionFactory.openSession();
            Transaction transaction = session.beginTransaction();

            EventEntity entity = session.get(EventEntity.class, id);

            if (entity != null) {
                session.delete(entity);
                transaction.commit();
                session.close();
                sessionFactory.close();
                return true;
            }

            return false;
        }

}

