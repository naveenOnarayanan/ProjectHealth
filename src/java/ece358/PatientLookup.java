/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.*;
import ece358.utils.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Josh
 */
public class PatientLookup extends HttpServlet {

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
            String sessionUsername = sessionUser.getUserId();

            if (sessionUser == null) {
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }
            
            String url;
            try {
                int mode = Integer.parseInt(request.getParameter("mode"));
                NarrowResults(request);
                if(mode == 1 || mode == 2)//View/Edit
                {

                    List<Patients> patients = (List<Patients>)request.getAttribute("Patients");
                    String selectedPatient = request.getParameter("PatientSelect");
                    if(selectedPatient == null)
                    {
                        selectedPatient = request.getParameter("PatientUserID");
                    }
                    Patients patient;
                    if(selectedPatient == null)
                    {
                        patient = patient = new Patients("","","","","","","","","","","","",0,"","","",false);
                    }
                    else
                    {
                        patient = (Patients) SQLSessionUtil.get(Patients.class, selectedPatient);
                    }
                    if(patient == null)
                    {

                    }
                    request.setAttribute("PatientUserID", patient.getUserId());
                    request.setAttribute("Address", patient.getAddress() != null ? patient.getAddress() : "");
                    request.setAttribute("City", patient.getCity() != null ? patient.getCity() : "");
                    request.setAttribute("Province", patient.getProvince() != null ? patient.getProvince() : "");
                    request.setAttribute("PostalCode", patient.getPostalCode() != null ? patient.getPostalCode() : "");
                    request.setAttribute("Country", patient.getCountry() != null ? patient.getCountry() : "");
                    request.setAttribute("DefaultDoctorID", patient.getDefaultDoctorId() != null ? patient.getDefaultDoctorId() : "");
                    request.setAttribute("Email", patient.getEmail() != null ? patient.getEmail() : "");
                    request.setAttribute("FirstName", patient.getFirstName() != null ? patient.getFirstName() : "");
                    request.setAttribute("LastName", patient.getLastName() != null ? patient.getLastName() : "");
                    request.setAttribute("HealthCardNumber", patient.getHealthCardNumber() != null ? patient.getHealthCardNumber() : "");
                    request.setAttribute("HealthStatus", patient.getHealthStatus() != null ? patient.getHealthStatus() : "");
                    request.setAttribute("PhoneNumber", patient.getPhoneNumber() != null ? patient.getPhoneNumber() : "");
                    request.setAttribute("PrimaryContactNo", patient.getPrimaryContactNo() != null ? patient.getPrimaryContactNo() : "");
                    request.setAttribute("SIN", patient.getSin() != null ? patient.getSin() : "");
                    request.setAttribute("Visits", patient.getVisits() != null ? patient.getVisits() : "");
                    List<Country> countries  = (List<Country>) SQLSessionUtil.selectType(Country.class, "SELECT * FROM Country");
                    List<Province> provinces  = (List<Province>) SQLSessionUtil.selectType(Province.class, "SELECT * FROM Province");
                    List<Staff> doctors = (List<Staff>) SQLSessionUtil.selectType(Staff.class, "SELECT * FROM Staff WHERE JobTitle='Doctor' ORDER BY LastName");

                    request.setAttribute("Countries", countries);
                    request.setAttribute("Provinces", provinces);
                    request.setAttribute("Doctors", doctors);
                    if(request.getAttribute("FirstNameLookup") == null)
                        request.setAttribute("FirstNameLookup","");
                    if(request.getAttribute("LastNameLookup") == null)
                        request.setAttribute("LastNameLookup","");
                    if(request.getAttribute("PatientUserIDLookup") == null)
                        request.setAttribute("PatientUserIDLookup", "");
                    
                    if(sessionUser.getRole().equals(Constants.DOCTOR) && patient.getDefaultDoctorId().equals(sessionUsername))
                    {
                        List<Object[]> secondaryDoctors = new ArrayList<Object[]>();
                        try{
                                secondaryDoctors = SQLSessionUtil.executeQuery("SELECT DP.SecDoctorID, S2.FirstName, S2.LastName, DP.Expiry " +
                                         "FROM hospital_main.doctorpatientperm as DP, hospital_main.staff as S1, hospital_main.staff as S2 " +
                                         "WHERE DP.DoctorID = S1.UserID AND DP.SecDoctorID = S2.UserID AND DP.DoctorID='" + patient.getDefaultDoctorId() + 
                                         "' AND DP.PatientID='"+ patient.getUserId() +"' AND DP.Expiry >= CURDATE()");
                                request.setAttribute("SecondaryDoctors", secondaryDoctors);
                        }
                        catch(Exception e)
                        {
                            
                        }
                    }
                    url = "/PatientLookup.jsp";
                }
                else if(mode == 3)//Submit
                
                {
                    boolean insert = false;
                    String PatientUserID = request.getParameter("PatientUserID");
                    //New Patient
                    HashMap<String,String> errors = PatientValidation.validatePatient(request);
                    if(errors.isEmpty())
                    {
                        Patients patient = new Patients();
                        if( PatientUserID == null || PatientUserID.isEmpty())
                        {
                            String FirstName = request.getParameter("FirstName").toLowerCase();
                            String LastName = request.getParameter("LastName").toLowerCase();
                            String UserName = FirstName.charAt(0) + LastName;
                            List<Users> userNameCount = (List<Users>)SQLSessionUtil.selectType(Users.class, "SELECT * FROM Users WHERE UserID LIKE '" + UserName + "%'");
                            if(!userNameCount.isEmpty())
                            {
                                UserName += String.valueOf(userNameCount.size());
                            }
                            Users user = new Users(UserName, FirstName, "patient");
                            SQLSessionUtil.add(user);
                            patient.setUserId(UserName);
                            insert = true;
                        }
                        else
                        {
                            patient = (Patients) SQLSessionUtil.get(Patients.class, PatientUserID);
                        }
                        
                        patient.setFirstName(request.getParameter("FirstName"));
                        patient.setLastName(request.getParameter("LastName"));
                        patient.setAddress(request.getParameter("Address"));
                        patient.setCity(request.getParameter("City"));
                        patient.setProvince(request.getParameter("Province"));
                        patient.setPostalCode(request.getParameter("PostalCode"));
                        patient.setCountry(request.getParameter("Country"));
                        patient.setEmail(request.getParameter("Email"));
                        patient.setPhoneNumber(request.getParameter("PhoneNumber"));
                        patient.setPrimaryContactNo(request.getParameter("PrimaryContactNo"));
                        patient.setHealthCardNumber(request.getParameter("HealthCardNumber"));
                        patient.setSin(request.getParameter("SIN"));
                        patient.setDefaultDoctorId(request.getParameter("DefaultDoctorID"));
                        patient.setHealthStatus(request.getParameter("HealthStatus"));
                        
                        if(insert)
                            SQLSessionUtil.add(patient);
                        else
                            SQLSessionUtil.update(patient);
                        url = "/PatientLookup?mode=1" + "&PatientUserID=" + patient.getUserId();
                    }
                    else
                    {
                        request.setAttribute("errors", errors);
                        url = "/PatientLookup?mode=2";
                    }
                }
                else if( mode == 4)//New Patient
                {
                    request.setAttribute("PatientUserID", "");
                    request.setAttribute("Address", "");
                    request.setAttribute("City", "");
                    request.setAttribute("Province", "");
                    request.setAttribute("PostalCode", "");
                    request.setAttribute("Country", "");
                    request.setAttribute("DefaultDoctorID", "");
                    request.setAttribute("Email", "");
                    request.setAttribute("FirstName", "");
                    request.setAttribute("LastName", "");
                    request.setAttribute("HealthCardNumber", "");
                    request.setAttribute("HealthStatus", "");
                    request.setAttribute("PhoneNumber", "");
                    request.setAttribute("PrimaryContactNo", "");
                    request.setAttribute("SIN", "");
                    request.setAttribute("Visits", "");
                    
                    List<Country> countries  = (List<Country>) SQLSessionUtil.selectType(Country.class, "SELECT * FROM Country");
                    List<Province> provinces  = (List<Province>) SQLSessionUtil.selectType(Province.class, "SELECT * FROM Province");
                    List<Staff> doctors = (List<Staff>) SQLSessionUtil.selectType(Staff.class, "SELECT * FROM Staff WHERE JobTitle='Doctor' ORDER BY LastName");
                    request.setAttribute("Countries", countries);
                    request.setAttribute("Provinces", provinces);
                    request.setAttribute("Doctors", doctors);
                    if(request.getAttribute("FirstNameLookup") == null)
                        request.setAttribute("FirstNameLookup","");
                    if(request.getAttribute("LastNameLookup") == null)
                        request.setAttribute("LastNameLookup","");
                    if(request.getAttribute("PatientUserIDLookup") == null)
                        request.setAttribute("PatientUserIDLookup", "");

                    url = "/PatientLookup.jsp";
                }
                else if(mode == 5)//Store DoctorePatientPermissions
                {
                    Map<String, String[]> parameterMap = request.getParameterMap();
                    String DefaultDoctorID = request.getParameter("DefaultDoctorID");
                    String PatientUserID = request.getParameter("PatientUserID");
                    SQLSessionUtil.executeUpdate("DELETE FROM doctorpatientperm WHERE PatientID='" + PatientUserID + "'");
                    for(Map.Entry<String,String[]> parameter : parameterMap.entrySet())
                    {
                        if(parameter.getKey().contains("SecondaryDoctorID"))
                        {
                            String dateString = request.getParameter(parameter.getKey().replace("SecondaryDoctorID", "SecondaryDoctorDT"));
                            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                            Doctorpatientperm dpp = new Doctorpatientperm(PatientUserID, DefaultDoctorID, parameter.getValue()[0], format.parse(dateString));
                            SQLSessionUtil.add(dpp);
                        }
                    }
                    url = "/PatientLookup?mode=1";
                }
                else
                {
                    url = "/PatientLookup?mode=1";
                }

            } catch (Exception e) {
                request.setAttribute("exception", e);
                System.out.println(e);
                url = "/PatientLookup.jsp?mode=1";
            }
            getServletContext().getRequestDispatcher(url).forward(request, response);
    }
    private HttpServletRequest NarrowResults(HttpServletRequest request)
    {
                    String FirstNameLookup = request.getParameter("FirstNameLookup");
                    String LastNameLookup = request.getParameter("LastNameLookup");
                    String PatientUserIDLookup = request.getParameter("PatientUserIDLookup");
                    String LastVisitLookup = request.getParameter("LastVisitLookup");
                    StringBuilder QueryString = new StringBuilder();
                    int conditionCount = 0;
                    QueryString.append("SELECT * FROM Patients ");
                    if(FirstNameLookup != null && !FirstNameLookup.equals(""))
                    {
                        QueryString.append("WHERE FirstName = '");
                        QueryString.append(FirstNameLookup);
                        QueryString.append("' ");
                        conditionCount++;
                    }
                    if(LastNameLookup != null && !LastNameLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and LastName = '");
                        else
                            QueryString.append("WHERE LastName = '");
                        QueryString.append(LastNameLookup);
                        QueryString.append("' ");
                        conditionCount++;
                    }
                    if(PatientUserIDLookup != null && !PatientUserIDLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and UserID = '");
                        else
                            QueryString.append("WHERE UserID = '");
                        QueryString.append(PatientUserIDLookup);
                        QueryString.append("' ");
                        conditionCount++;
                    }
                    //QueryString.append(";");
                    try{
                        List<Patients> patients = (List<Patients>) SQLSessionUtil.selectType(Patients.class, QueryString.toString());
                        request.setAttribute("Patients", patients);
                        request.setAttribute("FirstNameLookup", FirstNameLookup);
                        request.setAttribute("LastNameLookup", LastNameLookup);
                        request.setAttribute("PatientUserIDLookup", PatientUserIDLookup);
                    }
                    catch(Exception E)
                    {
                        
                    }
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
