package ece358.models;
// Generated Mar 17, 2014 7:33:52 PM by Hibernate Tools 3.6.0



/**
 * Province generated by hbm2java
 */
public class Province  implements java.io.Serializable {


     private String code;
     private String name;

    public Province() {
    }

    public Province(String code, String name) {
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




}


