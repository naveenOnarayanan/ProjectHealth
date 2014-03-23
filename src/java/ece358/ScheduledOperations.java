/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import java.io.IOException;
import java.io.PrintWriter;
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
import java.text.SimpleDateFormat;
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
        Users user = (Users) request.getSession().getAttribute("user");
        String role = user.getRole();
        String queryString = new String();
        
        if(role.equals(Constants.PATIENT))
        {
           queryString = "SELECT SO.VisitID, SO.OperationDateTime, SO.OperationName, S.FirstName, S.LastName, O.Name, O.Description, O.EstTime "+
                   "FROM scheduledoperations as SO, visitation as V, staff as S, operations as O "+
                   "WHERE SO.VisitID=V.VisitID && S.UserID=SO.DoctorID && O.Name=SO.OperationName && V.Timestamp= "+
                   "(SELECT max(Timestamp) FROM visitation WHERE VisitID = V.VisitID) && V.PatientID='" + user.getUserId() + "'";
        }
        else if(role.equals(Constants.PATIENT))
        {
            
        }
        else if(role.equals(Constants.DOCTOR))
        {
            
        }
        List<Object[]> result = new ArrayList<Object[]>();
        try{
            result = SQLSessionUtil.executeQuery(queryString);
        }
        catch(Exception e)
        {
            
        }
        List<Scheduledoperations> schedoperationsPast = new ArrayList<Scheduledoperations>();
        List<Operations> operationsPast = new ArrayList<Operations>();
        List<Staff> surgeonsPast = new ArrayList<Staff>();
        List<Scheduledoperations> schedoperationsFuture = new ArrayList<Scheduledoperations>();
        List<Operations> operationsFuture = new ArrayList<Operations>();
        List<Staff> surgeonsFuture = new ArrayList<Staff>();
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
            if(sop.getOperationDateTime().compareTo(today) <= 0)
            {
                surgeonsPast.add(st);
                schedoperationsPast.add(sop);
                operationsPast.add(op);
            }
            else
            {
                surgeonsFuture.add(st);
                schedoperationsFuture.add(sop);
                operationsFuture.add(op);
            }
        }
        request.setAttribute("schedoperationsPast", schedoperationsPast);
        request.setAttribute("surgeonsPast", surgeonsPast);
        request.setAttribute("operationsPast", operationsPast);
        request.setAttribute("schedoperationsPast", schedoperationsFuture);
        request.setAttribute("surgeonsPast", surgeonsFuture);
        request.setAttribute("operationsPast", operationsFuture);
        getServletContext().getRequestDispatcher("/ScheduledOperations.jsp").forward(request, response);
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
