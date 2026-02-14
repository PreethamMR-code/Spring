package com.xworkz.model.repository;

import com.xworkz.model.entity.EmailNotificationEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class EmailNotificationDAOImpl implements EmailNotificationDAO{


        @Autowired
        EntityManagerFactory entityManagerFactory;

        @Override
        public boolean save(EmailNotificationEntity entity) {
            EntityManager em = entityManagerFactory.createEntityManager();
            try {
                em.getTransaction().begin();
                em.persist(entity);
                em.getTransaction().commit();
                return true;
            } catch (Exception e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                e.printStackTrace();
                return false;
            } finally {
                em.close();
            }
        }

        @Override
        public EmailNotificationEntity findByToken(String token) {
            EntityManager em = entityManagerFactory.createEntityManager();
            try {
                return em.createQuery(
                                "SELECT e FROM EmailNotificationEntity e WHERE e.responseToken = :token",
                                EmailNotificationEntity.class)
                        .setParameter("token", token)
                        .getSingleResult();
            } catch (NoResultException e) {
                return null;
            } finally {
                em.close();
            }
        }

        @Override
        public boolean updateResponse(String token, String response) {
            EntityManager em = entityManagerFactory.createEntityManager();
            try {
                em.getTransaction().begin();
                int rows = em.createQuery(
                                "UPDATE EmailNotificationEntity e SET e.response = :response, " +
                                        "e.respondedAt = :respondedAt WHERE e.responseToken = :token")
                        .setParameter("response", response)
                        .setParameter("respondedAt", LocalDateTime.now())
                        .setParameter("token", token)
                        .executeUpdate();
                em.getTransaction().commit();
                return rows > 0;
            } catch (Exception e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                e.printStackTrace();
                return false;
            } finally {
                em.close();
            }
        }

        @Override
        public List<EmailNotificationEntity> findByBatchId(int batchId) {
            EntityManager em = entityManagerFactory.createEntityManager();
            try {
                return em.createQuery(
                                "SELECT e FROM EmailNotificationEntity e WHERE e.batchId = :batchId " +
                                        "ORDER BY e.sentAt DESC",
                                EmailNotificationEntity.class)
                        .setParameter("batchId", batchId)
                        .getResultList();
            } finally {
                em.close();
            }
        }

        @Override
        public List<EmailNotificationEntity> findByStudentId(int studentId) {
            EntityManager em = entityManagerFactory.createEntityManager();
            try {
                return em.createQuery(
                                "SELECT e FROM EmailNotificationEntity e WHERE e.studentId = :studentId " +
                                        "ORDER BY e.sentAt DESC",
                                EmailNotificationEntity.class)
                        .setParameter("studentId", studentId)
                        .getResultList();
            } finally {
                em.close();
            }
        }


}
