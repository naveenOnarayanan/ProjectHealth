package ece358;
// Generated 14-Mar-2014 5:41:19 PM by Hibernate Tools 3.6.0



/**
 * PrescriptionsId generated by hbm2java
 */
public class PrescriptionsId  implements java.io.Serializable {


     private int visitId;
     private int din;

    public PrescriptionsId() {
    }

    public PrescriptionsId(int visitId, int din) {
       this.visitId = visitId;
       this.din = din;
    }
   
    public int getVisitId() {
        return this.visitId;
    }
    
    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
    public int getDin() {
        return this.din;
    }
    
    public void setDin(int din) {
        this.din = din;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof PrescriptionsId) ) return false;
		 PrescriptionsId castOther = ( PrescriptionsId ) other; 
         
		 return (this.getVisitId()==castOther.getVisitId())
 && (this.getDin()==castOther.getDin());
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + this.getVisitId();
         result = 37 * result + this.getDin();
         return result;
   }   


}


