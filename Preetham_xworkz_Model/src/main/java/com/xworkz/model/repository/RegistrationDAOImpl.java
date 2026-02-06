package com.xworkz.model.repository;

import com.xworkz.model.entity.RegistrationEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import java.time.LocalDateTime;

@Repository
public class RegistrationDAOImpl implements RegistrationDAO {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @Override
    public boolean save(RegistrationEntity studentEntity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(studentEntity);
            entityManager.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public RegistrationEntity loginByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Query query = entityManager.createQuery(
                    "SELECT ref FROM RegistrationEntity ref WHERE ref.email = :email"
            );
            query.setParameter("email", email);
            return (RegistrationEntity) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void setCountToZero(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createQuery(
                    "UPDATE RegistrationEntity user SET user.count = 0 WHERE user.email = :eMail"
            );
            query.setParameter("eMail", email);
            query.executeUpdate();
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public int getCount(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Query query = entityManager.createQuery(
                    "SELECT user.count FROM RegistrationEntity user WHERE user.email = :eMail"
            );
            query.setParameter("eMail", email);
            Object result = query.getSingleResult();
            return result != null ? (Integer) result : 0;
        } catch (NoResultException e) {
            return 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateCount(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createQuery(
                    "UPDATE RegistrationEntity user SET user.count = user.count + 1 WHERE user.email = :eMail"
            );
            query.setParameter("eMail", email);
            query.executeUpdate();
            entityManager.getTransaction().commit();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean checkEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Long count = (Long) entityManager.createQuery(
                    "SELECT COUNT(user) FROM RegistrationEntity user WHERE LOWER(user.email) = LOWER(:email)"
            ).setParameter("email", email.trim()).getSingleResult();
            return count > 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean saveOtp(String email, String otp) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createQuery(
                    "UPDATE RegistrationEntity u SET u.otp = :otp, u.otpGeneratedTime = :generatedTime WHERE u.email = :email"
            );
            query.setParameter("otp", otp);
            query.setParameter("generatedTime", LocalDateTime.now());  //it will save current time
            query.setParameter("email", email);

            int rowsAffected = query.executeUpdate();
            entityManager.getTransaction().commit();
            return rowsAffected > 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public RegistrationEntity checkOtpMatch(String email, String otp) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            Query query = entityManager.createQuery(
                    "SELECT ref FROM RegistrationEntity ref WHERE ref.email = :email AND ref.otp = :otp"
            );
            query.setParameter("email", email);
            query.setParameter("otp", otp);

            return (RegistrationEntity) query.getSingleResult();

        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }


    //updating in Db password and setting otp as null
    @Override
    public boolean updatePassword(String email, String newPassword) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createQuery(
                    "UPDATE RegistrationEntity u SET u.password = :password, u.otp = null, u.otpGeneratedTime = null, u.count = 0 WHERE u.email = :email"
            );
            query.setParameter("password", newPassword);
            query.setParameter("email", email);

            int rowsAffected = query.executeUpdate();
            entityManager.getTransaction().commit();
            return rowsAffected > 0;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateProfile(String email, String name, String phone, Integer age, String address) {

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        try{
            entityManager.getTransaction().begin();

            Query query = entityManager.createQuery("UPDATE RegistrationEntity u SET u.name = :name, u.phone = :phone, " +
                    "u.age = :age, u.address = :address WHERE u.email = :email");

            query.setParameter("name", name);
            query.setParameter("phone", phone);
            query.setParameter("age", age);
            query.setParameter("address", address);
            query.setParameter("email", email);

            int rowsAffected = query.executeUpdate();
            entityManager.getTransaction().commit();

            System.out.println(" Profile updated for: " + email);
            return rowsAffected > 0;

        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public RegistrationEntity findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            // We use LOWER() to ensure "Raj@gmail.com" matches "raj@gmail.com"
            return entityManager.createQuery(
                            "SELECT r FROM RegistrationEntity r WHERE LOWER(r.email) = LOWER(:email)",
                            RegistrationEntity.class)
                    .setParameter("email", email.trim())
                    .getResultList()
                    .stream()
                    .findFirst()
                    .orElse(null);

        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean updateProfilePhoto(String email, String newFilename) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();

            Query query = em.createQuery(
                    "UPDATE StudentEntity s SET s.profilePhoto = :photo WHERE s.email = :email"
            );
            query.setParameter("photo", newFilename);
            query.setParameter("email", email);

            int updated = query.executeUpdate();
            em.getTransaction().commit();

            System.out.println("✅ Profile photo updated for: " + email);
            return updated > 0;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

}
