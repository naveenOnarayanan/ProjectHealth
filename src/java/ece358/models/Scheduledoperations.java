package ece358.models;

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Scheduledoperations implements MySQLObjectMapping {
     public Integer visitId;
     public Date operationDateTime;
     public String operationName;
     public String doctorId;

    public Scheduledoperations() {
    }

    public Integer getVisitId() {
        return this.visitId;
    }

    public void setVisitId(Integer visitId) {
        this.visitId = visitId;
    }

    public Date getOperationDateTime() {
        return this.operationDateTime;
    }

    public void setOperationDateTime(Date operationDateTime) {
        this.operationDateTime = operationDateTime;
    }

    public String getOperationName() {
        return this.operationName;
    }
    
    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }
    public String getDoctorId() {
        return this.doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    @Override
    public List<Field> getIdFields() {
        return new ArrayList<Field>(){{
            add(Scheduledoperations.class.getDeclaredFields()[0]);
            add(Scheduledoperations.class.getDeclaredFields()[1]);
        }};
    }
}


