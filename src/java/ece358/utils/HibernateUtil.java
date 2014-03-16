/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358.utils;

import org.hibernate.Session;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author ZGaming
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    
    static {
        try {
            // Create the SessionFactory from standard (hibernate.cfg.xml) 
            // config file.
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            // Log the exception. 
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    
    public static Object select(String query) {
        Session session = getSessionFactory().openSession();
        session.beginTransaction();
        Object result = session.createQuery(query).list();
        session.getTransaction().commit();
        session.close();

        return result;
    }
    
    public static Object get(Class clazz, java.io.Serializable obj) {
        try {
            Session session = getSessionFactory().openSession();
            session.beginTransaction();
            Object result = session.get(clazz, obj);
            session.getTransaction().commit();
            session.close();
            return result;
        } catch(Exception e) {
            return null;
        }
    }
}
