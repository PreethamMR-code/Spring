package com.xworkz.forms.repository;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

@Repository
public class RegistrationDAOImpl implements RegistrationDAO{

    @Autowired
    private EntityManagerFactory entityManagerFactory;

    @Override
    public  boolean save(Object entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(entity);
        entityManager.getTransaction().commit();
        entityManager.close();
        return true;
    }
}
