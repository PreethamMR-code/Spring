package com.xworkz.zomato.dao;

import com.xworkz.zomato.dto.ZomatoDTO;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public class ZomatoDAOHibernateImpl implements ZomatoDAO{
    @Override
    public boolean save(ZomatoDTO zomatoDTO) {

        Configuration configuration = new Configuration();
        configuration.configure();
        configuration.addAnnotatedClass(ZomatoDTO.class);
        SessionFactory sessionFactory =configuration.buildSessionFactory();
        Session session =sessionFactory.openSession();
        Transaction transaction =session.beginTransaction();
        session.save(zomatoDTO);
        transaction.commit();

        return true;
    }

    @Override
    public Optional<ZomatoDTO> getRestaurantByName(String restaurantName) {
        return Optional.empty();
    }
}
