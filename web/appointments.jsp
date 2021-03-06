<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ece358.models.Operations"%>
<%@page import="java.util.Date"%>
<%@page import="ece358.models.Drugs"%>
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
        <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.0.0rc/js/bootstrap-switch.min.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/js/jquery.tablesorter.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/js/jquery.tablesorter.widgets.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/parsley.js/1.2.3/parsley.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="js/appointment.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/fonts/glyphicons-halflings-regular.svg"/>
        <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
        <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.0.0rc/css/bootstrap3/bootstrap-switch.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2-bootstrap.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.13.3/css/theme.ice.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <% String error = (String) request.getAttribute("error");
           Users user = (Users) request.getSession().getAttribute("user");%>
        <title>Appointments</title>
    </head>
    <body>
        <%
           if (error != null && !error.equals("")) { 
        %>
           <div id="error-notifier" class="alert alert-dismissable alert-danger">
               <button type="button" class="close" data-dismiss="alert">x</button>
               <%= error %>
           </div>
        <%
           } 
        %>
        <script>
            $(function() {
               $(".info-container-hidden").attr("data-staff", JSON.stringify(<%= new Gson().toJson(request.getAttribute("staff")) %>));
               getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
               "<%=request.getSession().getAttribute("firstname")%>",
               "<%=request.getSession().getAttribute("lastname")%>");
            })
        </script>
        <div class="info-container-hidden hidden"></div>
       <div id="navbar-container"></div>
       <div class="search-bar">
           <div class="jumbotron input-container">

                <input id="temp" class="search" type="search" data-column="0" placeholder="Appointment #">
                <input type="search" class="search" data-column="1" placeholder="Date"/>
                <input type="search" class="search" data-column="2" placeholder="Patient Name"/>
                <input type="search" class="search" data-column="3" placeholder="Doctor Name"/>
                <input type="search" class="search" data-column="4" placeholder="Symptoms"/>
                <input type="search" class="search" data-column="5" placeholder="Diagnosis"/>
                <input type="search" class="search" data-column="8" placeholder="Reasons"/>
                <input type="search" class="search" data-column="9" placeholder="Length"/>
                <input type="search" class="search" data-column="10" placeholder="Comments"/><br/>
                <center><button type="reset" class="reset btn btn-primary btn-xs">Reset</button></center>
           </div>
       </div>
       <button id="open-search-bar" class="btn btn-primary pull-right" ><i class="fa fa-search"></i></button>
       
       
       <% if (error == null) { %>
       <% List<Patients> patients = (List<Patients>) request.getAttribute("patients");
          List<Staff> doctors = (List<Staff>) request.getAttribute("doctors"); 
          List<Drugs> drugs = (List<Drugs>) request.getAttribute("drugs");
          List<Operations> operations = (List<Operations>) request.getAttribute("operations"); %>
          <div class="content">
            <div class="modal fade" id="appointment-edit" role="dialog" aria-labelledby="Appointment" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                       <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Appointment</h4>
                        </div>
                        <form id="appointment-modal-form" onsubmit="return validate();" action="AppointmentServlet?" name="appointmentUpdate" method="post" data-parsley-validate>
                            <div class="modal-body appointment-modal-container">
                                <ul class="nav nav-pills">
                                    <li class="tab-button active" id="info-tab"><a href="#info" data-toggle="tab">Schedule</a></li>
                                    <% if (user.getRole().equals(Constants.DOCTOR)) {%>
                                    <li class="tab-button" id="prescriptions-tab"><a href="#prescriptions" data-toggle="tab">Prescriptions</a></li>
                                    <li class="tab-button" id="operations-tab"><a href="#operations" data-toggle="tab">Operations</a></li>
                                    <%}%>
                                </ul>
                                <hr/>
                                <div id="form-valiation-error" class="alert alert-danger hidden">
                                </div>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="info">
                                        <div class="form-group">
                                            <input id='appointment-modal-visitID' type="text" class="form-control hidden" name="visitID"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="datetime">Date</label>
                                            <div class='input-group date' id='appointment-modal-date'>
                                                <input type='text' class="form-control" name="datetime" required />
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="patientID">Patient</label>
                                            <select class="form-control" name="patientID" id="appointment-modal-patientID" required >
                                                <% for (int i = 0; i < patients.size(); i++) { %>
                                                <option id="<%= patients.get(i).getUserId() %>" value="<%= patients.get(i).getUserId()%>"><%= patients.get(i).getFirstName() + " " + patients.get(i).getLastName() %></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="doctorID">Doctor</label>
                                            <select class="form-control" name="doctorID" id="appointment-modal-doctorID" required >
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
                                            <textarea id="appointment-modal-diagnosis" class="form-control" name="diagnosis" rows="3" placeholder="Diagnosis" <% if (user.getRole().equals(Constants.STAFF)) {%> readonly="true" <%}%>></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="type">Type</label>
                                            <input class="form-control" id="appointment-modal-type" type="text" placeholder="Type" name="type" <% if (user.getRole().equals(Constants.DOCTOR)) {%> readonly="true" <%}%>/>
                                        </div>
                                        <div class="form-group">
                                            <label for="length">Length</label>
                                            <div class='input-group date' id='appointment-modal-length'>
                                                <input type='text' class="form-control" name="length" required />
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="comments">Comments</label>
                                            <textarea id="appointment-modal-comments" class="form-control" name="comments" rows="5" placeholder="Comments" <% if (user.getRole().equals(Constants.STAFF)) {%> readonly="true" <%}%>></textarea>
                                        </div>
                                        
                                        <div class="form-group <% if (user.getRole().equals(Constants.DOCTOR)) {%> hidden <% } %>" >
                                            <label for="apptComplete">Appointment Complete</label><br/>
                                            <input type="checkbox" id="appointment-modal-apptComplete" name="apptComplete" />
                                        </div>
                                        
                                        <div class="form-group <% if (user.getRole().equals(Constants.DOCTOR)) {%> hidden <% } %>" >
                                            <label for="apptCancelled">Appointment Cancelled</label><br/>
                                            <input type="checkbox" id="appointment-modal-apptCancelled" name="apptCancelled" />
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="prescriptions">
                                        <input class="hidden" type="text" id="appointment-modal-prescriptions" name="prescriptions-list"/>
                                        <table id="appointment-modal-prescription-table" class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>DIN</td>
                                                    <td>Trade Name</td>
                                                    <td>Quantity</td>
                                                    <td>Refills</td>
                                                    <td>Dosage</td>
                                                    <td>Expiry</td>
                                                    <td></td>
                                                </tr>
                                            </thead>
                                        </table>
                                        <hr/>
                                        <div class="border-dashed">
                                            <div class="form-group">
                                                <label for="drugs">Drug</label>
                                                <select id="appointment-modal-drugs" class="form-control" name="drugs">
                                                    <% for (int i = 0; i < drugs.size(); i++) {%>
                                                    <option value="<%= drugs.get(i).getDin() %>"><%= drugs.get(i).getTradeName() %></option>
                                                    <%}%>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="quantity">Quantity</label>
                                                <input type="number" id="appointment-modal-quantity" class="form-control" name="quantity"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="refills">Refills</label>
                                                <input type="number" id="appointment-modal-refills" class="form-control" name="refills"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="dosage">Dosage</label>
                                                <input type="text" id="appointment-modal-dosage" class="form-control" name="dosage"/>
                                            </div>
                                            <div class="form-group">
                                                <label for="expiry">Date</label>
                                                <div class='input-group date' id='appointment-modal-expiry'>
                                                    <input type='text' class="form-control" name="expiry" />
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <button id="add-drug" class="btn btn-success btn-sm pull-right">Add</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="operations">
                                        <input class="hidden" type="text" id="appointment-modal-operations" name="operations-list"/>
                                        <table id="appointment-modal-operations-table" class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <td>Operation Time</td>
                                                    <td>Operation Name</td>
                                                    <td>Doctor</td>
                                                    <td></td>
                                                </tr>
                                            </thead>
                                        </table>
                                        <hr/>
                                        <div class="border-dashed">
                                            <div class="form-group">
                                                <label for="operationTime">Date</label>
                                                <div class='input-group date' id='appointment-modal-operationTime'>
                                                    <input type='text' class="form-control" name="operationTime" />
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="operationName">Operation Name</label>
                                                <select id="appointment-modal-operationName" class="form-control" name="drugs"><%
                                                       if (operations != null) {
                                                            for (int i = 0; i < operations.size(); i++) {%>
                                                            <option data-length="<%= operations.get(i).getEstTime()%>" data-value="<%= operations.get(i).getReqJobTitle() %>" id="<%= operations.get(i).getName().replaceAll(" ", "") %>" value="<%= operations.get(i).getName()%>"><%= operations.get(i).getName() %></option>
                                                    <%}}%>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="operationDoctor">Surgeon</label>
                                                <select id="appointment-modal-operationDoctor" class="form-control" name="operationDoctor">
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <button id="add-operations" class="btn btn-success btn-sm pull-right">Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="form-group">
                                    <input type="submit" class="pull-right form-login btn btn-primary" value="Save"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div> 
            <div id="dynamic-table">
                <h1>Appointments</h1>
                <% if (user.getRole().equals(Constants.STAFF)) {%>
                <button class="btn btn-warning pull-right add-appointment" onclick="updateAppointmentModal('-1', '<%= user.getRole()%>')"><i class="fa fa-calendar fa-4"></i></button>
                 <%}%>
                <ul class="nav nav-tabs tab-space">
                    <li class="tab-button active" id="upcoming-appointments-tab"><a href="#upcoming" data-toggle="tab">Upcoming Appointments</a></li>
                    <li class="tab-button" id="past-appointments-tab"><a href="#past" data-toggle="tab">Past Appointments</a></li>
                </ul>
                <br/>
                <div class="tab-content">
                    <div class="tab-pane active" id="upcoming">
                        <table id="upcoming-appointments" class="table table-hover table-bordered tablesorter">
                            <thead>
                                <tr>
                                    <th>Appointment #</th>
                                    <th data-sorter="dateFormat" data-date-format="MM/dd/yyyy hh:mm aa">Date</th>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Symptoms</th>
                                    <th>Diagnosis</th>
                                    <th>Prescriptions</th>
                                    <th>Scheduled Operations</th>
                                    <th>Reason</th>
                                    <th>Length</th>
                                    <%if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %>
                                    <th style="width: 12%">Comments</th>
                                    <%}%>
                                </tr>
                            </thead>
                            <%
                                List<Visitation> appointments = (List<Visitation>) request.getAttribute("upcomingAppointments");
                                for (int i = 0; i < appointments.size(); i++) {%>
                                <tr id="upcoming-appointment-<%=i%>" data-complete="<%= appointments.get(i).getApptComplete() %>" data-id="<%= appointments.get(i).getVisitId()%>">
                                    <td class="appointment-visit-id" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>><%= appointments.get(i).getVisitId() %></td>
                                    <td class="appointment-date" id="upcoming-date-<%= i%>" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>>
                                        <%= new SimpleDateFormat("MM/dd/yyyy hh:mm aa").format(appointments.get(i).getDateTime()) %>
                                    </td>
                                    <% for (int j = 0; j < patients.size(); j++) {
                                        if (patients.get(j).getUserId().equals(appointments.get(i).getPatientId())) {%>
                                    <td class="appointment-patient" data-id="<%= patients.get(j).getUserId()%>">
                                        <a data-toggle="modal" href="PersonalInfo?mode=1&UserID=<%= patients.get(j).getUserId()%>&MinimalMode=true" data-target="#remoteContent"><%= patients.get(j).getFirstName() + " " + patients.get(j).getLastName() %></a>
                                    </td>
                                       <%break;}}%>
                                     <% for (int j = 0; j < doctors.size(); j++) {
                                        if (doctors.get(j).getUserId().equals(appointments.get(i).getDoctorId())) {
                                            %>
                                            <td class="appointment-doctor" data-id="<%= doctors.get(j).getUserId()%>" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>>
                                                <%= doctors.get(j).getFirstName() + " " + doctors.get(j).getLastName() %>
                                            </td>
                                            <%break;}
                                    }%>
                                    <td class="appointment-symptoms" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>><div class="overflow"><%= appointments.get(i).getSymptoms() %></div></td>
                                    <td class="appointment-diagnosis" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>><div class="overflow"><%= appointments.get(i).getDiagnosis() %></div></td>
                                    <td class="appointment-prescriptions">
                                    <% if (appointments.get(i).getPrescriptions() != null && appointments.get(i).getPrescriptions().size() > 0) {%><center>
                                        <a class="btn btn-primary btn-xs" data-toggle="modal" href="PrescriptionsServlet?VisitID=<%= appointments.get(i).getVisitId() %>" data-target="#remoteContent">View</a>    
                                        </center><%}%>
                                    </td>
                                    <td class="appointment-operations"><center>
                                        <% if (appointments.get(i).getOperations()!= null && appointments.get(i).getOperations().size() > 0) {
                                               for (int k = 0; user.getRole().equals(Constants.DOCTOR) && k < appointments.get(i).getOperations().size(); k++) {%>
                                               <p class="hidden appointment-operations-data">
                                                   <%= appointments.get(i).getOperations().get(k).getOperationDateTime().toString() +
                                                           "|" + appointments.get(i).getOperations().get(k).getOperationName() +
                                                           "|" + appointments.get(i).getOperations().get(k).getDoctorId() +
                                                           "|" + operations.get(operations.indexOf(new Operations(appointments.get(i).getOperations().get(k).getOperationName()))).getEstTime().toString()
                                                   %>
                                               </p>
                                        <%}%>
                                        <a class="btn btn-primary btn-xs" data-toggle="modal" href="ScheduledOperations?VisitID=<%= appointments.get(i).getVisitId() %>" data-target="#remoteContent">View</a>
                                    </center>
                                        <%}%>
                                    </td>
                                    <td class="appointment-type" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>><%= appointments.get(i).getType() %></td>
                                    <td class="appointment-length" <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %> onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" <% } %>><%= appointments.get(i).getLength() %></td>

                                    <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %>
                                        <td class="appointment-comments" onclick="updateAppointmentModal('<%= i %>', '<%= user.getRole()%>', 'upcoming')" ><div class="overflow"><%= appointments.get(i).getComments() %></div></td>
                                    <%}%>

                                </tr>
                            <%}%>
                            <tfoot id="upcoming-pager" class="pager">
                                <tr>
                                    <th colspan="11" class="ts-pager form-horizontal">
                                        <button type="button" class="btn-xsm first"><i class="icon-step-backward glyphicon glyphicon-step-backward"></i>
                                        </button>
                                        <button type="button" class="btn-xsm prev"><i class="icon-arrow-left glyphicon glyphicon-backward"></i>
                                        </button>	<span class="pagedisplay"></span> 
                                        <!-- this can be any element, including an input -->
                                        <button type="button" class="btn-xsm next"><i class="icon-arrow-right glyphicon glyphicon-forward"></i>
                                        </button>
                                        <button type="button" class="btn-xsm last"><i class="icon-step-forward glyphicon glyphicon-step-forward"></i>
                                        </button>
                                        <select class="pagesize input-mini" title="Select page size">
                                            <option selected="selected" value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="30">30</option>
                                            <option value="40">40</option>
                                        </select>
                                        <select class="pagenum input-mini" title="Select page number"></select>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="tab-pane" id="past">
                        <table id="past-appointments" class="tablesorter table table-hover table-bordered ">
                            <thead>
                                <tr><b>
                                    <th>Appointment #</th>
                                    <th data-sorter="dateFormat" data-date-format="MM/dd/yyyy hh:mm aa">Date</th>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Symptoms</th>
                                    <th>Diagnosis</th>
                                    <th>Prescriptions</th>
                                    <th>Scheduled Operations</th>
                                    <th>Reason</th>
                                    <th>Length</th>
                                    <%if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %>
                                    <th>Comments</th>
                                    <%}%></b>
                                </tr>
                            </thead>
                            <%
                                appointments = (List<Visitation>) request.getAttribute("pastAppointments");
                                for (int i = 0; i < appointments.size(); i++) {%>
                                <tr id="past-appointment-<%=i%>" data-complete="<%= appointments.get(i).getApptComplete() %>" data-id="<%= appointments.get(i).getVisitId()%>">
                                    <td class="appointment-visit-id" ><%= appointments.get(i).getVisitId() %></td>
                                    <td class="appointment-date" id="past-date-<%= i%>">
                                        <%= new SimpleDateFormat("MM/dd/yyyy hh:mm aa").format(appointments.get(i).getDateTime()) %>
                                    </td>
                                    <% for (int j = 0; j < patients.size(); j++) {
                                        if (patients.get(j).getUserId().equals(appointments.get(i).getPatientId())) {%>
                                    <td class="appointment-patient" data-id="<%= patients.get(j).getUserId()%>">
                                        <a data-toggle="modal" href="PersonalInfo?mode=1&UserID=<%= patients.get(j).getUserId()%>&MinimalMode=true" data-target="#remoteContent"><%= patients.get(j).getFirstName() + " " + patients.get(j).getLastName() %></a>
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
                                    <td class="appointment-prescriptions"><center>
                                        <% if (appointments.get(i).getPrescriptions() != null && appointments.get(i).getPrescriptions().size() > 0) {%>
                                        <a class="btn btn-primary btn-xs" data-toggle="modal" href="PrescriptionsServlet?VisitID=<%= appointments.get(i).getVisitId() %>" data-target="#remoteContent">View</a>
                                        <%}%></center>
                                    </td>
                                    <td class="appointment-operations"><center>
                                        <% if (appointments.get(i).getOperations()!= null && appointments.get(i).getOperations().size() > 0) {
                                               for (int k = 0; user.getRole().equals(Constants.DOCTOR) && k < appointments.get(i).getOperations().size(); k++) {%>
                                               <p class="hidden appointment-operations-data">
                                                   <%= appointments.get(i).getOperations().get(k).getOperationDateTime().toString() +
                                                           "|" + appointments.get(i).getOperations().get(k).getOperationName() +
                                                           "|" + appointments.get(i).getOperations().get(k).getDoctorId() +
                                                           "|" + operations.get(operations.indexOf(new Operations(appointments.get(i).getOperations().get(k).getOperationName()))).getEstTime().toString()
                                                   %>
                                               </p>
                                        <%}%>
                                        <a class="btn btn-primary btn-xs" data-toggle="modal" href="ScheduledOperations?VisitID=<%= appointments.get(i).getVisitId() %>" data-target="#remoteContent">View</a>    
                                        <%}%></center>
                                    </td>
                                    <td class="appointment-type" ><%= appointments.get(i).getType() %></td>
                                    <td class="appointment-length" ><%= appointments.get(i).getLength() %></td>

                                    <% if (user.getRole().equals(Constants.STAFF) || user.getRole().equals(Constants.DOCTOR)) { %>
                                        <td class="appointment-comments"><div class="overflow"><%= appointments.get(i).getComments() %></div></td>
                                    <%}%>

                                </tr>
                            <%}%>
                            <tfoot id="past-pager" class="pager">
                                <tr>
                                    <th colspan="11" class="ts-pager form-horizontal">
                                        <button type="button" class="btn-xsm first"><i class="icon-step-backward glyphicon glyphicon-step-backward"></i>
                                        </button>
                                        <button type="button" class="btn-xsm prev"><i class="icon-arrow-left glyphicon glyphicon-backward"></i>
                                        </button>	<span class="pagedisplay"></span> 
                                        <!-- this can be any element, including an input -->
                                        <button type="button" class="btn-xsm next"><i class="icon-arrow-right glyphicon glyphicon-forward"></i>
                                        </button>
                                        <button type="button" class="btn-xsm last"><i class="icon-step-forward glyphicon glyphicon-step-forward"></i>
                                        </button>
                                        <select class="pagesize input-mini" title="Select page size">
                                            <option selected="selected" value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="30">30</option>
                                            <option value="40">40</option>
                                        </select>
                                        <select class="pagenum input-mini" title="Select page number"></select>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
       </div>
       <% } %>
        </div>
        <div class="modal fade" id="remoteContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                         <h4 class="modal-title">Modal title</h4>

                    </div>
                    <div class="modal-body"><div class="te"></div></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
