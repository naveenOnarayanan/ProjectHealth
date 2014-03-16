<%-- 
    Document   : personalInfo
    Created on : Mar 16, 2014, 4:46:55 PM
    Author     : Josh
--%>

<%@page import="java.lang.String"%>
<%@page import="ece358.models.Users;"%>
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
        <% String Address = (String) request.getAttribute("Address"); %>
        <% String Doctor = (String) request.getAttribute("Doctor"); %>
        <% String Email = (String) request.getAttribute("Email"); %>
        <% String FirstName = (String) request.getAttribute("FirstName"); %>
        <% String LastName = (String) request.getAttribute("LastName"); %>
        <% String HealthCardNo = (String) request.getAttribute("HealthCardNo"); %>
        <% String HealthStatus = (String) request.getAttribute("HealthStatus"); %>
        <% String PhoneNumber = (String) request.getAttribute("PhoneNumber"); %>
        <% String ContactNo = (String) request.getAttribute("ContactNo"); %>
        <% String SIN = (String) request.getAttribute("SIN"); %>
        <% String Vists = (String) request.getAttribute("Vists"); %>
        <title>JSP Page</title>
    </head>
    <body>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>"); 
        })
        </script>

        <div id="navbar-container"></div>
        <h1>Personal Information</h1>
        <table width="900" cellpadding="10">
            <tr>
                <td>First Name:</td>
                <td><input type = "text" value = "<%=FirstName%>" disabled></input></td>
                <td>Health Card Number:</td>
                <td><input type = "text" value = "<%=HealthCardNo%>" disabled></input></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type = "text" value = "<%=LastName%>" disabled></input></td>
                <td>SIN:</td>
                <td><input type = "text" value = "<%=SIN%>" disabled></input></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><input type = "text" value = "<%=Address%>" disabled></input></td>
                <td>Doctor:</td>
                <td><input type = "text" value = "<%=Doctor%>" disabled></input></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type = "text" value = "<%=Email%>" disabled></input></td>
                <td>Health Status:</td>
                <td><input type = "text" value = "<%=HealthStatus%>" disabled></input></td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td><input type = "text" value = "<%=PhoneNumber%>" disabled></input></td>
                <td>Visits</td>
                <td><input type = "text" value = "<%=Vists%>" disabled></input></td>
            </tr>
            <tr>
                <td>Contact Phone Number:</td>
                <td><input type = "text" value = "<%=ContactNo%>" disabled></input></td>
                <td></td>
                <td align = "left"><button>Edit</button></td>
            </tr>
        </table>
                
    </body>

</html>
