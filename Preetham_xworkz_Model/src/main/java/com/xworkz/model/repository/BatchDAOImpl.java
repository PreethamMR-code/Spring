package com.xworkz.model.repository;

import com.xworkz.model.entity.BatchEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import java.util.List;

@Repository
public class BatchDAOImpl implements BatchDAO{

    @Autowired
    EntityManagerFactory entityManagerFactory;


    @Override
    public boolean saveBatch(BatchEntity batch) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(batch);
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
    public List<BatchEntity> getAllBatches() {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            Query query = em.createQuery("SELECT b FROM BatchEntity b WHERE b.isActive = true ORDER BY b.createdAt DESC");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public BatchEntity getBatchById(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            return em.find(BatchEntity.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateBatch(BatchEntity batch) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(batch);
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
    public boolean deleteBatch(int id) {
        EntityManager em = entityManagerFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE BatchEntity b SET b.isActive = false WHERE b.id = :id");
            query.setParameter("id", id);
            int rows = query.executeUpdate();
            em.getTransaction().commit();
            return rows > 0;
        } finally {
            em.close();
        }
    }
}
