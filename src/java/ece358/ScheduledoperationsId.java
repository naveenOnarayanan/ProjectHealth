package ece358;
// Generated 14-Mar-2014 5:41:19 PM by Hibernate Tools 3.6.0


import java.util.Date;

/**
 * ScheduledoperationsId generated by hbm2java
 */
public class ScheduledoperationsId  implements java.io.Serializable {


     private int visitId;
     private Date operationDateTime;

    public ScheduledoperationsId() {
    }

    public ScheduledoperationsId(int visitId, Date operationDateTime) {
       this.visitId = visitId;
       this.operationDateTime = operationDateTime;
    }
   
    public int getVisitId() {
        return this.visitId;
    }
    
    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
    public Date getOperationDateTime() {
        return this.operationDateTime;
    }
    
    public void setOperationDateTime(Date operationDateTime) {
        this.operationDateTime = operationDateTime;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof ScheduledoperationsId) ) return false;
		 ScheduledoperationsId castOther = ( ScheduledoperationsId ) other; 
         
		 return (this.getVisitId()==castOther.getVisitId())
 && ( (this.getOperationDateTime()==castOther.getOperationDateTime()) || ( this.getOperationDateTime()!=null && castOther.getOperationDateTime()!=null && this.getOperationDateTime().equals(castOther.getOperationDateTime()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + this.getVisitId();
         result = 37 * result + ( getOperationDateTime() == null ? 0 : this.getOperationDateTime().hashCode() );
         return result;
   }   


}

