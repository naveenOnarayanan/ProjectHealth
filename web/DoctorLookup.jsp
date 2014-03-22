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
        
        <% String selectedDoctorID = (String)request.getAttribute("selectedDoctorID"); %>
        <% List<Staff> doctors = (List<Staff>)request.getAttribute("doctors"); %>
        <% String startDateTime = (String)request.getAttribute("startDateTime"); %>
        <% String endDateTime = (String)request.getAttribute("endDateTime"); %>
        
        <% List<Visitation> appointments = (List<Visitation>)request.getAttribute("appointments"); %>
        <% Object[] patientIDs = (Object[])request.getAttribute("patientIDs"); %>
        <% Object[] patientVisits = (Object[])request.getAttribute("patientVisits"); %>
        <% List<List<Prescriptions>> visitPrescriptions = (List<List<Prescriptions>>)request.getAttribute("visitPrescriptions"); %>
        <% List<List<Drugs>> visitDrugInformation = (List<List<Drugs>>)request.getAttribute("drugInformation"); %>
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
        <div class="doctorLookup">
            <h4>Doctors</h4>
            <form method="post" action="DoctorLookupServlet?mode=2" name="DoctorSelectForm">
                <div>
                    <select class="doctorSelect" name="doctorID" id="doctorID">
                        <% for (int i = 0; i < doctors.size(); i++) { %>
                            <option value="<%= doctors.get(i).getUserId()%>"><%= doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName() %></option>
                        <%}%>
                    </select>
                </div>
                <div>
                    <table>
                        <tr>
                            <td><h4>Start Date</h4></td>
                            <td><h4>End Date</h4></td>
                        </tr>
                        <tr>
                            <td>
                                <div class='input-group date' id='startDate'>
                                    <input type='text' class="form-control" name="startDateTime" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                    </span>
                                </div>
                            </td>
                            <td>
                                <div class='input-group date' id='endDate'>
                                    <input type='text' class="form-control" name="endDateTime" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                    </span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <br>
                <input type="submit" class="btn btn-success" value="Search"/>
            </form>
        </div>
        <% if (appointments != null) { %>
            <br>
            <div>
                <% String doctorName = ""; %>
                <% for (int i = 0; i < doctors.size(); i++) {
                    if (doctors.get(i).getUserId().equals(selectedDoctorID)) {
                        doctorName = doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName();
                        break;
                    }
                } %>
                <h4>Doctor: <%= doctorName %></h4>
                <% SimpleDateFormat webFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm"); %>
                <% SimpleDateFormat dateTimeFormat = new SimpleDateFormat("MM/dd/yyyy hh:mm aa"); %>
                <% String startDateTimeString = dateTimeFormat.format(webFormat.parse(startDateTime)); %>
                <% String endDateTimeString = dateTimeFormat.format(webFormat.parse(endDateTime)); %>
                <h4><%= startDateTimeString %> - <%= endDateTimeString %></h4>
                <h4>Patients Seen: <%= appointments.size() %></h4>
                <% if (patientIDs.length > 0) { %>
                    <table>
                        <col width="100px"/>
                        <col width="100px"/>
                        <thead>
                            <tr>
                                <th>Patient ID</th>
                                <th>Times Seen</th>
                            </tr>
                        </thead>
                        <% for (int i = 0; i < patientIDs.length; i++) { %>
                            <tr>
                                <td><%= patientIDs[i] %></td>
                                <td><%= patientVisits[i] %></td>
                            </tr>
                        <% } %>
                    </table>
                <% } %>
            </div>
            <div>
                <h4>Records</h4>
                <table id="appointments" class="table table-hover">
                    <col width="120px">
                    <col width="80px">
                    <col width="80px">
                    <col width="120px">
                    <col width="300px">
                    <col width="300px">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Patient ID</th>
                            <th>Length</th>
                            <th>Diagnosis</th>
                            <th>Prescription</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <% for (int i = 0; i < appointments.size(); i++) { %>
                        <tr>
                            <td class="appointment-date"><%= dateTimeFormat.format(appointments.get(i).getDateTime()) %></td>
                            <td class="appointment-patient"><%= appointments.get(i).getPatientId() %></td>
                            <td class="appointment-length"><%= appointments.get(i).getLength() %></td>
                            <td class="appointment-diagnosis"><%= appointments.get(i).getDiagnosis() %></td>
                            <td>
                                <% if (visitPrescriptions != null && visitPrescriptions.get(i).size() > 0) { %>
                                    <table>
                                        <col width="100"/>
                                        <col width="100"/>
                                        <col width="100"/>
                                        <col width="100"/>
                                        <col width="100"/>
                                        <thead>
                                            <th>Name</th>
                                            <th>DIN</th>
                                            <th>Quantity</th>
                                            <th>Refills</th>
                                            <th>Expiry</th>
                                        </thead>
                                        <% List<Prescriptions> prescriptions = visitPrescriptions.get(i); %>
                                        <% List<Drugs> drugInformation = visitDrugInformation.get(i); %>
                                        <% for (int j = 0; j < prescriptions.size(); j++) { %>
                                            <tr>
                                                <% if (drugInformation.size() > j) { %>
                                                    <% Drugs drug = drugInformation.get(j); %>
                                                    <% if (drug != null) { %>
                                                        <td><%= drug.getTradeName() %></td>
                                                    <% } %>
                                                <% } %>
                                                <% Prescriptions prescription = prescriptions.get(j); %>
                                                <td><%= prescription.getId().getDin() %></td>
                                                <td><%= prescription.getQuantity() %></td>
                                                <td><%= prescription.getRefills() %></td>
                                                <td><%= dateTimeFormat.format(prescription.getExpiry()) %></td>
                                            </tr>
                                        <% } %>
                                    </table>
                                <% } %>
                            </td>
                            <td>
                                <% if (visitOperations != null && visitOperations.get(i).size() > 0) { %>
                                    <table>
                                        <col width="150"/>
                                        <col width="150"/>
                                        <col width="100"/>
                                        <thead>
                                            <th>Operation Name</th>
                                            <th>Date</th>
                                            <th>Surgeon</th>
                                        </thead>
                                        <% List<Scheduledoperations> operations = visitOperations.get(i); %>
                                        <% for (int j = 0; j < operations.size(); j++) { %>
                                            <% Scheduledoperations operation = operations.get(j); %>
                                            <td><%= operation.getOperationName() %></td>
                                            <td><%= dateTimeFormat.format(operation.getId().getOperationDateTime()) %></td>
                                            <td><%= operation.getDoctorId() %></td>
                                        <% } %>
                                    </table>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </table>
            </div>
        <% } %>
    </body>

</html>
