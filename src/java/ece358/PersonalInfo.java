/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;


import ece358.models.Patients;
import ece358.models.Users;
import ece358.models.Country;
import ece358.models.Province;
import ece358.models.Staff;
import ece358.utils.*;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Josh
 */
@WebServlet(name = "PersonalInfo", urlPatterns = {"/PersonalInfo"})
public class PersonalInfo extends HttpServlet {

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
        String Username = sessionUser.getUserId();
        String MinimalMode = request.getParameter("MinimalMode");
        String LookupUserID = request.getParameter("UserID");
        if(MinimalMode != null && (MinimalMode.equals("true") || MinimalMode.equals("false")) )
        {
            request.setAttribute("MinimalMode", Boolean.parseBoolean(MinimalMode));
        }
        else
        {
            request.setAttribute("MinimalMode", false);
        }
        
        if(LookupUserID != null && sessionUser.getRole().equals(Constants.DOCTOR) || sessionUser.getRole().equals(Constants.STAFF))
            Username = LookupUserID;
            

        String url;
        boolean queryServletError = false;
        try {
            int mode = Integer.parseInt(request.getParameter("mode"));
            if(mode == 1 || mode == 2)
            {
                Patients patient = (Patients) SQLSessionUtil.get(Patients.class, Username);
                Staff doctor = (Staff)SQLSessionUtil.get(Staff.class, patient.getDefaultDoctorId());
                if(patient==null)
                    patient = new Patients("", "", "", "", "", "", "", "", "", "", "", "", 0, "", "", "", false);
                request.setAttribute("Address", patient.getAddress() != null ? patient.getAddress() : "");
                request.setAttribute("City", patient.getCity() != null ? patient.getCity() : "");
                request.setAttribute("Province", patient.getProvince() != null ? patient.getProvince() : "");
                request.setAttribute("PostalCode", patient.getPostalCode() != null ? patient.getPostalCode() : "");
                request.setAttribute("Country", patient.getCountry() != null ? patient.getCountry() : "");
                request.setAttribute("DefaultDoctorID", patient.getDefaultDoctorId() != null ? patient.getDefaultDoctorId() : "");
                request.setAttribute("DefaultDoctorLName", doctor.getLastName() != null ? doctor.getLastName() : "");
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
                request.setAttribute("Countries", countries);
                request.setAttribute("Provinces", provinces);
                url = "/PersonalInfo.jsp";
            }
            else if(mode == 3)
            {
                request = PatientValidation.validatePatient(request);
                HashMap<String,String> errors = (HashMap<String,String>) request.getAttribute("errors");
                        
                if(errors.isEmpty())
                {
                    Patients patient = (Patients) SQLSessionUtil.get(Patients.class, Username);
                    patient.setAddress((String)request.getAttribute("Address"));
                    patient.setCity((String)request.getAttribute("City"));
                    patient.setProvince((String)request.getAttribute("Province"));
                    patient.setPostalCode((String)request.getAttribute("PostalCode"));
                    patient.setCountry((String)request.getAttribute("Country"));
                    patient.setEmail((String)request.getAttribute("Email"));
                    patient.setPhoneNumber((String)request.getAttribute("PhoneNumber"));
                    patient.setPrimaryContactNo((String)request.getAttribute("PrimaryContactNo"));
                    SQLSessionUtil.update(patient);
                    url = "/PersonalInfo?mode=1";
                }
                else
                {
                    request.setAttribute("errors", errors);
                    url = "/PersonalInfo?mode=2";
                }
            }
            else
            {
                url = "/PersonalInfo?mode=1";
            }
            
            request.setAttribute("queryServletError", queryServletError);
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
            url = "/PersonalInfo.jsp";
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
