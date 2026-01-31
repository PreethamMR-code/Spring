package com.xworkz.model.repository;

import com.xworkz.model.entity.BatchStudentEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.List;

@Repository
public class BatchStudentDAOImpl implements BatchStudentDAO{


    @Autowired
    EntityManagerFactory entityManagerFactory;


    @Override
    public boolean saveStudent(BatchStudentEntity student) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(student);
            em.getTransaction().commit();
            return true;
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

    @Override
    public List<BatchStudentEntity> getStudentsByBatchId(int batchId) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            Query query = em.createQuery(
                    "SELECT s FROM BatchStudentEntity s WHERE s.batchId = :batchId AND s.isActive = true ORDER BY s.joinedDate DESC"
            );
            query.setParameter("batchId", batchId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public BatchStudentEntity getStudentById(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            return em.find(BatchStudentEntity.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public String generateStudentId() {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            // Get the last student ID
            Query query = em.createQuery("SELECT MAX(s.id) FROM BatchStudentEntity s");
            Integer maxId = (Integer) query.getSingleResult();

            int nextId = (maxId != null) ? maxId + 1 : 1;

            // Format: XWZ001, XWZ002, etc.
            return String.format("XWZ%03d", nextId);

        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateStudent(BatchStudentEntity student) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(student);
            em.getTransaction().commit();
            return true;
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

    @Override
    public boolean deleteStudent(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE BatchStudentEntity s SET s.isActive = false WHERE s.id = :id");
            query.setParameter("id", id);
            int rows = query.executeUpdate();
            em.getTransaction().commit();
            return rows > 0;
        } finally {
            em.close();
        }
    }
}
