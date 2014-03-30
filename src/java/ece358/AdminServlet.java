/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Users;
import ece358.models.Staff;
import ece358.utils.Constants;
import ece358.utils.SQLSessionUtil;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author GordonMBP
 */
public class AdminServlet extends HttpServlet {

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
        
        boolean queryServletError = false;
        try {
            String query;
            
            if (sessionUser.getRole().equals(Constants.IT))
            {
                query = "SELECT s.* " + 
                        "FROM Staff AS s " + 
                        "WHERE s.JobTitle = 'Doctor' " + 
                        "OR s.JobTitle = 'Surgeon'";

                List<Staff> doctors = (List<Staff>)SQLSessionUtil.selectType(Staff.class, query);
                request.setAttribute("doctors", doctors);

                query = "SELECT s.* " +
                        "FROM Staff AS s";

                List<Staff> staff = (List<Staff>)SQLSessionUtil.selectType(Staff.class, query);
                request.setAttribute("staff", staff);

                query = "SELECT u.* " +
                        "FROM Users AS u";

                List<Users> users = (List<Users>)SQLSessionUtil.selectType(Users.class, query);
                request.setAttribute("users", users);
            }
            
            String action = (String)request.getParameter("action");
            if (action.equals("PasswordReset"))
            {
                String userID = (String)request.getParameter("userID");
                String newPassword = (String)request.getParameter("password");
                
                String hashedPassword = HashPassword(newPassword);
                
                query = "UPDATE Users " + 
                        "SET Password = '" + hashedPassword + "' " + 
                        "WHERE UserID = '" + userID + "'";
                
                SQLSessionUtil.executeUpdate(query);
            }
            else if (action.equals("UpdateStaff"))
            {
                String userID = (String)request.getParameter("userID");
                String managingDoctorID = (String)request.getParameter("managingDoctorID");
                String jobTitle = (String)request.getParameter("jobTitle");
                boolean currentlyEmployed = Boolean.parseBoolean(request.getParameter("currentlyEmployed"));
                
                query = "UPDATE STAFF " + 
                        "SET ManagingDoctorID = '" + managingDoctorID + "' " + 
                        "AND JobTitle = '" + jobTitle + "' " +
                        "AND CurrentlyEmployed = '" + currentlyEmployed + "' " +
                        "WHERE UserID = '" + userID + "'";
                
                SQLSessionUtil.executeUpdate(query);
            }
            else if (action.equals("AddStaff"))
            {
                String password = (String)request.getParameter("password");
                String hashedPassword = HashPassword(password);
                String role = (String)request.getParameter("role");
                String firstName = (String)request.getParameter("firstName");
                String lastName = (String)request.getParameter("lastName");
                String managingDoctorID = (String)request.getParameter("managingDoctorID");
                String jobTitle = (String)request.getParameter("jobTitle");
                
                String userID = firstName.charAt(0) + lastName;
                List<Users> userNameCount = (List<Users>)SQLSessionUtil.selectType(Users.class, "SELECT * FROM Users WHERE UserID LIKE '" + userID + "%'");
                if(!userNameCount.isEmpty())
                {
                    userID += String.valueOf(userNameCount.size());
                }
                
                Users newUser = new Users(userID, hashedPassword, role);
                Staff newStaff = new Staff(userID, firstName, lastName, managingDoctorID, jobTitle, true);
                
                SQLSessionUtil.add(newUser);
                SQLSessionUtil.add(newStaff);
            }
            else 
            {
            }
            
            request.setAttribute("queryServletError", queryServletError);
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
        }
        getServletContext().getRequestDispatcher("/admin.jsp").forward(request, response);
    }
    
    String HashPassword(String password)
    {
        String hashedPassword = "";
        try
        {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(password.getBytes());
            byte hashedPasswordData[] = messageDigest.digest();

            StringBuilder hashedPasswordBuffer = new StringBuilder();
            for (int i = 0; i < hashedPasswordData.length; i++)
                hashedPasswordBuffer.append(Integer.toString((hashedPasswordData[i] & 0xFF) + 0x100, 16).substring(1));

            hashedPassword = hashedPasswordBuffer.toString();
        }
        catch (Exception ex)
        {
        }
        return hashedPassword;
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
