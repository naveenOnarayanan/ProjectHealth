/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Scheduledoperations;
import ece358.models.Staff;
import ece358.models.Users;
import ece358.models.Visitation;
import ece358.utils.SQLSessionUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author GordonMBP
 */
public class DoctorLookupServlet extends HttpServlet {

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
            throws ServletException, IOException
    {
        Users sessionUser = (Users) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        
        String doctorID = (String)request.getParameter("doctorID");
        if (doctorID == null)
            doctorID = "";
        request.setAttribute("selectedDoctorID", doctorID);
        
        SimpleDateFormat webFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        
        String startDateTimeString = (String)request.getParameter("startDateTime");
        String endDateTimeString = (String)request.getParameter("endDateTime");
        
        Date startDateTime = new Date();
        Date endDateTime = new Date();
        
        try
        {
            startDateTime = webFormat.parse(startDateTimeString);
            endDateTime = webFormat.parse(endDateTimeString);
        }
        catch (ParseException ex)
        {
            //Do nothing, just use the current date time
        }
        
        request.setAttribute("startDateTime", webFormat.format(startDateTime));
        request.setAttribute("endDateTime", webFormat.format(endDateTime));
        
        boolean queryServletError = false;
        String url;
        try {
            int mode = Integer.parseInt(request.getParameter("mode"));
            AddDoctors(request);
            
            if (mode == 2 && !doctorID.isEmpty())
            {
                SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                
                String query = "SELECT v.* " + 
                        "FROM Visitation AS v " + 
                        "WHERE DoctorID = '" + doctorID + "' " +
                        "AND DateTime > '" + sqlFormat.format(startDateTime) + "' " +
                        "AND DateTime < '" + sqlFormat.format(endDateTime) + "' " +
                        "AND Timestamp = (SELECT MAX(V2.Timestamp) FROM Visitation V2 WHERE V2.VisitID=V.VisitID)";
                
                List<Visitation> appointments = (List<Visitation>)SQLSessionUtil.selectType(Visitation.class, query);
                request.setAttribute("appointments", appointments);
                
                List<String> uniquePatients = new ArrayList<String>();
                Iterator<Visitation> appointmentsIterator = appointments.iterator();
                while (appointmentsIterator.hasNext())
                {
                    Visitation visit = appointmentsIterator.next();
                    if (!uniquePatients.contains(visit.getPatientId()))
                        uniquePatients.add(visit.getPatientId());
                }
                List<String> patientIDs = new ArrayList<String>();
                List<Integer> patientVisits = new ArrayList<Integer>();
                Iterator<String> uniquePatientIterator = uniquePatients.iterator();
                while (uniquePatientIterator.hasNext())
                {
                    String patientID = uniquePatientIterator.next();
                    patientIDs.add(patientID);
                    query = "SELECT v.* " +
                            "FROM Visitation AS v " +
                            "WHERE v.doctorID = '" + doctorID + "' " +
                            "AND v.patientID = '" + patientID + "' " +
                            "AND v.dateTime > '" + sqlFormat.format(startDateTime) + "' " +
                            "AND v.dateTime < '" + sqlFormat.format(endDateTime) + "' " +
                            "AND Timestamp = (SELECT MAX(V2.Timestamp) FROM Visitation V2 WHERE V2.VisitID=V.VisitID)";
                    List<Visitation> patientAppointments = (List<Visitation>)SQLSessionUtil.selectType(Visitation.class, query);
                    patientVisits.add(patientAppointments.size());
                }
                request.setAttribute("patientIDs", patientIDs.toArray());
                request.setAttribute("patientVisits", patientVisits.toArray());
                
                List<List<Object[]>> prescriptions = new ArrayList<List<Object[]>>();
                List<List<Scheduledoperations>> visitOperations = new ArrayList<List<Scheduledoperations>>();
                Iterator<Visitation> visitationIterator = appointments.iterator();
                while (visitationIterator.hasNext())
                {
                    Visitation visitation = visitationIterator.next();
                    
                    query = "SELECT d.TradeName, d.DIN, p.Quantity, p.Refills, p.Expiry " +
                            "FROM Prescriptions AS p, Drugs AS d " +
                            "WHERE p.VisitID = '" + visitation.getVisitId() + "' " +
                            "AND p.DIN = d.DIN";
                    prescriptions.add((List<Object[]>) SQLSessionUtil.executeQuery(query));
                    
                    query = "SELECT so.* " +
                            "FROM Scheduledoperations AS so " +
                            "WHERE visitId = '" + visitation.getVisitId() + "'";
                    List<Scheduledoperations> scheduledOperations = (List<Scheduledoperations>)SQLSessionUtil.selectType(Scheduledoperations.class, query);
                    visitOperations.add(scheduledOperations);
                }
                request.setAttribute("visitPrescriptions", prescriptions);
                request.setAttribute("visitOperations", visitOperations);
            }
            
            url = "/DoctorLookup.jsp";
            request.setAttribute("queryServletError", queryServletError);
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
            url = "/main.jsp";
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }
    
    private HttpServletRequest AddDoctors(HttpServletRequest request) throws InstantiationException, IllegalAccessException, SQLException, ClassNotFoundException
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT s.* FROM Staff as s WHERE JobTitle = 'Doctor' OR JobTitle = 'Surgeon'");
        
        List<Staff> doctors = (List<Staff>) SQLSessionUtil.selectType(Staff.class, query.toString());
        request.setAttribute("doctors", doctors);
        return request;
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
