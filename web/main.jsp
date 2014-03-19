<%-- 
    Document   : index
    Created on : Mar 13, 2014, 8:35:54 PM
    Author     : ZGaming
--%>
<%@page import="ece358.models.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ece358.models.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <%! ArrayList<Staff> employeeList;%>
        <% employeeList = (ArrayList<Staff>) request.getAttribute("employeeList");%>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
        <% String error = (String) request.getAttribute("error"); %>
        <title>Project Health</title>
    </head>
    <body>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
           "<%=request.getSession().getAttribute("firstname")%>",
           "<%=request.getSession().getAttribute("lastname")%>");
        })
        </script>

        <div id="navbar-container"></div>
        <%
           if (error != null && !error.equals("")) { 
        %>
               <div class="alert alert-dismissable alert-danger">
                   <button type="button" class="close" data-dismiss="alert">x</button>
                   <%= error %>
               </div>
        <%
           } 
        %>
        <ul>
            <button><a href="QueryServlet?qnum=2">Update user 0</a></button>
            <button><a href="QueryServlet?qnum=3">Add user</a></button>
            <button><a href="QueryServlet?qnum=4">Delete user 0</a></button>
            <button><a href="QueryServlet?qnum=1">List all employees</a></button>
            <% 
                if(queryServletError != null && !queryServletError){
            %>
                <h1>Employee Data</h1>
                <table border=1><tr><th>ID</th><th>First Name</th><th>Last Name</th></tr>
                    <% 
                        if(employeeList != null){
                    %>
                        <%
                            for (Staff em : employeeList) {
                        %>
                        <tr>
                            <td><%= em.getUserId()%></td>
                            <td><%= em.getFirstName()%></td>
                            <td><%= em.getLastName()%></td>
                        </tr>
                        <%
                            }
                        %>
                    <% 
                        }
                    %>
                </table>
            <%
                }
                else if(queryServletError != null && queryServletError){
            %>
            <h1>Query Error</h1>
            <%
                    }
            %>
           
        </ul>
         
    </body>
</html>
