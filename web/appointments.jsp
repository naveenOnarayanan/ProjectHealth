<%-- 
    Document   : appointments
    Created on : Mar 18, 2014, 1:00:02 PM
    Author     : ZGaming
--%>

<%@page import="ece358.models.Patients"%>
<%@page import="ece358.utils.Constants"%>
<%@page import="ece358.models.Staff"%>
<%@page import="ece358.models.Visitation"%>
<%@page import="java.util.List"%>
<%@page import="ece358.models.Users"%>
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
        <script type="text/javascript" src="js/appointment.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/fonts/glyphicons-halflings-regular.svg"/>
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/2.1.30/css/bootstrap-datetimepicker.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <% String error = (String) request.getAttribute("error"); %>
        <title>Appointments</title>
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
        <script>
            $(function() {
               getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
               "<%=request.getSession().getAttribute("firstname")%>",
               "<%=request.getSession().getAttribute("lastname")%>");
            })
        </script>
       <div id="navbar-container"></div>
       <% List<Patients> patients = (List<Patients>) request.getAttribute("patients");
          List<Staff> doctors = (List<Staff>) request.getAttribute("doctors"); %>
       <div class="content">
        <div class="modal fase" id="appointment-edit" tabindex="-1" role="dialog" aria-labelledby="Appointment" aria-hidden="true">
           <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title" id="myModalLabel">Appointment</h4>
               </div>
               <div class="modal-body appointment-modal-container">
                   <form action="AppointmentServlet?action=update" name="appointmentUpdate" method="post">
                       <div class="form-group">
                           <input id='appointment-modal-visitID' type="text" class="form-control hidden" name="visitID"/>
                       </div>
                       <div class="form-group">
                           <label for="datetime">Date</label>
                           <div class='input-group date' id='appointment-modal-date'>
                               <input type='text' class="form-control" name="datetime" />
                               <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                               </span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label for="patientID">Patient</label>
                           <select class="form-control" name="patientID" id="appointment-modal-patientID">
                               <option id="empty-value" value="null"></option>
                               <% for (int i = 0; i < patients.size(); i++) { %>
                               <option id="<%= patients.get(i).getUserId() %>" value="<%= patients.get(i).getUserId()%>"><%= patients.get(i).getFirstName() + " " + patients.get(i).getLastName() %></option>
                               <%}%>
                           </select>
                       </div>
                       <div class="form-group">
                           <label for="doctorID">Doctor</label>
                           <select class="form-control" name="doctorID" id="appointment-modal-doctorID">
                               <option id="empty-value" value="null"></option>
                               <% for (int i = 0; i < doctors.size(); i++) { %>
                               <option id="<%= doctors.get(i).getUserId() %>" value="<%= doctors.get(i).getUserId()%>"><%= doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName() %></option>
                               <%}%>
                           </select>
                       </div>
                       <div class="form-group">
                           <label for="symptoms">Symptoms</label>
                           <textarea id="appointment-modal-symptoms" class="form-control" name="symptoms" rows="3" placeholder="Symptoms"></textarea>
                       </div>
                       <div class="form-group">
                           <label for="diagnosis">Diagnosis</label>
                           <textarea id="appointment-modal-diagnosis" class="form-control" name="diagnosis" rows="3" placeholder="Diagnosis"></textarea>
                       </div>
                       <div class="form-group">
                           <label for="type">Type</label>
                           <input class="form-control" id="appointment-modal-type" type="text" placeholder="Type" name="type"/>
                       </div>
                       <div class="form-group">
                           <label for="length">Length</label>
                           <div class='input-group date' id='appointment-modal-length'>
                               <input type='text' class="form-control" name="length"/>
                               <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                               </span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label for="comments">Comments</label>
                           <textarea id="appointment-modal-comments" class="form-control" name="comments" rows="5" placeholder="Comments"></textarea>
                       </div>
                       <div class="form-group">
                           <input type="submit" class="pull-right form-login btn btn-success" value="Save"/>
                       </div>
                  </form>
               </div>
             </div>
           </div>
         </div> 
         <%  Users user = (Users) request.getSession().getAttribute("user"); %>
         <div id="content">
             <% if (user.getRole().equals(Constants.STAFF)) {%>
             <button class="btn btn-warning pull-right add-appointment" onclick="updateAppointmentModal('-1')"><i class="fa fa-calendar fa-4"></i></button>
             <%}%>
             <table id="appointments" class="table table-hover">
                 
                 <thead>
                     <tr>
                         <th>Date</th>
                         <%if (user.getRole().equals(Constants.STAFF)) { %>
                             <th>Patient</th>
                         <%}%>
                         <th>Doctor</th>
                         <th>Symptoms</th>
                         <th>Diagnosis</th>
                         <th>Reason</th>
                         <th>Length</th>
                         <th>Comments</th>
                     </tr>
                 </thead>
                 <%
                    List<Visitation> appointments = (List<Visitation>) request.getAttribute("appointments");
                    for (int i = 0; i < appointments.size(); i++) {%>
                    <tr id="appointment-<%=i%>" data-id="<%= appointments.get(i).getVisitId()%>" <% if (user.getRole().equals(Constants.STAFF)) { %> onclick="updateAppointmentModal('<%= i %>')"> <% } %>
                             <td class="appointment-date" id="date-<%= i%>"><%= appointments.get(i).getDateTime() %></td>
                             <% for (int j = 0; j < patients.size(); j++) {
                                 if (patients.get(j).getUserId().equals(appointments.get(i).getPatientId())) {%>
                            <td class="appointment-patient" data-id="<%= patients.get(j).getUserId()%>" >
                                <%= patients.get(j).getFirstName() + " " + patients.get(j).getLastName() %>
                            </td>
                               <%break;}}%>
                             <% for (int j = 0; j < doctors.size(); j++) {
                                 if (doctors.get(j).getUserId().equals(appointments.get(i).getDoctorId())) {
                                     %>
                                     <td class="appointment-doctor" data-id="<%= doctors.get(j).getUserId()%>">
                                         <%= doctors.get(j).getFirstName() + " " + doctors.get(j).getLastName() %>
                                     </td>
                                   <%break;}
                             }%>
                             <td class="appointment-symptoms"><div class="overflow"><%= appointments.get(i).getSymptoms() %></div></td>
                             <td class="appointment-diagnosis"><div class="overflow"><%= appointments.get(i).getDiagnosis() %></div></td>
                             <td class="appointment-type"><%= appointments.get(i).getType() %></td>
                             <td class="appointment-length"><%= appointments.get(i).getLength() %></td>

                             <% if (user.getRole().equals(Constants.STAFF)) { %>
                                 <td class="appointment-comments"><div class="overflow"><%= appointments.get(i).getComments() %></div></td>
                             <%}%>

                         </tr>
                    <%}%>
             </table>
         </div>   
       </div>
    </body>
</html>
