<%-- 
    Document   : Prescriptions
    Created on : 20-Mar-2014, 2:49:13 PM
    Author     : Eric
--%>
 
<%@page import="com.google.gson.Gson"%>
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
        <% String error = (String) request.getAttribute("error"); %>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
        <% List<PrescriptionInfo> prescriptions = (List<PrescriptionInfo>) request.getAttribute("prescriptions"); %>
        <% Boolean FullView = (Boolean) request.getAttribute("FullView"); %>
        <%  Users user = (Users) request.getSession().getAttribute("user"); %>
        <% if (FullView) {%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/js/jquery.tablesorter.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/js/jquery.tablesorter.widgets.js"></script>
        <script type="text/javascript" src="http://mottie.github.io/tablesorter/addons/pager/jquery.tablesorter.pager.js"></script>
        <script type="text/javascript" src="js/main.js"></script>

        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.css"/>
        <link rel="stylesheet" href="http://mottie.github.io/tablesorter/addons/pager/jquery.tablesorter.pager.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.13.3/css/theme.ice.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <%}%>

        <title>Prescriptions</title>
    </head>
    <body>
        <% if (FullView) {%>
        <script>
            $(function() {
                getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
                "<%=request.getSession().getAttribute("firstname")%>",
                "<%=request.getSession().getAttribute("lastname")%>");
            });
        </script>
        <script defer="defer">
            $(document).ready(function()  { 
                    $(".search-bar").hide();
                    var clicked = false;
                    $("#open-search-bar").click(function() {
                        if (!clicked) {
                            $(".search-bar").show();
                            $("#open-search-bar").animate({
                                right: "180px",
                            });
                            $(".search-bar").animate({
                                right: "0px",
                            });

                            setTimeout(function() {$(".search-bar input").first().focus()}, 250);
                            clicked = true;
                        } else {
                            clicked = false;
                        }

                    });

                    $(document).mouseup(function (e) {
                        var container = $(".search-bar");

                        if (!container.is(e.target) // if the target of the click isn't the container...
                            && container.has(e.target).length === 0 && clicked) // ... nor a descendant of the container
                        {
                            $("#open-search-bar").animate({
                                right: "0px"
                            });
                            $(".search-bar").animate({
                                right: "-180px",
                            }, function() {$(".search-bar").hide();});

                            setTimeout(function() {clicked = false;}, 250);
                        }
                    });
                 

                $("#prescriptions").tablesorter({
                    theme: "ice",
                    widgets: ["filter"],
                    dateFormat: "MM/dd/yyyy hh:mm aa",
                    widgetOptions: {
                        filter_external : '.search',
                        filter_columnFilters: false,
                        filter_saveFilters : false,
                    }
                }).tablesorterPager({
                    container: $("#Pager"),
                    cssGoto: ".pagenum",
                    output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                });
                
             });
        </script>
        <%if(FullView){%>
        <div class="search-bar">
           <div class="jumbotron input-container">

                <input class="search" type="search" data-column="0" placeholder="Patient ID">
                <input type="search" class="search" data-column="1" placeholder="DIN"/>
                <input type="search" class="search" data-column="2" placeholder="Trade Name"/>
                <input type="search" class="search" data-column="3" placeholder="Quantity (mg)"/>
                <input type="search" class="search" data-column="4" placeholder="Refills"/>
                <input type="search" class="search" data-column="5" placeholder="Dosage"/>
                <input type="search" class="search" data-column="6" placeholder="Prescribed Date"/>
                <input type="search" class="search" data-column="7" placeholder="Expiry Date"/>
                <center><button type="reset" class="reset btn btn-primary btn-xs">Reset</button></center>
           </div>
        </div>
        <button id="open-search-bar" class="btn btn-primary pull-right" ><i class="fa fa-search"></i></button>
       <%}%>
       
        <div id="navbar-container"></div>
        
        <% if (error != null && !error.equals("")) { %>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <%= error %>
            </div>
        <%  }
          }%>
        
        <table class="center-block">
            <tr>
                <th style="width: 70%;"><h1 class="table-header">Prescriptions</h1></th>
            </tr>
        </table>
        
        <div class="center-block">
            <table id="prescriptions" class="table table-hover tablesorter table-bordered">
                <thead>
                    <tr>
                        <th>Related Appointment #</th>
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
                
                <% if (!queryServletError && prescriptions != null) { %>
                    <% for (int i = 0; i < prescriptions.size(); i++) { %>
                    <tr class="info" id="patientPrescription-<%= i %>">
                        <td><a href="AppointmentServlet?action=query&visitId=<%= prescriptions.get(i).getVisitID()%>"><%= prescriptions.get(i).getVisitID() %></a></td>
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
                    <% } %>
                <% } %>
                
                <tfoot id="Pager">
                        <tr>
                            <th colspan="9" class="ts-pager form-horizontal">
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
    </body>
</html>
