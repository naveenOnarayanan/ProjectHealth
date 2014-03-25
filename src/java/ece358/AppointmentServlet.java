/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Drugs;
import ece358.models.Operations;
import ece358.models.Patients;
import ece358.models.Prescriptions;
import ece358.models.Scheduledoperations;
import ece358.models.Staff;
import ece358.models.Users;
import ece358.models.Visitation;
import ece358.utils.Constants;
import ece358.utils.SQLSessionUtil;
import java.io.IOException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        String requestVisitId = (String) request.getParameter("visitId");
        String requestPatientId = (String) request.getParameter("patientId");
        
        Boolean visitQuery = (requestType != null && requestVisitId != null && !requestType.isEmpty() && !requestVisitId.isEmpty());
        Boolean patientIdQuery = (requestType != null && requestPatientId != null && !requestType.isEmpty() && !requestPatientId.isEmpty());

        boolean queryServletError = false;
        
        String url = "/appointments.jsp";
        try {
            
            String appointmentVisitID = (String) request.getParameter("visitID");
            String appointmentDate = (String) request.getParameter("datetime");
            String appointmentPatientID = (String) request.getParameter("patientID");
            String appointmentDoctorID = (String) request.getParameter("doctorID");
            String appointmentSymptoms = (String) request.getParameter("symptoms");
            String appointmentDiagnosis = (String) request.getParameter("diagnosis");
            String appointmentType = (String) request.getParameter("type");
            String appointmentLength = (String) request.getParameter("length");
            String appointmentComments = (String) request.getParameter("comments");
            String appointmentPrescriptions = (String) request.getParameter("prescriptions-list");
            String appointmentOperations = (String) request.getParameter("operations-list");
            String appointmentComplete = (String) request.getParameter("apptComplete");
            String appointmentCancelled = (String) request.getParameter("apptCancelled");
            
            if (sessionUser.getRole().equals(Constants.PATIENT)) {
                String query =  "SELECT V.* FROM Visitation AS V " + 
                                "WHERE V.PatientID = '" + sessionUser.getUserId() + "' " + ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "") + 
                                    " AND V.Cancelled=false AND V.Timestamp=" +
                                        "(SELECT MAX(V2.Timestamp) FROM Visitation V2 WHERE V2.VisitID=V.VisitID AND V2.DoctorID=V.DoctorID) " +
                                "ORDER BY V.VisitID";

                List<Visitation> appointments = (List<Visitation>) SQLSessionUtil.selectType(Visitation.class, query);
                final Patients patientInfo = (Patients) SQLSessionUtil.get(Patients.class, sessionUser.getUserId());

                query = "SELECT DISTINCT S.* FROM Staff AS S " +
                        "INNER JOIN Visitation AS V " +
                        "ON V.DoctorID=S.UserID " +
                        "WHERE V.PatientID='" + sessionUser.getUserId() + "' " + ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "");

                List<Staff> doctors = (List<Staff>) SQLSessionUtil.selectType(Staff.class, query);
                
                List<Visitation> upcomingAppointments = new ArrayList<Visitation>();
                List<Visitation> pastAppointments = new ArrayList<Visitation>();

                Date today = new Date();

                for (int i = 0; i < appointments.size(); i++) {
                    query = "SELECT DISTINCT P.DIN, D.TradeName " +
                            "FROM Prescriptions AS P " +
                            "INNER JOIN Drugs AS D " +
                            "WHERE P.VisitID='" + appointments.get(i).getVisitId() + "' AND P.DIN=D.DIN";
                    List<Object[]> prescriptions = SQLSessionUtil.executeQuery(query);
                    
                    query = "SELECT S.* " +
                                "FROM ScheduledOperations AS S " +
                                "WHERE S.VisitID=" + appointments.get(i).getVisitId();

                    appointments.get(i).setOperations((List<Scheduledoperations>)SQLSessionUtil.selectType(Scheduledoperations.class, query));
                    appointments.get(i).setPrescriptions(prescriptions);
                    
                    if (today.before(appointments.get(i).getDateTime())) {
                        upcomingAppointments.add(appointments.get(i));
                    } else {
                        pastAppointments.add(appointments.get(i));
                    }
                }

                request.setAttribute("pastAppointments", pastAppointments);
                request.setAttribute("upcomingAppointments", upcomingAppointments);
                request.setAttribute("doctors", doctors);
                request.setAttribute("patients", new ArrayList<Patients>(){{add(patientInfo);}});
                request.setAttribute("drugs", new ArrayList<Drugs>());
            } else if (sessionUser.getRole().equals(Constants.STAFF)) {
                if (requestType != null && requestType.equals(Constants.ACTION_INSERT)) {
                    
                    if (appointmentPatientID == null) {
                        url = "/AppointmentServlet?action=";
                        request.setAttribute("error", "Invalid data");
                        getServletContext().getRequestDispatcher(url).forward(request, response);
                        return;
                    }

                    Visitation visit = new Visitation();
                    visit.setDateTime(new SimpleDateFormat("MM/dd/yyyy hh:mm aa").parse(appointmentDate));
                    visit.setPatientId(appointmentPatientID);
                    visit.setDoctorId(appointmentDoctorID);
                    visit.setSymptoms(appointmentSymptoms);
                    visit.setType(appointmentType);
                    visit.setLength(new Time((new SimpleDateFormat("HH:mm").parse(appointmentLength)).getTime()));
                    visit.setApptComplete((appointmentComplete != null && appointmentComplete.equals("on")) ? true : false);
                    visit.setCancelled((appointmentCancelled != null && appointmentCancelled.equals("on")) ? true : false);

                    SQLSessionUtil.add(visit);
                    url = "/AppointmentServlet?action=";
                } else if (requestType != null && requestType.equals(Constants.ACTION_UPDATE)) {

                    if (appointmentDoctorID == null || appointmentPatientID == null) {
                        url = "/AppointmentServlet?action=";
                        request.setAttribute("error", "Invalid data");
                        getServletContext().getRequestDispatcher(url).forward(request, response);
                        return;
                    }

                    Visitation visit = new Visitation();
                    visit.setVisitId(Integer.parseInt(appointmentVisitID));
                    visit.setDateTime(new SimpleDateFormat("MM/dd/yyyy hh:mm aa").parse(appointmentDate));
                    visit.setPatientId(appointmentPatientID);
                    visit.setDoctorId(appointmentDoctorID);
                    visit.setSymptoms(appointmentSymptoms);
                    visit.setDiagnosis(appointmentDiagnosis);
                    visit.setType(appointmentType);
                    visit.setLength(new Time((new SimpleDateFormat("HH:mm").parse(appointmentLength)).getTime()));
                    visit.setComments(appointmentComments);
                    visit.setApptComplete((appointmentComplete != null && appointmentComplete.equals("on")) ? true : false);
                    visit.setCancelled((appointmentCancelled != null && appointmentCancelled.equals("on")) ? true : false);

                    SQLSessionUtil.add(visit);
                    url = "/AppointmentServlet?action=";
                } else {
                    Staff staffInfo = (Staff) SQLSessionUtil.get(Staff.class, sessionUser.getUserId());
                    final Staff doctorInfo = (Staff) SQLSessionUtil.get(Staff.class, staffInfo.getManagingDoctorId());
                    String query =  "SELECT V.* FROM Visitation AS V " + 
                                    "WHERE V.DoctorID = '" + staffInfo.getManagingDoctorId() + "' " + ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "") +
                                        ((patientIdQuery) ? " AND V.PatientID='" + requestPatientId + "'" : "") +
                                        " AND V.Cancelled=false AND V.Timestamp=" +
                                            "(SELECT MAX(V2.Timestamp) FROM Visitation AS V2 WHERE V2.VisitID=V.VisitID AND V2.DoctorID=V.DoctorID) " +
                                    "ORDER BY V.DateTime DESC";

                    List<Visitation> appointments = (List<Visitation>) SQLSessionUtil.selectType(Visitation.class, query);

                    query = "SELECT DISTINCT P.* FROM Patients AS P, Visitation AS V " +
                            "WHERE V.DoctorID='" + staffInfo.getManagingDoctorId() + "' AND P.UserID=V.PatientID " + ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "") +
                                        ((patientIdQuery) ? " AND V.PatientID='" + requestPatientId + "'" : "");

                    List<Patients> patients = (List<Patients>) SQLSessionUtil.selectType(Patients.class, query);
                    
                    List<Visitation> upcomingAppointments = new ArrayList<Visitation>();
                    List<Visitation> pastAppointments = new ArrayList<Visitation>();
                    
                    Date today = new Date();
                    
                    for (int i = 0; i < appointments.size(); i++) {
                        query = "SELECT DISTINCT P.*, D.TradeName " +
                            "FROM Prescriptions AS P " +
                            "INNER JOIN Drugs AS D " +
                            "WHERE VisitID=" + appointments.get(i).getVisitId() + " AND P.DIN=D.DIN";
                        List<Object[]> prescriptions = SQLSessionUtil.executeQuery(query);

                        query = "SELECT S.* " +
                                "FROM ScheduledOperations AS S " +
                                "WHERE S.VisitID=" + appointments.get(i).getVisitId();
                        
                        appointments.get(i).setOperations((List<Scheduledoperations>)SQLSessionUtil.selectType(Scheduledoperations.class, query));
                        appointments.get(i).setPrescriptions(prescriptions);
                        
                        if (today.before(appointments.get(i).getDateTime())) {
                            upcomingAppointments.add(appointments.get(i));
                        } else {
                            pastAppointments.add(appointments.get(i));
                        }
                        
                    }

                    List<Drugs> drugs = (List<Drugs>) SQLSessionUtil.selectType(Drugs.class, "SELECT * FROM Drugs");

                    request.setAttribute("pastAppointments", pastAppointments);
                    request.setAttribute("upcomingAppointments", upcomingAppointments);
                    request.setAttribute("doctors", new ArrayList<Staff>() {{add(doctorInfo);}});
                    request.setAttribute("patients", patients);
                    request.setAttribute("drugs", drugs);
                }
            } else if (sessionUser.getRole().equals(Constants.DOCTOR)) {
                if (requestType != null && requestType.equals(Constants.ACTION_UPDATE)) {
                    if (appointmentDoctorID == null || appointmentPatientID == null) {
                        url = "/AppointmentServlet?action=";
                        request.setAttribute("error", "Invalid data");
                        getServletContext().getRequestDispatcher(url).forward(request, response);
                        return;
                    }

                    Integer visitId = Integer.parseInt(appointmentVisitID);

                    Visitation visit = new Visitation();
                    visit.setVisitId(visitId);
                    visit.setDateTime(new SimpleDateFormat("MM/dd/yyyy hh:mm aa").parse(appointmentDate));
                    visit.setPatientId(appointmentPatientID);
                    visit.setDoctorId(appointmentDoctorID);
                    visit.setSymptoms(appointmentSymptoms);
                    visit.setDiagnosis(appointmentDiagnosis);
                    visit.setType(appointmentType);
                    visit.setLength(new Time((new SimpleDateFormat("HH:mm").parse(appointmentLength)).getTime()));
                    visit.setComments(appointmentComments);
                    visit.setApptComplete((appointmentComplete != null && appointmentComplete.equals("on")) ? true : false);
                    visit.setCancelled((appointmentCancelled != null && appointmentCancelled.equals("on")) ? true : false);

                    SQLSessionUtil.add(visit);

                    if (appointmentPrescriptions != null && !appointmentPrescriptions.isEmpty()) {
                        String[] prescriptionInfos = appointmentPrescriptions.split(";");
                        for (String prescriptionInfo : prescriptionInfos) {
                            Prescriptions prescription = new Prescriptions();
                            String[] prescriptionArray = prescriptionInfo.split("\\|");
                            prescription.setVisitId(visitId);
                            prescription.setDin(Integer.valueOf(prescriptionArray[0]));
                            prescription.setQuantity(Integer.valueOf(prescriptionArray[1]));
                            prescription.setRefills(Integer.valueOf(prescriptionArray[2]));
                            prescription.setDosage(prescriptionArray[3]);
                            prescription.setExpiry(new SimpleDateFormat("MM/dd/yyyy hh:mm aa").parse(prescriptionArray[4]));
                            SQLSessionUtil.add(prescription);
                        }
                    }
                    
                    if (appointmentOperations != null && !appointmentOperations.isEmpty()) {
                        String[] operationsInfos = appointmentOperations.split(";");
                        for (String operationInfo : operationsInfos) {
                            Scheduledoperations operation = new Scheduledoperations();
                            String[] operationArray = operationInfo.split("\\|");
                            operation.setVisitId(visitId);
                            operation.setOperationDateTime(new SimpleDateFormat("MM/dd/yyyy hh:mm aa").parse(operationArray[0]));
                            operation.setOperationName(operationArray[1]);
                            operation.setDoctorId(operationArray[2]);
                            SQLSessionUtil.add(operation);
                        }
                    }
                    url = "/AppointmentServlet?action=";
                } else {
                    String query = "SELECT DISTINCT S.* " +
                            "FROM Staff AS S " +
                            "WHERE S.UserID='" + sessionUser.getUserId() + "' OR S.UserID " +
                                    "IN (SELECT D.DoctorID FROM DoctorPatientPerm AS D WHERE D.SecDoctorID='" + sessionUser.getUserId() + "' AND D.Expiry > CURDATE())";

                    List<Staff> doctorInfo = (List<Staff> ) SQLSessionUtil.selectType(Staff.class, query);

                    query =  "SELECT V.* " +
                                    "FROM Visitation AS V " +
                                    "WHERE (V.DoctorID='" + sessionUser.getUserId() + "' OR V.PatientID IN " + 
                                            "(SELECT DISTINCT D.PatientID FROM doctorpatientperm AS D WHERE D.SecDoctorID='" + sessionUser.getUserId() + "' AND D.Expiry > CURDATE())) " + 
                                                ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "") +
                                                ((patientIdQuery) ? " AND V.PatientID='" + requestPatientId + "'" : "") +
                                                " AND V.Cancelled=false AND V.Timestamp= " +
                                                    "(SELECT MAX(V2.Timestamp) FROM Visitation AS V2 WHERE V2.VisitID=V.VisitID AND V2.DoctorID=V.DoctorID) " +
                                    "ORDER BY V.VisitID ";

                    List<Visitation> appointments = (List<Visitation>) SQLSessionUtil.selectType(Visitation.class, query);

                    query = "SELECT DISTINCT P.* FROM Patients AS P, Visitation AS V, DoctorPatientPerm as D " +
                            "WHERE (V.DoctorID='" + sessionUser.getUserId() + "' OR (V.PatientID=D.PatientID AND SecDoctorID='" + 
                            sessionUser.getUserId() + "'))  AND P.UserID=V.PatientID " + ((visitQuery) ? "AND V.VisitID=" + requestVisitId : "") +
                                        ((patientIdQuery) ? " AND V.PatientID='" + requestPatientId + "'" : "");

                    List<Patients> patients = (List<Patients>) SQLSessionUtil.selectType(Patients.class, query);
                    
                    List<Visitation> upcomingAppointments = new ArrayList<Visitation>();
                    List<Visitation> pastAppointments = new ArrayList<Visitation>();
                    
                    Date today = new Date();
                    
                    for (int i = 0; i < appointments.size(); i++) {
                        query = "SELECT DISTINCT P.*, D.TradeName " +
                            "FROM Prescriptions AS P " +
                            "INNER JOIN Drugs AS D " +
                            "WHERE VisitID=" + appointments.get(i).getVisitId() + " AND P.DIN=D.DIN";
                        List<Object[]> prescriptions = SQLSessionUtil.executeQuery(query);
                        
                        query = "SELECT S.* " +
                                "FROM ScheduledOperations AS S " +
                                "WHERE S.VisitID=" + appointments.get(i).getVisitId();

                        appointments.get(i).setOperations((List<Scheduledoperations>)SQLSessionUtil.selectType(Scheduledoperations.class, query));
                        appointments.get(i).setPrescriptions(prescriptions);
                        
                        if (today.before(appointments.get(i).getDateTime())) {
                            upcomingAppointments.add(appointments.get(i));
                        } else {
                            pastAppointments.add(appointments.get(i));
                        }
                    }

                    List<Operations> operations = (List<Operations>) SQLSessionUtil.selectType(Operations.class, "SELECT * FROM Operations");
                    List<Object[]> allStaff = SQLSessionUtil.executeQuery("SELECT UserID, FirstName, LastName, JobTitle FROM Staff");
                    List<Drugs> drugs = (List<Drugs>) SQLSessionUtil.selectType(Drugs.class, "SELECT * FROM Drugs");

                    request.setAttribute("pastAppointments", pastAppointments);
                    request.setAttribute("upcomingAppointments", upcomingAppointments);
                    request.setAttribute("doctors", doctorInfo);
                    request.setAttribute("patients", patients);
                    request.setAttribute("drugs", drugs);
                    request.setAttribute("operations", operations);
                    request.setAttribute("staff", allStaff);
                }
            }
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            System.out.println(e);
            url = "/appointments.jsp";
        }
        request.setAttribute("queryServletError", queryServletError);
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
