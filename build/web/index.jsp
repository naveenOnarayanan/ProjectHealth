<%-- 
    Document   : login
    Created on : Mar 13, 2014, 9:18:50 PM
    Author     : ZGaming
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <title>Project Health</title>
        <% String error = (String) request.getAttribute("error"); %>
    </head>
    <body>
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
        <div class="jumbotron login-container">
            <form role="form" name="userCredentials" action="LoginServlet?mode=login" method="post">
                <div class="form-group">
                    <input class="login-form-item form-control" id="username" name="username" placeholder="Username"/>
                </div>
                <div class="form-group">
                     <input class="login-form-item form-control" type="password" name="password" id="password" placeholder="Password"/>
                </div>
                <div class="form-group">
                    <input type="submit" class="form-login btn btn-success" value="Login"/>
                </div>
            </form>
        </div>
    </body>
</html>
