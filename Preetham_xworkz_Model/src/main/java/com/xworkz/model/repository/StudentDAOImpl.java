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


        @Override
        public void update(StudentEntity studentEntity) {

            EntityManager entityManager = entityManagerFactory.createEntityManager();
            try {
                entityManager.getTransaction().begin();
                entityManager.merge(studentEntity);
                entityManager.getTransaction().commit();
            } finally {
                entityManager.close();
            }
        }

    @Override
    public void updateLoginCount(String email, int count) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();

            Query query = entityManager.createQuery(
                    "update StudentEntity s set s.loginCount = :count where s.email = :email"
            );
            query.setParameter("count", count);
            query.setParameter("email", email);

            query.executeUpdate();
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void resetLoginCount(String email) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();

            Query query = entityManager.createQuery(
                    "update StudentEntity s set s.loginCount = 0 where s.email = :email"
            );
            query.setParameter("email", email);

            query.executeUpdate();
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveOtp(String email, String otp) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try {
            entityManager.getTransaction().begin();

            Query query = entityManager.createQuery("select s from StudentEntity s where s.email =:email");

            query.setParameter("email", email);

            StudentEntity entity =(StudentEntity) query.getSingleResult();

          entity.setOtp(otp);

            entityManager.merge(entity);

           return true;

        }catch (NoResultException e) {
            return false;
        }finally {
            entityManager.close();
        }
    }

    @Override
    public boolean checkOtpMatch(String email, String otp) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            Query query = entityManager.createQuery("select s from StudentEntity s where s.email = :email and s.otp = :otp");

            query.setParameter("email",email);
            query.setParameter("otp",otp);

            query.getSingleResult();
            return true;

        }catch (NoResultException e){
            return false;
        }finally {
            entityManager.close();
        }
    }

}
