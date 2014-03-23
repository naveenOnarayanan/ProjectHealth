<%-- 
    Document   : error
    Created on : Mar 23, 2014, 11:10:03 AM
    Author     : Josh
--%>
<%@page import="ece358.models.Users"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
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
        <title>Error</title>
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
            Exception e = (Exception)request.getAttribute("exception");
            String errorMessage = e.getMessage();
            if (errorMessage == null) { errorMessage = ""; }
            StringWriter errorWriter = new StringWriter();
            e.printStackTrace(new PrintWriter(errorWriter));
            String stackTrace = errorWriter.toString();
        %>

        <%
        if (errorMessage.startsWith("Access denied")) {    
        %>
        <h2> Access to DB denied.  Double-check the user ID and password in the DBAO class.</h2>
        <%
        } else if (errorMessage.startsWith("Communications link failure")) {    
        %>
        <h2> Unable to connect to database.  Check the url in the DBAO class, then check your network/VPN connection.</h2>
        <%
        } else if (errorMessage.startsWith("Table") && errorMessage.indexOf("doesn't exist") != -1) {
        %>
        <h2> Trying to access a table that doesn't exist.  Double-check your SQL. </h2>
        <%
        } else {
        %>
        <h2>Exception message:</h2>
        <%= e.getClass().getName() %>: <%= errorMessage %>
        <%
        }
        %>
        <h4>Exception stack trace:</h4>
        <pre>
            <%= stackTrace %>
        </pre>

    </body>
</html>
