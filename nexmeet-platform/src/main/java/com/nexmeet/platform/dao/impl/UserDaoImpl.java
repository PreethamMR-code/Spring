package com.nexmeet.platform.dao.impl;


/*
 * @Repository marks this as a Spring-managed DAO bean.
 * It also enables Spring's exception translation — Hibernate
 * exceptions get converted to Spring's DataAccessException hierarchy,
 * which is cleaner to handle in Service/Controller layers.
 *
 * SessionFactory is injected by Spring (defined in spring-db-config.xml).
 * We call sessionFactory.getCurrentSession() to get the active
 * Hibernate Session — this Session is tied to the current transaction.
 *
 * IMPORTANT: Every method here requires an active @Transactional context.
 * That context is provided by the Service layer, not here.
 * DAOs never manage transactions themselves.
 */

import com.nexmeet.platform.dao.UserDao;
import com.nexmeet.platform.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Optional;

@Repository
public class UserDaoImpl implements UserDao {

    /*
     * @Autowired tells Spring: "inject the SessionFactory bean
     * that was configured in spring-db-config.xml".
     * We don't create it manually — Spring manages its lifecycle.
     */
    @Autowired
    private SessionFactory sessionFactory;

    /*
     * Helper method — gets the current Hibernate Session.
     * The Session is the main object for all database operations.
     * It represents one unit of work with the database.
     */
   private Session getCurrentSession(){
       return sessionFactory.getCurrentSession();
   }


    @Override
    public void save(User user) {
        getCurrentSession().save(user);

    }

    @Override
    public void update(User user) {
        getCurrentSession().update(user);

    }

    @Override
    public Optional<User> findById(Long id) {
        /*
         * session.get() returns the object or NULL if not found.
         * We wrap in Optional so callers can use:
         *   userDao.findById(5L).orElseThrow(...)
         * instead of null checks everywhere.
         */
        User user = getCurrentSession().get(User.class, id);
        return Optional.ofNullable(user);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        /*
         * HQL (Hibernate Query Language) looks like SQL but uses
         * entity class names and field names, NOT table/column names.
         *
         * SQL:  SELECT * FROM users WHERE email = 'x@y.com'
         * HQL:  FROM User WHERE email = :email
         *
         * :email is a named parameter — much safer than string
         * concatenation which causes SQL injection vulnerabilities.
         * Always use named parameters for user-supplied values.
         */
        User user = (User) getCurrentSession()
                .createQuery("FROM User WHERE email = :email")
                .setParameter("email", email)
                .uniqueResult();
        return Optional.ofNullable(user);
    }

    @Override
    public List<User> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM User u ORDER BY u.createdAt DESC", User.class)
                .getResultList();
    }

    @Override
    public boolean existsByEmail(String email) {
        /*
         * COUNT query — much more efficient than fetching the
         * entire User object just to check if it exists.
         * Returns 0 if not found, 1 if found.
         */
        Long count = (Long) getCurrentSession()
                .createQuery("SELECT COUNT(u) FROM User u WHERE u.email = :email")
                .setParameter("email", email)
                .uniqueResult();
        return count > 0;
    }

    @Override
    public void deactivate(Long id) {
        getCurrentSession()
                .createQuery("UPDATE User SET isActive = false WHERE id = :id")
                .setParameter("id", id)
                .executeUpdate();
    }

    @Override
    public long countAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT COUNT(u) FROM User u", Long.class)
                .getSingleResult();
    }

}
