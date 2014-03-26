<%-- 
    Document   : DoctorLookup
    Created on : 20-Mar-2014, 1:18:59 PM
    Author     : GordonMBP
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.String"%>
<%@page import="ece358.models.Drugs"%>
<%@page import="ece358.models.Operations"%>
<%@page import="ece358.models.Prescriptions"%>
<%@page import="ece358.models.Scheduledoperations"%>
<%@page import="ece358.models.Staff"%>
<%@page import="ece358.models.Users"%>
<%@page import="ece358.models.Visitation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.5.1/moment.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/2.1.30/js/bootstrap-datetimepicker.min.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2-bootstrap.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/2.1.30/css/bootstrap-datetimepicker.min.css"/>
        
        <% String error = (String) request.getAttribute("error"); %>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
        
        <% String selectedDoctorID = (String)request.getAttribute("selectedDoctorID"); %>
        <% List<Staff> doctors = (List<Staff>)request.getAttribute("doctors"); %>
        <% String startDateTime = (String)request.getAttribute("startDateTime"); %>
        <% String endDateTime = (String)request.getAttribute("endDateTime"); %>
        <% SimpleDateFormat dateTimeFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm aa"); %>
        
        <% List<Visitation> appointments = (List<Visitation>)request.getAttribute("appointments"); %>
        <% Object[] patientIDs = (Object[])request.getAttribute("patientIDs"); %>
        <% Object[] patientVisits = (Object[])request.getAttribute("patientVisits"); %>
        <% List<List<Object[]>> visitPrescriptions = (List<List<Object[]>>)request.getAttribute("visitPrescriptions"); %>
        <% List<List<Scheduledoperations>> visitOperations = (List<List<Scheduledoperations>>)request.getAttribute("visitOperations"); %>
        
        <script>
            $(document).ready(function() {
                $("#doctorID").select2( {
                    placeholder:"doctor name"
                });
                $("#doctorID").select2("val", "<%= selectedDoctorID %>");
                $('#startDate').datetimepicker({
                    language: 'en',
                    useCurrent: true
                });
                $('#endDate').datetimepicker({
                    language: 'en',
                    useCurrent: true
                });
                $("#startDate").data("DateTimePicker").setDate("<%= startDateTime %>");
                $("#endDate").data("DateTimePicker").setDate("<%= endDateTime %>");
            });
        </script>
           
        <title>Doctor Lookup</title>
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
        
        <% if (error != null && !error.equals("")) { %>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <%= error %>
            </div>
        <% } %>
        
        <div class="doctorLookup">
            <form method="post" action="DoctorLookupServlet?mode=2" name="DoctorSelectForm">
                <table style="width: 100%">
                    <tr>
                        <th>
                            <h1 class="table-header" style="padding-left: 22%">Doctor Information Lookup</h1>
                        </th>                   
                    </tr>
                    <tr>
                        <th style="width: 50%">
                            <h4 style="margin-left: 22%">Select a doctor:</h4>
                            <div>
                                <select class="doctorSelect" name="doctorID" id="doctorID" style="margin-left: 22%; width: 70%">
                                    <% for (int i = 0; i < doctors.size(); i++) { %>
                                        <option value="<%= doctors.get(i).getUserId()%>"><%= doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName() %></option>
                                    <%}%>
                                </select>
                            </div>
                        </th>
                        <th>
                            <h4>Select a start date:</h4>
                            <div class='input-group date' id='startDate' style="padding-right: 22%">
                                    <input type='text' class="form-control" name="startDateTime"/>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                    </span>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th style="width: 50%"></th>
                        <th>
                            <br>
                            <h4>Select a end date:</h4>
                            <div class='input-group date' id='endDate' style="padding-right: 22%">
                                <input type='text' class="form-control" name="endDateTime" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                </span>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th style="width: 50%"></th>
                        <th>
                            <br>
                            <input type="submit" class="btn btn-success" value="Search" style="margin-left: 67%"/>
                        </th>
                    </tr>
                </table>
            </form>
        </div>
        <% if (appointments != null && !queryServletError) { %>
        <table style="width: 100%">
            <tr>
            <div>
                <% String doctorName = ""; %>
                <% for (int i = 0; i < doctors.size(); i++) {
                    if (doctors.get(i).getUserId().equals(selectedDoctorID)) {
                        doctorName = doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName();
                        break;
                    }
                } %>
                <th style="width: 50%"><h4 style="padding-left: 22%">Doctor: <%= doctorName %></h4></th>
                <th><h4>Dates: <%= startDateTime %> - <%= endDateTime %></h4></th>
            </tr>
            <tr>
                <th style="width: 50%"><h4 style="padding-left: 22%">Patients Seen: <%= appointments.size() %></h4></th>
            </tr>
            </div>
        </table>
        <% if (patientIDs.length > 0) { %>                
            <table style="width: 20%; margin-left: 11%">
                <tr>
                    <th style="width: 50%"><h5>Patient ID</h5></th>
                    <th style="width: 50%"><h5>Times Seen</h5></th>
                </tr>
                <% for (int i = 0; i < patientIDs.length; i++) { %>
                    <tr>
                        <td style="width: 50%"><h5><%= patientIDs[i] %></h5></td>
                        <td style="width: 50%"><h5><%= patientVisits[i] %></h5></td>
                    </tr>
                <% } %>
            </table>
        <% } %>
            <div>
                <br>
                <h3 style="padding-left: 11%">Records</h3>
                <table id="appointments" class="table table-hover table-bordered" style="margin-left: 11%; width: 78%">
                    <thead>
                        <tr>
                            <th style="width: 10%">Date</th>
                            <th style="width: 8%">Patient ID</th>
                            <th style="width: 8%">Length</th>
                            <th style="width: 10%">Diagnosis</th>
                            <th style="width: 18%">Prescription</th>
                            <th style="width: 20%">Operation</th>
                        </tr>
                    </thead>
                    <% for (int i = 0; i < appointments.size(); i++) { %>
                        <tr>
                            <td class="appointment-date"><%= dateTimeFormat.format(appointments.get(i).getDateTime()) %></td>
                            <td class="appointment-patient"><%= appointments.get(i).getPatientId() %></td>
                            <td class="appointment-length"><%= appointments.get(i).getLength() %></td>
                            <td class="appointment-diagnosis"><%= appointments.get(i).getDiagnosis() %></td>
                            <td class="appointment-prescriptions">
                                <% if (visitPrescriptions != null && visitPrescriptions.get(i).size() > 0) { %>
                                    <% List<Object[]> prescriptions = visitPrescriptions.get(i); %>
                                    <% for (int j = 0; j < prescriptions.size(); j++) { %>
                                        <% Object[] prescription = prescriptions.get(j); %>
                                        <div class="list-group">
                                        <a class="list-group-item">
                                            <h6 class="list-group-item-heading"><%= prescription[0] %></h6>
                                        </a>
                                        <table class="table table-hover table-bordered table-condensed" id="past-prescription-info-<%= j %>">
                                            <tr>
                                                <td><b>Quantity</b></td><td><%= prescription[1] %></td>
                                            </tr>
                                            <tr>
                                                <td><b>Refills</b></td><td><%= prescription[2] %></td>
                                            </tr>
                                            <tr>
                                                <td><b>Dosage</b></td><td><%= prescription[3] %></td>
                                            </tr>
                                            <tr>
                                                <td><b>Expiry</b></td><td><%= dateTimeFormat.format(prescription[4]) %></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <% } %>
                                <% } %>
                            </td>
                            <td class="appointment-operations">
                                <% if (visitOperations != null && visitOperations.get(i).size() > 0) { %>
                                    <% List<Scheduledoperations> operations = visitOperations.get(i); %>
                                    <% for (int j = 0; j < operations.size(); j++) { %>
                                        <% Scheduledoperations operation = operations.get(j); %>
                                        <div class="list-group">
                                        <a class="list-group-item">
                                            <h6 class="list-group-item-heading"><%= operation.getOperationName() %></h6>
                                        </a>
                                        <table class="table table-hover table-bordered table-condensed" id="past-prescription-info-<%= j %>">
                                            <tr>
                                                <td><b>Surgeon</b></td><td><%= operation.getDoctorId() %></td>
                                            </tr>
                                            <tr>
                                                <td><b>Date</b></td><td><%= dateTimeFormat.format(operation.getOperationDateTime()) %></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <% } %>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </table>
            </div>
        <% } %>
    </body>

</html>
