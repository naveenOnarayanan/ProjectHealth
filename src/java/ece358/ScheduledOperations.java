/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ece358.models.*;
import ece358.utils.*;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Calendar;

/**
 *
 * @author Josh
 */
public class ScheduledOperations extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Users sessionUser = (Users) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        
        String VisitID = request.getParameter("VisitID");
        
        String url = "";
        boolean queryServletError = false;
        try{
            Users user = (Users) request.getSession().getAttribute("user");
            String role = user.getRole();
            String queryString = new String();
            boolean addPatientInfo = false;

            if(role.equals(Constants.PATIENT))
            {
               queryString = "SELECT SO.VisitID, SO.OperationDateTime, SO.OperationName, S.FirstName, S.LastName, O.Name, O.Description, O.EstTime "+
                       "FROM scheduledoperations as SO, visitation as V, staff as S, operations as O "+
                       "WHERE SO.VisitID=V.VisitID && S.UserID=SO.DoctorID && O.Name=SO.OperationName && V.Timestamp= "+
                       "(SELECT max(Timestamp) FROM visitation WHERE VisitID = V.VisitID) && V.PatientID='" + user.getUserId() + "'";
            }
            else if(role.equals(Constants.STAFF))
            {
                String managingDoctorQuery = "(SELECT ManagingDoctorID FROM staff WHERE UserID='"+ user.getUserId() +"')";
                 queryString = "SELECT SO.VisitID, SO.OperationDateTime, SO.OperationName, S.FirstName, S.LastName, O.Name, O.Description, O.EstTime, V.PatientID, P.FirstName, P.LastName, D.FirstName, D.LastName "+
                       "FROM scheduledoperations as SO, visitation as V, staff as S, staff as D, operations as O, patients as P "+
                       "WHERE SO.VisitID=V.VisitID && S.UserID=SO.DoctorID && O.Name=SO.OperationName && P.UserID = V.PatientID && V.Timestamp= "+
                       "(SELECT max(Timestamp) FROM visitation WHERE VisitID = V.VisitID) && D.UserID=P.DefaultDoctorID && (P.DefaultDoctorID=" + managingDoctorQuery + " OR SO.DoctorID= "+ managingDoctorQuery +")";
                addPatientInfo = true;
            }
            else if(role.equals(Constants.DOCTOR))
            {
                queryString = "SELECT SO.VisitID, SO.OperationDateTime, SO.OperationName, S.FirstName, S.LastName, O.Name, O.Description, O.EstTime, V.PatientID, P.FirstName, P.LastName, D.FirstName, D.LastName "+
                       "FROM scheduledoperations as SO, visitation as V, staff as S, staff as D, operations as O, patients as P "+
                       "WHERE SO.VisitID=V.VisitID && S.UserID=SO.DoctorID && O.Name=SO.OperationName && P.UserID = V.PatientID && V.Timestamp= "+
                       "(SELECT max(Timestamp) FROM visitation WHERE VisitID = V.VisitID) && D.UserID=P.DefaultDoctorID && (P.DefaultDoctorID='" + user.getUserId() + "' OR SO.DoctorID='"+ user.getUserId() +"')";
                addPatientInfo = true;
            }
            if(VisitID != null && !VisitID.isEmpty())
            {
                queryString += " && SO.VisitID = '" + VisitID + "'";
                request.setAttribute("FullView", false);
            }
            else
            {
                request.setAttribute("FullView", true);
            }
            List<Object[]> result = SQLSessionUtil.executeQuery(queryString);


            List<Scheduledoperations> schedoperationsPast = new ArrayList<Scheduledoperations>();
            List<Operations> operationsPast = new ArrayList<Operations>();
            List<Staff> surgeonsPast = new ArrayList<Staff>();
            List<Staff> doctorsPast = new ArrayList<Staff>();
            List<Patients> patientsPast = new ArrayList<Patients>();
            List<Scheduledoperations> schedoperationsFuture = new ArrayList<Scheduledoperations>();
            List<Operations> operationsFuture = new ArrayList<Operations>();
            List<Staff> surgeonsFuture = new ArrayList<Staff>();
            List<Staff> doctorsFuture = new ArrayList<Staff>();
            List<Patients> patientsFuture = new ArrayList<Patients>();
            Calendar cal = Calendar.getInstance();
            Date today = cal.getTime();
            for(Object[] o : result)
            {
                Scheduledoperations sop = new Scheduledoperations();
                int visitID = (Integer)o[0];
                Date opDate = new Date(((Timestamp)o[1]).getTime());
                sop.setVisitId(visitID);
                sop.setOperationDateTime(opDate);
                sop.setOperationName((String)o[2]);
                Staff st = new Staff();
                st.setFirstName((String)o[3]);
                st.setLastName((String)o[4]);
                Operations op = new Operations();
                op.setName((String)o[5]);
                op.setDescription((String)o[6]);
                op.setEstTime((Time)o[7]);
                Patients p = new Patients();
                Staff d = new Staff();
                if(addPatientInfo)
                {
                    p.setUserId((String)o[8]);
                    p.setFirstName((String)o[9]);
                    p.setLastName((String)o[10]);
                    d.setFirstName((String)o[11]);
                    d.setLastName((String)o[12]);
                }
                    

                if(sop.getOperationDateTime().compareTo(today) <= 0)
                {
                    surgeonsPast.add(st);
                    schedoperationsPast.add(sop);
                    operationsPast.add(op);
                    if(addPatientInfo)
                    {
                        doctorsPast.add(d);
                        patientsPast.add(p);
                    }

                }
                else
                {
                    surgeonsFuture.add(st);
                    schedoperationsFuture.add(sop);
                    operationsFuture.add(op);
                    if(addPatientInfo)
                    {
                        doctorsFuture.add(d);
                        patientsFuture.add(p);
                    }
                        
                        
                }
            }
            request.setAttribute("schedoperationsPast", schedoperationsPast);
            request.setAttribute("surgeonsPast", surgeonsPast);
            request.setAttribute("doctorsPast", doctorsPast);
            request.setAttribute("operationsPast", operationsPast);
            request.setAttribute("patientsPast", patientsPast);
            request.setAttribute("schedoperationsFuture", schedoperationsFuture);
            request.setAttribute("surgeonsFuture", surgeonsFuture);
             request.setAttribute("doctorsFuture", doctorsFuture);
            request.setAttribute("operationsFuture", operationsFuture);
            request.setAttribute("patientsFuture", patientsFuture);
            url = "/ScheduledOperations.jsp";
            request.setAttribute("queryServletError", queryServletError);
        }
        catch(Exception e)
        {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
            url = "/ScheduledOperations.jsp";
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
