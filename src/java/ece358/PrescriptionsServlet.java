/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358;

import ece358.models.Users;
import ece358.models.PrescriptionInfo;
import ece358.utils.Constants;
import ece358.utils.SQLSessionUtil;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import java.util.Date;

/**
 *
 * @author Eric
 */
@WebServlet(name = "PrescriptionsServlet", urlPatterns = {"/PrescriptionsServlet"})
public class PrescriptionsServlet extends HttpServlet {

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
            String query = "";
            if (sessionUser.getRole().equals(Constants.PATIENT)){
                query = "SELECT active.PatientID, active.DIN, drugs.TradeName, " +
                        "active.Quantity, active.Refills, active.Dosage, " +
                        "active.DateTime, active.Expiry " +
                        "FROM (SELECT visitation.PatientID, visitation.DoctorID, visitation.DateTime ,prescriptions.*" +
                                "FROM visitation " +
                                "INNER JOIN prescriptions " +
                                "ON visitation.VisitID = prescriptions.VisitID) as active " +
                        "INNER JOIN drugs " +
                        "ON active.DIN = drugs.DIN " +
                        "WHERE active.PatientID = '" + sessionUser.getUserId() + "' " +
                        "ORDER BY VisitID";
            }
            else if (sessionUser.getRole().equals(Constants.STAFF)){
                query = "SELECT ManagingDoctorID " +
                        "FROM Staff " +
                        "WHERE UserID = '" + sessionUser.getUserId() +"'";
                
                List<Object[]> result = SQLSessionUtil.executeQuery(query);
                String managingDoctor = result.get(0)[0].toString();
                
                query = "SELECT active.PatientID, active.DIN, drugs.TradeName, " +
                        "active.Quantity, active.Refills, active.Dosage, " +
                        "active.DateTime, active.Expiry " +
                        "FROM (SELECT visitation.PatientID, visitation.DoctorID, visitation.DateTime ,prescriptions.*" +
                                "FROM visitation " +
                                "INNER JOIN prescriptions " +
                                "ON visitation.VisitID = prescriptions.VisitID " +
                                "WHERE visitation.DoctorID = '" + managingDoctor + "')as active " +
                        "INNER JOIN drugs " +
                        "ON active.DIN = drugs.DIN " +
                        "ORDER BY VisitID";
            }
            else if (sessionUser.getRole().equals(Constants.DOCTOR)){
                query = "SELECT active.PatientID, active.DIN, drugs.TradeName, " +
                        "active.Quantity, active.Refills, active.Dosage, " +
                        "active.DateTime, active.Expiry " +
                        "FROM (SELECT visitation.PatientID, visitation.DoctorID, visitation.DateTime ,prescriptions.*" +
                                "FROM visitation " +
                                "INNER JOIN prescriptions " +
                                "ON visitation.VisitID = prescriptions.VisitID " +
                                "WHERE visitation.DoctorID = '" + sessionUser.getUserId() + "')as active " +
                        "INNER JOIN drugs " +
                        "ON active.DIN = drugs.DIN " +
                        "ORDER BY VisitID";
            }
                
            List<Object[]> prescriptionInfoObjects = (List<Object[]>) SQLSessionUtil.executeQuery(query);
            ArrayList<PrescriptionInfo> prescriptions = new ArrayList<PrescriptionInfo>();

            for (Object[] o : prescriptionInfoObjects) {
                PrescriptionInfo temp = new PrescriptionInfo();
                temp.setPatientID((String)o[0]);
                temp.setDIN((Integer)o[1]);
                temp.setName((String)o[2]);
                temp.setQuantity((Integer)o[3]);
                temp.setRefills((Integer)o[4]);
                temp.setDosage((String)o[5]);
                temp.setIssue((Date)o[6]);
                temp.setExpiry((Date)o[7]);
                prescriptions.add(temp);
            }

            request.setAttribute("prescriptions", prescriptions);
            request.setAttribute("queryServletError", queryServletError);
            
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("error", e.getMessage());
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
        }
        getServletContext().getRequestDispatcher("/Prescriptions.jsp").forward(request, response);
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
