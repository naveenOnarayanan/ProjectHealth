/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.*;
import ece358.utils.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.security.MessageDigest;
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
            if (sessionUser == null) {
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }
            String sessionUsername = sessionUser.getUserId();

            boolean queryServletError = false;
            String url;
            try {
                int mode = Integer.parseInt(request.getParameter("mode"));
                NarrowResults(request);
                if(mode == 1 || mode == 2)//View/Edit
                {

                    List<Patients> patients = (List<Patients>)request.getAttribute("Patients");
                    String selectedPatient = request.getParameter("PatientSelect");
                    if(selectedPatient == null || selectedPatient.isEmpty())
                    {
                        selectedPatient = request.getParameter("PatientUserID");
                    }
                    Patients patient;
                    if((selectedPatient == null || selectedPatient.isEmpty()) && (patients != null && !patients.isEmpty()))
                    {
                        selectedPatient = patients.get(0).getUserId();
                    }
                    if(selectedPatient == null || selectedPatient.isEmpty())
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
                    request.setAttribute("Visits", patient.getVisits() != null ? patient.getVisits().toString() : "");
                    request.setAttribute("Transfered", patient.getTransfered());
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
                    if(request.getAttribute("HealthCardLookup") == null)
                        request.setAttribute("HealthCardLookup", "");
                    if(request.getAttribute("DoctorLookup") == null)
                        request.setAttribute("DoctorLookup", "");
                    
                    
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
                    request = PatientValidation.validatePatient(request);
                    HashMap<String,String> errors = (HashMap<String,String>)request.getAttribute("errors");
                    if(errors.isEmpty())
                    {
                        Patients patient = new Patients();
                        if( PatientUserID == null || PatientUserID.isEmpty())
                        {
                            String FirstName = ((String)request.getAttribute("FirstName")).toLowerCase();
                            String LastName = ((String)request.getParameter("LastName")).toLowerCase();
                            String UserName = FirstName.charAt(0) + LastName;
                            List<Users> userNameCount = (List<Users>)SQLSessionUtil.selectType(Users.class, "SELECT * FROM Users WHERE UserID LIKE '" + UserName + "%'");
                            if(!userNameCount.isEmpty())
                            {
                                UserName += String.valueOf(userNameCount.size());
                            }
                            
                            String hashedPassword;

                            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
                            messageDigest.update(FirstName.getBytes());
                            byte hashedPasswordData[] = messageDigest.digest();

                            StringBuilder hashedPasswordBuffer = new StringBuilder();
                            for (int i = 0; i < hashedPasswordData.length; i++)
                                hashedPasswordBuffer.append(Integer.toString((hashedPasswordData[i] & 0xFF) + 0x100, 16).substring(1));

                            hashedPassword = hashedPasswordBuffer.toString();
                            
                            Users user = new Users(UserName, hashedPassword, "patient"); //TODO: hash
                            SQLSessionUtil.add(user);
                            patient.setUserId(UserName);
                            insert = true;
                        }
                        else
                        {
                            patient = (Patients) SQLSessionUtil.get(Patients.class, PatientUserID);
                        }
                        
                        patient.setFirstName((String)request.getAttribute("FirstName"));
                        patient.setLastName((String)request.getAttribute("LastName"));
                        patient.setAddress((String)request.getAttribute("Address"));
                        patient.setCity((String)request.getAttribute("City"));
                        patient.setProvince((String)request.getAttribute("Province"));
                        patient.setPostalCode((String)request.getAttribute("PostalCode"));
                        patient.setCountry((String)request.getAttribute("Country"));
                        patient.setEmail((String)request.getAttribute("Email"));
                        patient.setPhoneNumber((String)request.getAttribute("PhoneNumber"));
                        patient.setPrimaryContactNo((String)request.getAttribute("PrimaryContactNo"));
                        patient.setHealthCardNumber((String)request.getAttribute("HealthCardNumber"));
                        patient.setSin((String)request.getAttribute("SIN"));
                        patient.setDefaultDoctorId((String)request.getAttribute("DefaultDoctorID"));
                        patient.setHealthStatus((String)request.getAttribute("HealthStatus"));
                        patient.setVisits(Integer.parseInt((String)request.getAttribute("Visits")));
                        String transferred = (String)request.getAttribute("Transfered");
                        patient.setTransfered( (transferred != null && transferred.equals("on")) ? true : false);
                        
                        
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
                    request.setAttribute("Visits", "0");
                    request.setAttribute("Transfered", false);
                    
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
                queryServletError = true;
                request.setAttribute("error", e.getMessage());
                System.out.println(e);
                url = "/PatientLookup.jsp";
            }
            request.setAttribute("queryServletError", queryServletError);
            getServletContext().getRequestDispatcher(url).forward(request, response);
    }
    private HttpServletRequest NarrowResults(HttpServletRequest request)
    {
                    String FirstNameLookup = request.getParameter("FirstNameLookup");
                    String LastNameLookup = request.getParameter("LastNameLookup");
                    String PatientUserIDLookup = request.getParameter("PatientUserIDLookup");
                    String HealthCardLookup = request.getParameter("HealthCardLookup");
                    String DoctorLookup = request.getParameter("DoctorLookup");
                    Boolean TransferedLookup = false;
                    if(request.getParameter("TransferedLookup") != null && request.getParameter("TransferedLookup").equals("on"))
                        TransferedLookup = true;
                    StringBuilder QueryString = new StringBuilder();
                    int conditionCount = 0;
                    QueryString.append("SELECT * FROM Patients ");
                    if(FirstNameLookup != null && !FirstNameLookup.equals(""))
                    {
                        QueryString.append("WHERE FirstName LIKE '%");
                        QueryString.append(FirstNameLookup.replace("'", "''"));
                        QueryString.append("%' ");
                        conditionCount++;
                    }
                    if(LastNameLookup != null && !LastNameLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and LastName LIKE '%");
                        else
                            QueryString.append("WHERE LastName LIKE '%");
                        QueryString.append(LastNameLookup.replace("'", "''"));
                        QueryString.append("%' ");
                        conditionCount++;
                    }
                    if(PatientUserIDLookup != null && !PatientUserIDLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and UserID LIKE '%");
                        else
                            QueryString.append("WHERE UserID LIKE '%");
                        QueryString.append(PatientUserIDLookup.replace("'", "''"));
                        QueryString.append("%' ");
                        conditionCount++;
                    }
                    if(HealthCardLookup != null && !HealthCardLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and HealthCardNumber LIKE '%");
                        else
                            QueryString.append("WHERE HealthCardNumber LIKE '%");
                        QueryString.append(HealthCardLookup.replace("'", "''"));
                        QueryString.append("%' ");
                        conditionCount++;
                    }
                    if(DoctorLookup != null && !DoctorLookup.equals(" ") && !DoctorLookup.equals(""))
                    {
                        if(conditionCount > 0)
                            QueryString.append("and DefaultDoctorID = '");
                        else
                            QueryString.append("WHERE DefaultDoctorID = '");
                        QueryString.append(DoctorLookup.replace("'", "''"));
                        QueryString.append("' ");
                        conditionCount++;
                    }
                    
                    if(conditionCount > 0)
                        QueryString.append("and Transfered = ");
                    else
                        QueryString.append("WHERE Transfered = ");
                    QueryString.append(TransferedLookup.toString());
                    QueryString.append(" ");
                    conditionCount++;
                    //QueryString.append(";");
                    try{
                        List<Patients> patients = (List<Patients>) SQLSessionUtil.selectType(Patients.class, QueryString.toString());
                        request.setAttribute("Patients", patients);
                        request.setAttribute("FirstNameLookup", FirstNameLookup);
                        request.setAttribute("LastNameLookup", LastNameLookup);
                        request.setAttribute("PatientUserIDLookup", PatientUserIDLookup);
                        request.setAttribute("HealthCardLookup", HealthCardLookup);
                        request.setAttribute("DoctorLookup", DoctorLookup);
                        request.setAttribute("TransferedLookup", TransferedLookup);
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
