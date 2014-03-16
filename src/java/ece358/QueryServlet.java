/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ece358;

import ece358.utils.HibernateUtil;
import ece358.models.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wojciech Golab
 */
public class QueryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sessionHash = (String) request.getSession().getAttribute(request.getParameter("username"));
        if (sessionHash == null || sessionHash.isEmpty()) {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        String strQueryNum = request.getParameter("qnum");
        int intQueryNum = Integer.parseInt(strQueryNum);
        boolean queryServletError = false;

        String url;
        try {
            if (intQueryNum == 1) {
                List<Staff> ret = (List<Staff>) HibernateUtil.select("FROM Staff");
                request.setAttribute("employeeList", ret);
            } else if (intQueryNum == 2) {
             //   ArrayList ret = Lab3DBAO.getDepartments();
      //          request.setAttribute("departmentList", ret);
            } else if (intQueryNum == 3) {
                query3helper(request, response);
            } else {
                throw new RuntimeException("Invalid query number: " + intQueryNum);
            }
            url = "/main.jsp";
            request.setAttribute("queryServletError", queryServletError);
            
        } catch (Exception e) {
            queryServletError = true;
            request.setAttribute("exception", e);
            request.setAttribute("queryServletError", queryServletError);
            System.out.println(e);
            url = "/main.jsp";
        }
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    protected void query3helper(HttpServletRequest request, HttpServletResponse response)
            throws java.sql.SQLException, ClassNotFoundException {
        String strEmpID = request.getParameter("empID");
        int empID = -1;
        if (!strEmpID.equals("")) {
            empID = Integer.parseInt(strEmpID);
            if (empID <= 0) {
                throw new RuntimeException("Employee ID out of range");
            }
        }
        String empName = request.getParameter("empName");
        String strDeptID = request.getParameter("deptID");
        int deptID = -1;
        if (!strDeptID.equals("")) {
            deptID = Integer.parseInt(strDeptID);
            if (deptID <= 0) {
                throw new RuntimeException("Department ID out of range");
            }
        }
        String job = request.getParameter("job");
        String strSalary = request.getParameter("salary");
        int salary = -1;
        if (!strSalary.equals("")) {
            salary = Integer.parseInt(strSalary);
            if (salary <= 0) {
                throw new RuntimeException("Salary out of range");
            }
        }

        //ArrayList ret = Lab3DBAO.queryEmployee(empID, empName, deptID, job, salary);
       // request.setAttribute("employeeList", ret);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
