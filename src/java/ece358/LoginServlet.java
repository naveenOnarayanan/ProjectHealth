/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Users;
import ece358.models.Patients;
import ece358.models.Staff;
import ece358.utils.SQLSessionUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ZGaming
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String url = "/index.jsp";
        String mode = (String) request.getParameter("mode");
        if(mode != null && mode.equals("login"))
        {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                String hashedPassword;

                MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
                messageDigest.update(password.getBytes());
                byte hashedPasswordData[] = messageDigest.digest();

                StringBuilder hashedPasswordBuffer = new StringBuilder();
                for (int i = 0; i < hashedPasswordData.length; i++)
                    hashedPasswordBuffer.append(Integer.toString((hashedPasswordData[i] & 0xFF) + 0x100, 16).substring(1));

                hashedPassword = hashedPasswordBuffer.toString();
                
                Users user = (Users) SQLSessionUtil.get(Users.class, username);
                
                if (user == null || !user.getPassword().equals(hashedPassword)) {
                    request.setAttribute("error", "Invalid Username and Password");
                } else {
                    if(user.getRole().equals("doctor") || user.getRole().equals("staff") ||user.getRole().equals("finance"))
                    {
                        Staff staff = (Staff) SQLSessionUtil.get(Staff.class, username);
                        request.getSession().setAttribute("firstname", staff.getFirstName());
                        request.getSession().setAttribute("lastname", staff.getLastName());
                    }
                    if(user.getRole().equals("patient"))
                    {
                        Patients patient = (Patients) SQLSessionUtil.get(Patients.class, username);
                        request.getSession().setAttribute("firstname", patient.getFirstName());
                        request.getSession().setAttribute("lastname", patient.getLastName());
                    }
                    url = "/main.jsp";
                }
                request.getSession().setAttribute("user", user);
            } catch (Exception e) {
                url="/index.jsp";
                request.setAttribute("error", "Invalid Username and Password");
            }
        }
        else {
            request.getSession().setAttribute("user", null);
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
