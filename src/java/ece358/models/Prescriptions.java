package ece358.models;
// Generated Mar 17, 2014 7:33:52 PM by Hibernate Tools 3.6.0


import ece358.models.mapping.MySQLObjectMapping;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Prescriptions  implements MySQLObjectMapping {

     public Integer visitId;
     public Integer din;
     public Integer quantity;
     public Integer refills;
     public String dosage;
     public Date expiry;
     
     // Custom object
     private String prescriptionName;

    public Prescriptions() {
    }

    public Integer getVisitId() {
        return visitId;
    }

    public void setVisitId(Integer visitId) {
        this.visitId = visitId;
    }
    
    public Integer getDin() {
        return this.din;
    }
    
    public void setDin(Integer din) {
        this.din = din;
    }

    public Integer getQuantity() {
        return this.quantity;
    }
    
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    public Integer getRefills() {
        return this.refills;
    }
    
    public void setRefills(Integer refills) {
        this.refills = refills;
    }
    public String getDosage() {
        return this.dosage;
    }
    
    public void setDosage(String dosage) {
        this.dosage = dosage;
    }
    public Date getExpiry() {
        return this.expiry;
    }
    
    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }
    
    public String getPrescriptionName() {
        return this.prescriptionName;
    }
    
    public void setPrescriptionName(String prescriptionName) {
        this.prescriptionName = prescriptionName;
    }

    @Override
    public List<Field> getIdFields() {
        return new ArrayList<Field>(){{
            add(Prescriptions.class.getDeclaredFields()[0]);
        }};
    }
}


