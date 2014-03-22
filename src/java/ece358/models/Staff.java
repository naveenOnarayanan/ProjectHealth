package ece358.models;

import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Staff implements MySQLObjectMapping{


     public String userId;
     public String firstName;
     public String lastName;
     public String managingDoctorId;
     public String jobTitle;
     public boolean currentlyEmployed;

    public Staff() {
    }
	
    public Staff(String userId, boolean currentlyEmployed) {
        this.userId = userId;
        this.currentlyEmployed = currentlyEmployed;
    }
    public Staff(String userId, String firstName, String lastName, String managingDoctorId, String jobTitle, boolean currentlyEmployed) {
       this.userId = userId;
       this.firstName = firstName;
       this.lastName = lastName;
       this.managingDoctorId = managingDoctorId;
       this.jobTitle = jobTitle;
       this.currentlyEmployed = currentlyEmployed;
    }
   
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getFirstName() {
        return this.firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return this.lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getManagingDoctorId() {
        return this.managingDoctorId;
    }
    
    public void setManagingDoctorId(String managingDoctorId) {
        this.managingDoctorId = managingDoctorId;
    }
    public String getJobTitle() {
        return this.jobTitle;
    }
    
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    public boolean isCurrentlyEmployed() {
        return this.currentlyEmployed;
    }
    
    public void setCurrentlyEmployed(boolean currentlyEmployed) {
        this.currentlyEmployed = currentlyEmployed;
    }

    @Override
    public List<Field> getIdFields() {
       return new ArrayList<Field>(){{
            add(Staff.class.getDeclaredFields()[0]);
        }};
    }
}


