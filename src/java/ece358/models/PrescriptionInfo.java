/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358.models;

/**
 *
 * @author Eric
 */

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PrescriptionInfo {
    private String patientID;
    private Integer DIN;
    private String name;
    private Integer quantity;
    private Integer refills;
    private String dosage;
    private Date issue;
    private Date expiry;
    
    public PrescriptionInfo() {
    }

    public PrescriptionInfo(String patientID, Integer id, Integer quantity, Integer refills, String dosage, Date issue, Date expiry) {
        this.patientID = patientID;
        this.DIN = id;
        this.quantity = quantity;
        this.refills = refills;
        this.dosage = dosage;
        this.issue = issue;
        this.expiry = expiry;
    }

    public String getPatientID() {
        return patientID;
    }

    public Integer getDIN() {
        return DIN;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public Integer getRefills() {
        return refills;
    }

    public String getDosage() {
        return dosage;
    }

    public Date getIssue() {
        return issue;
    }

    public Date getExpiry() {
        return expiry;
    }

    public String getName() {
        return name;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public void setDIN(Integer DIN) {
        this.DIN = DIN;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public void setRefills(Integer refills) {
        this.refills = refills;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public void setIssue(Date issue) {
        this.issue = issue;
    }

    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String issueToSimpleDateString() {
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Date date = this.issue;
        String returnDate = df.format(date);
        return returnDate;
    }
    
    public String expiryToSimpleDateString() {
        DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
        Date date = this.expiry;
        String returnDate = df.format(date);
        return returnDate;
    }
}
