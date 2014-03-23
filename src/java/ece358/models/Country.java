package ece358.models;

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Country implements MySQLObjectMapping {
     public String code;
     public String name;

    public Country() {
    }

    public Country(String code, String name) {
       this.code = code;
       this.name = name;
    }

    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public List<Field> getIdFields() {
        return new ArrayList<Field>(){{
            add(Country.class.getDeclaredFields()[0]);
        }};
    }
}


