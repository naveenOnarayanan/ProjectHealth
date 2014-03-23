<%-- 
    Document   : Prescriptions
    Created on : 20-Mar-2014, 2:49:13 PM
    Author     : Eric
--%>

<%@page import="ece358.models.PrescriptionInfo"%>
<%@page import="java.util.Date"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="ece358.utils.Constants"%>
<%@page import="ece358.models.Users"%>
<%@page import="ece358.models.Drugs"%>
<%@page import="ece358.models.Patients"%>
<%@page import="ece358.models.Visitation"%>
<%@page import="ece358.models.Prescriptions"%>
<%@page import="ece358.models.Doctorpatientperm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.5.1/moment.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-datetimepicker.ru.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/2.1.30/js/bootstrap-datetimepicker.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/fonts/glyphicons-halflings-regular.svg"/>
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/2.1.30/css/bootstrap-datetimepicker.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <title>Prescriptions</title>
    </head>
    <body>
        <script>
            $(function() {
                getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
                "<%=request.getSession().getAttribute("firstname")%>",
                "<%=request.getSession().getAttribute("lastname")%>");
            });
        </script>

        <div id="navbar-container"></div>
        
        <%  Users user = (Users) request.getSession().getAttribute("user"); %>
        
        <table style="width: 100%">
            <tr>
                <th style="width: 63%"><h1 class="table-header">Prescriptions</h1></th>
                <% if (!user.getRole().equals(Constants.PATIENT)) {%>
                <th>
                    <input type="text" class="table-search-box" placeholder="Filter results by UserID">
                    <input type="button" class="search-button" value="Search">
                </th>
                <%}%>
            </tr>
        </table>
        
        <div id="content">
            <table id="appointments" class="table table-hover">
                <thead>
                    <tr>
                        <% if (!user.getRole().equals(Constants.PATIENT)) {%>
                        <th>Patient</th>
                        <th>DIN</th>
                        <%}%>
                        <th>Drug Name</th>
                        <th>Quantity (in mg)</th>
                        <th>Refills</th>
                        <th>Dosage</th>
                        <th>Prescribed Date</th>
                        <th>Expiry</th>
                    </tr>
                </thead>
                <%
                    List<PrescriptionInfo> prescriptions = (List<PrescriptionInfo>) request.getAttribute("prescriptions");
                    for (int i = 0; i < prescriptions.size(); i++) {%>
                        <tr>
                            <% if (!user.getRole().equals(Constants.PATIENT)) {%>
                            <td><%= prescriptions.get(i).getPatientID() %></td>
                            <td><%= prescriptions.get(i).getDIN() %></td>
                            <%}%>
                            <td><%= prescriptions.get(i).getName() %></td>
                            <td><%= prescriptions.get(i).getQuantity() %></td>
                            <td><%= prescriptions.get(i).getRefills() %></td>
                            <td><%= prescriptions.get(i).getDosage() %></td>
                            <td><%= prescriptions.get(i).issueToSimpleDateString() %></td>
                            <td><%= prescriptions.get(i).expiryToSimpleDateString() %></td>
                        </tr>
                    <%}%>
            </table>
        </div>
    </body>
</html>
