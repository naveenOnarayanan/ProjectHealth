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
        <% int mode  = Integer.parseInt((String)request.getParameter("mode"));%>
        <% String buttons = "<button><a href = 'personalInfo?mode=2'>Edit</a>";%>
        <% String disabled = "";
           if(mode == 1)
           {
               disabled = "disabled";
           }
           else if(mode == 2)
           {
               buttons = "<button><a href = 'personalInfo?mode=1'>Cancel</a></button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<button><a href='personalInfo?mode=3'>Save</a></button>";
           }%>

           
        <title>Personal Information</title>
    </head>
    <body>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>"); 
        })
        </script>

        <div id="navbar-container"></div>
        <h1>Personal Information</h1>
        <form action="" method="post">
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
                <td><input type = "text" value = "<%=Address%>" <%=disabled%>></input></td>
                <td>Doctor:</td>
                <td><input type = "text" value = "<%=Doctor%>" disabled></input></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type = "email" value = "<%=Email%>" <%=disabled%>></input></td>
                <td>Health Status:</td>
                <td><input type = "text" value = "<%=HealthStatus%>" disabled></input></td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td><input type = "tel" value = "<%=PhoneNumber%>" <%=disabled%>></input></td>
                <td>Visits:</td>
                <td><input type = "text" value = "<%=Vists%>" disabled></input></td>
            </tr>
            <tr>
                <td>Contact Phone Number:</td>
                <td><input type = "tel"  pattern='[\+]\d{2}[\(]\d{2}[\)]\d{4}[\-]\d{4}' value = "<%=ContactNo%>" <%=disabled%>></input></td>
                <td></td>
                <td align = "left"><%=buttons%></td>
            </tr>
        </table>
        </form>
                
    </body>

</html>
