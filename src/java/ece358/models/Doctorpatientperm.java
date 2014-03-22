package ece358.models;

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Doctorpatientperm  implements MySQLObjectMapping {
     public String patientId;
     public String doctorId;
     public String secDoctorId;
     public Date expiry;

    public Doctorpatientperm() {
    }

    public Doctorpatientperm(String patientId, String doctorId, String secDoctorId) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.secDoctorId = secDoctorId;
    }
    public Doctorpatientperm(String patientId, String doctorId, String secDoctorId, Date expiry) {
       this.patientId = patientId;
       this.doctorId = doctorId;
       this.secDoctorId = secDoctorId;
       this.expiry = expiry;
    }
    
    public String getPatientId() {
        return this.patientId;
    }
    
    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }
    
    public String getDoctorId() {
        return this.doctorId;
    }
    
    public void setDoctorId(String doctorId) {
        this.patientId = doctorId;
    }

    public String getSecDoctorId() {
        return this.secDoctorId;
    }
    
    public void setSecDoctorId(String secDoctorId) {
        this.patientId = secDoctorId;
    }
    
    public Date getExpiry() {
        return this.expiry;
    }
    
    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }

    @Override
    public List<Field> getIdFields() {
        return new ArrayList<Field>(){{
            add(Doctorpatientperm.class.getDeclaredFields()[0]);
            add(Doctorpatientperm.class.getDeclaredFields()[1]);
            add(Doctorpatientperm.class.getDeclaredFields()[2]);
        }};
    }
}


