/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Patients;
import ece358.models.Staff;
import ece358.models.Users;
import ece358.models.Visitation;
import ece358.utils.Constants;
import ece358.utils.HibernateUtil;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.derby.client.am.DateTime;

/**
 *
 * @author GordonMBP
 */
@WebServlet(name = "AppointmentServlet", urlPatterns = {"/AppointmentServlet"})
public class AppointmentServlet extends HttpServlet {

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
        //Verify user is logged in
        Users sessionUser = (Users) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        
        String requestType = (String) request.getParameter(Constants.ACTION);

        boolean queryServletError = false;
        
        String url;
        try {
            if (sessionUser.getRole().equals(Constants.PATIENT)) {
                String query =  "SELECT V FROM Visitation AS V " + 
                                "WHERE V.patientId = '" + sessionUser.getUserId() + "' AND V.timestamp=" +
                                "(SELECT MAX(V2.timestamp) FROM Visitation V2 WHERE V2.visitId=V.visitId AND V2.doctorId=V.doctorId) " +
                                "ORDER BY V.visitId";

                List<Visitation> appointments = (List<Visitation>) HibernateUtil.select(query);
                final Patients patientInfo = (Patients) HibernateUtil.get(Patients.class, sessionUser.getUserId());

                query = "SELECT DISTINCT S FROM Staff S, Visitation V " +
                        "WHERE V.patientId='" + sessionUser.getUserId() + "' AND S.userId=V.doctorId";

                List<Staff> doctors = (List<Staff>) HibernateUtil.select(query);

                request.setAttribute("appointments", appointments);
                request.setAttribute("doctors", doctors);
                request.setAttribute("patients", new ArrayList<Patients>(){{add(patientInfo);}});
            } else if (sessionUser.getRole().equals(Constants.STAFF)) {
                if (requestType != null && requestType.equals(Constants.ACTION_UPDATE)) {
                    
                    String appointmentVisitID = (String) request.getParameter("visitID");
                    String appointmentDate = (String) request.getParameter("datetime");
                    String appointmentPatientID = (String) request.getParameter("patientID");
                    String appointmentDoctorID = (String) request.getParameter("doctorID");
                    String appointmentSymptoms = (String) request.getParameter("symptoms");
                    String appointmentDiagnosis = (String) request.getParameter("diagnosis");
                    String appointmentType = (String) request.getParameter("type");
                    String appointmentLength = (String) request.getParameter("length");
                    String appointmentComments = (String) request.getParameter("comments");
                    
                    if (appointmentDoctorID == null || appointmentPatientID == null) {
                        url = request.getRequestURI();
                        request.setAttribute("error", "Invalid data");
                        getServletContext().getRequestDispatcher(url).forward(request, response);
                        return;
                    }
                    
                    Visitation visit = new Visitation();
                    visit.setVisitId(Integer.parseInt(appointmentVisitID));
                    visit.setDateTime(new SimpleDateFormat("MM/dd/yyyy HH:mm").parse(appointmentDate));
                    visit.setPatientId(appointmentPatientID);
                    visit.setDoctorId(appointmentDoctorID);
                    visit.setSymptoms(appointmentSymptoms);
                    visit.setDiagnosis(appointmentDiagnosis);
                    visit.setType(appointmentType);
                    visit.setLength(new SimpleDateFormat("HH:mm").parse(appointmentLength));
                    visit.setComments(appointmentComments);

                    HibernateUtil.add(visit);
                    url = "/AppointmentServlet?action=";
                    getServletContext().getRequestDispatcher(url).forward(request, response);
                    return;
                } else {
                    Staff staffInfo = (Staff) HibernateUtil.get(Staff.class, sessionUser.getUserId());
                    final Staff doctorInfo = (Staff) HibernateUtil.get(Staff.class, staffInfo.getManagingDoctorId());
                    String query =  "SELECT V FROM Visitation V " + 
                                    "WHERE V.doctorId = '" + staffInfo.getManagingDoctorId() + "' AND V.timestamp=" +
                                    "(SELECT MAX(V2.timestamp) FROM Visitation V2 WHERE V2.visitId=V.visitId AND V2.doctorId=V.doctorId) " +
                                    "ORDER BY V.visitId";

                    List<Visitation> appointments = (List<Visitation>) HibernateUtil.select(query);

                    query = "SELECT DISTINCT P FROM Patients P, Visitation V " +
                            "WHERE V.doctorId='" + staffInfo.getManagingDoctorId() + "' AND P.userId=V.patientId";

                    List<Patients> patients = (List<Patients>) HibernateUtil.select(query);
                    request.setAttribute("appointments", appointments);
                    request.setAttribute("doctors", new ArrayList<Staff>() {{add(doctorInfo);}});
                    request.setAttribute("patients", patients);
                }
            } else if (sessionUser.getRole().equals(Constants.DOCTOR)) {
                /*
                StringBuilder query = new StringBuilder("FROM Visitation as v, ")
                */
                List<String> conditionList = new ArrayList<String>();
                
                //Patient First Name
                String patientFirstName = (String)request.getSession().getAttribute("patientFirstName");
                if (patientFirstName != null && !patientFirstName.isEmpty()) {
                    conditionList.add("Patient.FirstName = '" + patientFirstName + "'");
                }
                
                //Patient Last Name
                String patientLastName = (String)request.getSession().getAttribute("patientFirstName");
                if (patientLastName != null && !patientLastName.isEmpty()) {
                    conditionList.add("Patient.LastName = '" + patientLastName + "'");
                }
                
                //Freeform
                String freeform = (String)request.getSession().getAttribute("freeform");
                if (freeform != null && !freeform.isEmpty()) {
                    conditionList.add("Visitation. = '" + freeform + "'");
                }
            } else if (sessionUser.getRole().equals("finance")) {
                //TODO
            } else {
                //TODO
            }
            url = "/appointments.jsp";
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
    
    StringBuilder AddSQLCondition(StringBuilder query, String condition) {
        if (query.toString().indexOf("WHERE") == -1) {
            query.append(" WHERE ");
        } else {
            query.append(" && ");
        }
        return query.append(condition);
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
