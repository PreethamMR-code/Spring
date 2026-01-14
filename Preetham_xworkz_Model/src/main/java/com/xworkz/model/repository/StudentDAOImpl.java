package com.xworkz.model.repository;

import com.xworkz.model.entity.StudentEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Query;

@Repository
public class StudentDAOImpl implements StudentDAO {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean save(StudentEntity studentEntity) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(studentEntity);
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            return false;
        } finally {
            entityManager.close();
        }

    }

    @Override
    public StudentEntity findByEmail(String email) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Query query = entityManager.createQuery("Select ref from StudentEntity ref where ref.email = :email");
            query.setParameter("email", email);
            StudentEntity studentEntity = (StudentEntity) query.getSingleResult();
            return studentEntity;
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

}
