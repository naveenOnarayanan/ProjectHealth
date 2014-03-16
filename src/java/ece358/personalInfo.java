/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Patients;
import ece358.models.Users;
import ece358.utils.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Josh
 */
public class personalInfo extends HttpServlet {

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
          
            url = "/personalInfo.jsp";
            Patients patient = (Patients) HibernateUtil.get(Patients.class, sessionUsername);
            request.setAttribute("Address", patient.getAddress() != null ? patient.getAddress() : "");
            request.setAttribute("Doctor", patient.getDefaultDoctorId() != null ? patient.getDefaultDoctorId() : "");
            request.setAttribute("Email", patient.getEmail() != null ? patient.getEmail() : "");
            request.setAttribute("FirstName", patient.getFirstName() != null ? patient.getFirstName() : "");
            request.setAttribute("LastName", patient.getLastName() != null ? patient.getLastName() : "");
            request.setAttribute("HealthCardNo", patient.getHealthCardNumber() != null ? patient.getHealthCardNumber() : "");
            request.setAttribute("HealthStatus", patient.getHealthStatus() != null ? patient.getHealthStatus() : "");
            request.setAttribute("PhoneNumber", patient.getPhoneNumber() != null ? patient.getPhoneNumber() : "");
            request.setAttribute("ContactNo", patient.getPrimaryContactNo() != null ? patient.getPrimaryContactNo() : "");
            request.setAttribute("SIN", patient.getSin() != null ? patient.getSin() : "");
            request.setAttribute("Visits", patient.getVisits() != null ? patient.getVisits() : "");
            
            
        } catch (Exception e) {
            request.setAttribute("exception", e);
            System.out.println(e);
            url = "/personalInfo.jsp";
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
