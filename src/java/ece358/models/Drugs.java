package ece358.models;
// Generated Mar 16, 2014 5:46:38 PM by Hibernate Tools 3.6.0



/**
 * Drugs generated by hbm2java
 */
public class Drugs  implements java.io.Serializable {


     private int din;
     private String tradeName;
     private String description;

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




}


