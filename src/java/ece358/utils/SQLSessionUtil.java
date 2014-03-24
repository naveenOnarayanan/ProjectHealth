/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358.utils;

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author ZGaming
 */
public class SQLSessionUtil {

    private static final String url = "jdbc:mysql://localhost:3306/hospital_main";
    private static final String user = "root";
    private static final String password = "test";
    private static Connection connection;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (connection == null) {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
        }
        return connection;
    }

    public static List<Object[]> executeQuery(String query) throws ClassNotFoundException, SQLException {
        Connection connection = getConnection();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery(query);
        ResultSetMetaData resultMeta = result.getMetaData();
        
        List<Object[]> results = new ArrayList<Object[]>();
        while (result.next()) {
            int i = 1;
            Object[] obj = new Object[resultMeta.getColumnCount()];
            for (int j = 0; j < obj.length; j++) {
                obj[j] = result.getObject(i);
                i++;
            }
            results.add(obj);
        }

        result.close();
        statement.close();

        return results;
    }
    
    public static void executeUpdate(String query) throws SQLException, ClassNotFoundException {
        Connection connection = getConnection();
        Statement statement = connection.createStatement();
        statement.executeUpdate(query);
        statement.close();
    }
    
    public static Object get(Class objType, Object id) throws InstantiationException, IllegalAccessException, SQLException, ClassNotFoundException {
        MySQLObjectMapping instanceObj = (MySQLObjectMapping) objType.newInstance();
        Field instanceFieldClass = instanceObj.getIdFields().get(0);
        String fieldName = upperCaseFirstCharacterAndID(instanceFieldClass.getName());

        StringBuilder getQueryBuilder = new StringBuilder(" SELECT *");
        getQueryBuilder.append(" FROM ");
        getQueryBuilder.append(objType.getSimpleName());
        getQueryBuilder.append(" WHERE ");
        getQueryBuilder.append(fieldName);
        getQueryBuilder.append("=");
        
        if (instanceFieldClass.getType().equals(Integer.class) || instanceFieldClass.getType().equals(Boolean.class)) {
            getQueryBuilder.append(id);
        } else {
            getQueryBuilder.append("'");
            getQueryBuilder.append(id);
            getQueryBuilder.append("'");
        }
        
        return ((List<Object>) selectType(instanceObj.getClass(), getQueryBuilder.toString())).get(0);
    }

    public static Object selectType(Class objType, String query) throws InstantiationException,
            IllegalAccessException, SQLException, ClassNotFoundException {
        List<Object[]> result = executeQuery(query);

        Field[] fields = objType.getFields();

        List<Object> results = new ArrayList<Object>();

        for (int i = 0; i < result.size(); i++) {
            Object instanceObj = objType.newInstance();
            for (int j = 0; j < result.get(i).length; j++) {
                if (fields[j].getType().equals(String.class)) {
                    fields[j].set(instanceObj, (String) result.get(i)[j]);
                } else if (fields[j].getType().equals(Integer.class)) {
                    fields[j].set(instanceObj, (Integer) result.get(i)[j]);
                } else if (fields[j].getType().equals(Date.class)) {
                    fields[j].set(instanceObj, (Date) result.get(i)[j]);
                } else if (fields[j].getType().equals(Time.class)) {
                    fields[j].set(instanceObj, (Time) result.get(i)[j]);
                } else if (fields[j].getType().equals(Boolean.class)) {
                    fields[j].set(instanceObj, (Boolean) result.get(i)[j]);
                }
            }
            results.add(instanceObj);
        }

        return results;
    }

    public static void update(MySQLObjectMapping updateObj) throws IllegalArgumentException, IllegalAccessException, ClassNotFoundException, SQLException {
        Class clazz = updateObj.getClass();
        
        List<Field> ids = updateObj.getIdFields();
        
        StringBuilder whereConditionBuilder = new StringBuilder(" WHERE ");
        
        StringBuilder queryBuilder = new StringBuilder(" UPDATE ");
        queryBuilder.append(clazz.getName().toLowerCase());
        queryBuilder.append(" SET");
        Field[] fields = clazz.getDeclaredFields();
        Field[] publicFields = clazz.getFields();
        for (int i = 0; i < publicFields.length; i++) {
            if (!ids.contains(fields[i])) {
                String fieldname = upperCaseFirstCharacterAndID(fields[i].getName());

                queryBuilder.append(" ");
                queryBuilder.append(fieldname);
                queryBuilder.append("=");

                Object fieldValue = fields[i].get(updateObj);
                if (fields[i].getType().equals(Date.class)) {
                    queryBuilder.append("'");
                    queryBuilder.append(((Date) fieldValue).toString());
                    queryBuilder.append("'");
                } else if (fields[i].getType().equals(Boolean.class)) {
                    queryBuilder.append((Boolean) fieldValue);
                } else if (fields[i].getType().equals(Integer.class)){
                    queryBuilder.append((Integer) fieldValue);
                } else {
                    queryBuilder.append("'");
                    queryBuilder.append((String) fieldValue);
                    queryBuilder.append("'");
                }
            } else {
                whereConditionBuilder.append(" ");
                whereConditionBuilder.append(upperCaseFirstCharacterAndID(fields[i].getName()));
                
                Object fieldValue = fields[i].get(updateObj);
                if (fields[i].getType().equals(Date.class)) {
                    whereConditionBuilder.append("'");
                    whereConditionBuilder.append(((Date) fieldValue).toString());
                    whereConditionBuilder.append("'");
                } else if (fields[i].getType().equals(Boolean.class)) {
                    whereConditionBuilder.append((Boolean) fieldValue);
                } else if (fields[i].getType().equals(Integer.class)){
                    whereConditionBuilder.append((Integer) fieldValue);
                } else {
                    whereConditionBuilder.append("'");
                    whereConditionBuilder.append((String) fieldValue);
                    whereConditionBuilder.append("'");
                }
            }
        }

        executeUpdate(queryBuilder.toString() + whereConditionBuilder.toString());
    }

    public static void add(Object newObj) throws IllegalArgumentException, IllegalAccessException, ClassNotFoundException, SQLException {
        Class clazz = newObj.getClass();
        
        StringBuilder queryBuilder = new StringBuilder(" INSERT INTO ");
        queryBuilder.append(clazz.getSimpleName().toLowerCase());
        queryBuilder.append(" VALUES (");
        Field[] fields = clazz.getDeclaredFields();
        Field[] publicFields = clazz.getFields();
        for (int i = 0; i < publicFields.length; i++) {
            Object fieldValue = fields[i].get(newObj);
            if (fields[i].getType().equals(Date.class)) {
                if (fieldValue != null) {
                    queryBuilder.append("'");
                    queryBuilder.append(new SimpleDateFormat("yyyy-MM-dd HH:mm").format((Date) fieldValue));
                    queryBuilder.append("'");
                } else {
                    queryBuilder.append((Date) fieldValue);
                }
            } else if (fields[i].getType().equals(Integer.class)) {
                queryBuilder.append((Integer) fieldValue);
            } else if (fields[i].getType().equals(Boolean.class)) {
                queryBuilder.append((Boolean) fieldValue);
            } else if (fields[i].getType().equals(Time.class)) {
                if (fieldValue != null) {
                    queryBuilder.append("'");
                    queryBuilder.append((Time) fieldValue);
                    queryBuilder.append("'");
                } else {
                    queryBuilder.append((Time) fieldValue);
                }
            } else {
                queryBuilder.append("'");
                queryBuilder.append((String) fieldValue);
                queryBuilder.append("'");
            }
            if (i == publicFields.length - 1) {
                queryBuilder.append(")");
            } else {
                queryBuilder.append(", ");
            }
        }

        executeUpdate(queryBuilder.toString());
    }

    
    private static String upperCaseFirstCharacterAndID(String inputString) {
        String strInputUpperID = inputString.replaceAll("Id", "ID").replace("din", "DIN");
        return strInputUpperID.substring(0, 1).toUpperCase() + strInputUpperID.substring(1);
    }
}
