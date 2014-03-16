/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Users;
import ece358.models.Visitation;
import ece358.utils.HibernateUtil;
import java.io.IOException;
import java.util.List;
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
        
        boolean queryServletError = false;
        
        String url;
        try {
            if (sessionUser.getRole().equals("patient")) {
                String query =  "FROM Visitation " + 
                                "WHERE patientID = '" + sessionUser.getUserId() + "'";
                List<Visitation> appointments = (List<Visitation>) HibernateUtil.select(query);
                    request.setAttribute("appointments", appointments);
            } else if (sessionUser.getRole().equals("staff")) {
                //TODO
            } else if (sessionUser.getRole().equals("doctor")) {
                //TODO
            } else if (sessionUser.getRole().equals("finance")) {
                //TODO
            } else {
                //TODO
            }
            url = "/appointments.jsp";
            request.setAttribute("queryServletError", queryServletError);
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("exception", e);
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
            url = "/appointments.jsp";
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
