package ece358.models;
// Generated Mar 17, 2014 7:33:52 PM by Hibernate Tools 3.6.0

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;




/**
 * Drugs generated by hbm2java
 */
public class Drugs  implements MySQLObjectMapping {


     public Integer din;
     public String tradeName;
     public String description;

    public Drugs() {
    }

    public Drugs(int din) {
        this.din = din;
    }
    public Drugs(int din, String tradeName, String description) {
       this.din = din;
       this.tradeName = tradeName;
       this.description = description;
    }
   
    public int getDin() {
        return this.din;
    }
    
    public void setDin(int din) {
        this.din = din;
    }
    public String getTradeName() {
        return this.tradeName;
    }
    
    public void setTradeName(String tradeName) {
        this.tradeName = tradeName;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public List<Field> getIdFields() {
        return new ArrayList<Field>(){{
            add(Drugs.class.getDeclaredFields()[0]);
        }};
    }
}


