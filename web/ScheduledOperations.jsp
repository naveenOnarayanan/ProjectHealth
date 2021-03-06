<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ece358.models.Patients"%>
<%@page import="ece358.models.Operations"%>
<%@page import="ece358.models.Staff"%>
<%@page import="ece358.models.Scheduledoperations"%>
<%@page import="java.util.List"%>
<%@page import="ece358.models.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <% Boolean FullView = (Boolean)request.getAttribute("FullView");%>
        <% String error = (String) request.getAttribute("error"); %>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
        <% List<Scheduledoperations> schedoperationsPast = (List<Scheduledoperations>) request.getAttribute("schedoperationsPast"); %>
        <% List<Staff> surgeonsPast = (List<Staff>) request.getAttribute("surgeonsPast"); %>
        <% List<Staff> doctorsPast = (List<Staff>) request.getAttribute("doctorsPast"); %>
        <% List<Operations> operationsPast= (List<Operations>) request.getAttribute("operationsPast"); %>
        <% List<Patients> patientsPast= (List<Patients>) request.getAttribute("patientsPast"); %>
        <% List<Scheduledoperations> schedoperationsFuture = (List<Scheduledoperations>) request.getAttribute("schedoperationsFuture"); %>
        <% List<Staff> surgeonsFuture = (List<Staff>) request.getAttribute("surgeonsFuture"); %>
        <% List<Staff> doctorsFuture = (List<Staff>) request.getAttribute("doctorsFuture"); %>
        <% List<Operations> operationsFuture = (List<Operations>) request.getAttribute("operationsFuture"); %>
        <% List<Patients> patientsFuture = (List<Patients>) request.getAttribute("patientsFuture"); %>
        <% SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm aa");%>
        <% Users SessionUser = ((Users) request.getSession().getAttribute("user"));%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% if (FullView) {%>
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
        <script type="text/javascript" src="js/scheduledoperations.js"></script>
        <title>Scheduled Operations</title>
    </head>
    <body>
        <%if(FullView){%>
        <script>
        $(function() {
           getNavbar("<%= SessionUser.getRole()%>", 
           "<%=request.getSession().getAttribute("firstname")%>",
           "<%=request.getSession().getAttribute("lastname")%>");
        })
        </script>
        <script defer="defer">
	$(document).ready(function() {
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

                $("#UpcomingOperationsTable")
                        .tablesorter({
                            theme: "ice",
                            widthFixed: true,
                            widgets: ["filter"],
                            dateFormat: "MM/dd/yyyy HH:mm aa",
                            widgetOptions: {
                            filter_external : '.search',
                            filter_columnFilters: false,
                            filter_saveFilters : true,
                            filter_reset: '.reset',
                            }
                        })
                        .tablesorterPager({
                            container: $("#UpcomingPager"),
                            cssGoto: ".pagenum",
                            output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                }); 

                $("#PastOperationsTable")
                        .tablesorter({
                            theme: "ice",
                            widthFixed: true,
                            widgets: ["filter"],
                            dateFormat: "MM/dd/yyyy HH:mm aa",
                            widgetOptions: {
                            filter_external : '.search',
                            filter_columnFilters: false,
                            filter_saveFilters : true,
                            filter_reset: '.reset',
                            }
                        })
                        .tablesorterPager({
                            container: $("#PastPager"),
                            cssGoto: ".pagenum",
                            output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                }); 
                
            }); 
        </script>
        <%}%>
        <div id="navbar-container"></div>
        
        <% if (error != null && !error.equals("")) { %>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <%= error %>
            </div>
        <% } %>
        

        <%if(FullView){%>
        <div class="search-bar">
           <div class="jumbotron input-container">
               <%if(SessionUser.getRole().equals("patient")){%>
                <input class="search" type="search" data-column="0" placeholder="Appointment #">
                <input class="search" type="search" data-column="1" placeholder="Operation">
                <input class="search" type="search" data-column="2" placeholder="Date">
                <input class="search" type="search" data-column="3" placeholder="Surgeon">
               <%}else{%>
                <input class="search" type="search" data-column="0" placeholder="Appointment #">
                <input class="search" type="search" data-column="1" placeholder="Patient ID">
                <input class="search" type="search" data-column="2" placeholder="Patient Name">
                <input class="search" type="search" data-column="3" placeholder="Operation">
                <input class="search" type="search" data-column="4" placeholder="Date">
                <input class="search" type="search" data-column="5" placeholder="Surgeon">
                <input class="search" type="search" data-column="6" placeholder="Primary Doctor">
                <%}%>
                <center><button type="reset" class="reset btn btn-primary btn-xs">Reset</button></center>
           </div>
        </div>
        <button id="open-search-bar" class="btn btn-primary pull-right" ><i class="fa fa-search"></i></button>
        <%}%>
        <div id="dynamic-table">
        <h1>Scheduled Operations</h1>
        <ul class="nav nav-tabs tab-space">
               <li class="tab-button active" id="upcoming-operations-tab"><a href="#upcoming-operation" data-toggle="tab">Upcoming Operations</a></li>
               <li class="tab-button" id="past-operations-tab"><a href="#past-operations" data-toggle="tab">Past Operations</a></li>
       </ul>
        <br>
        <div class="tab-content">
            <div class="tab-pane active" id="upcoming-operation">
                    <% if (!queryServletError) { %>
                    <table class="table table-hover tablesorter table-bordered" id="UpcomingOperationsTable">
                        <thead>
                            <tr>
                                <th style="width: 14%">Related Appointment Number</th>
                                <%if(!patientsFuture.isEmpty()){%>
                                <th style="width: 14%">Patient ID</th>
                                <th style="width: 14%">Patient Name</th>
                                <%}%>
                                <th style="width: 25%">Operation</th>
                                <th style="width: 14%">Date</th>
                                <th style="width: 14%">Surgeon</th>
                                <%if(!doctorsFuture.isEmpty()){%>
                                <th style="width: 14%">Primary Doctor</th>
                                <%}%>
                            </tr>
                        </thead>
                        <%if(FullView){%>
                        <tfoot id="UpcomingPager">
                        <tr>
                            <%if(!patientsFuture.isEmpty()){%>
                                <th colspan="7" class="ts-pager form-horizontal">
                            <%}else{%>
                                <th colspan="4" class="ts-pager form-horizontal">
                            <%}%>
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
                        <%}%>
                        <tbody>
                            <%if(schedoperationsFuture != null){%>
                            <%for(int i = 0; i<schedoperationsFuture.size(); i++){%>
                            <tr>
                               <%if(SessionUser.getRole().equals("doctor") && !SessionUser.getUserId().equals(doctorsFuture.get(i).getUserId())){%>
                                <td><%= schedoperationsFuture.get(i).getVisitId() %></td>
                                <%}else{%>
                                <td><a href="AppointmentServlet?action=query&visitId=<%= schedoperationsFuture.get(i).getVisitId()%>"><%= schedoperationsFuture.get(i).getVisitId() %></a></td>     
                                <%}%> 
                                <%if(!patientsFuture.isEmpty()){%>
                                <td><%=patientsFuture.get(i).getUserId()%></td>
                                <td><%=patientsFuture.get(i).getFirstName()%> <%=patientsFuture.get(i).getLastName()%></td>
                                <%}%>
                                <td onclick="populateOperationModal('<%=operationsFuture.get(i).getName()%>','<%=operationsFuture.get(i).getDescription()%>','<%=operationsFuture.get(i).getEstTime().getHours()%>','<%=operationsFuture.get(i).getEstTime().getMinutes()%>')" style="cursor:pointer"><%=schedoperationsFuture.get(i).getOperationName()%></td>
                                <td><%=dateFormat.format(schedoperationsFuture.get(i).getOperationDateTime())%></td>
                                <td>Dr.<%=surgeonsFuture.get(i).getLastName()%></td>
                                <%if(!doctorsFuture.isEmpty()){%>
                                <td>Dr.<%=doctorsFuture.get(i).getLastName()%></td>
                                <%}%>
                            </tr>
                            <%}
                            }%>
                        </tbody>
                    </table>
                    <% } %>
                </div>
                <div class="tab-pane" id="past-operations">
                    <% if (!queryServletError) { %>
                    <table class="table table-hover table-bordered" id="PastOperationsTable">
                        <thead>
                            <tr>
                                <th style="width: 14%">Related Appointment Number</th>
                                <%if(!patientsPast.isEmpty()){%>
                                <th style="width: 14%">Patient ID</th>
                                <th style="width: 14%">Patient Name</th>
                                <%}%>
                                <th style="width: 25%">Operation</th>
                                <th style="width: 14%">Date</th>
                                <th style="width: 14%">Surgeon</th>
                                <%if(!doctorsPast.isEmpty()){%>
                                <th style="width: 14%">Primary Doctor</th>
                                <%}%>
                            </tr>
                        </thead>
                        <%if(FullView){%>
                        <tfoot id="PastPager">
                        <tr>
                            <%if(!patientsPast.isEmpty()){%>
                                <th colspan="7" class="ts-pager form-horizontal">
                            <%}else{%>
                                <th colspan="4" class="ts-pager form-horizontal">
                            <%}%>
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
                        <%}%>
                        <tbody>
                            <%if(schedoperationsPast != null){%>
                            <%for(int i = 0; i<schedoperationsPast.size(); i++){%>
                            <tr>
                                <%if(SessionUser.getRole().equals("doctor") && !SessionUser.getUserId().equals(doctorsPast.get(i).getUserId())){%>
                                <td><%= schedoperationsPast.get(i).getVisitId() %></td>
                                <%}else{%>
                                <td><a href="AppointmentServlet?action=query&visitId=<%= schedoperationsPast.get(i).getVisitId()%>"><%= schedoperationsPast.get(i).getVisitId() %></a></td>     
                                <%}%>                                
                                <%if(!patientsPast.isEmpty()){%>
                                <td><%=patientsPast.get(i).getUserId()%></td>
                                <td><%=patientsPast.get(i).getFirstName()%> <%=patientsPast.get(i).getLastName()%></td>
                                <%}%>
                                <td onclick="populateOperationModal('<%=operationsPast.get(i).getName()%>','<%=operationsPast.get(i).getDescription()%>','<%=operationsPast.get(i).getEstTime().getHours()%>','<%=operationsPast.get(i).getEstTime().getMinutes()%>')" style="cursor:pointer"><%=schedoperationsPast.get(i).getOperationName()%></td>
                                <td><%=dateFormat.format(schedoperationsPast.get(i).getOperationDateTime())%></td>
                                <td>Dr.<%=surgeonsPast.get(i).getLastName()%></td>
                                <%if(!doctorsPast.isEmpty()){%>
                                <td>Dr.<%=doctorsPast.get(i).getLastName()%></td>
                                <%}%>
                            </tr>
                            <%}
                            }%>
                        </tbody>
                    </table>
                    <% } %>
                </div>
            </div>
        </div>
                
        <div class="modal fade" id="operation-modal" tabindex="-1" role="dialog" aria-labelledby="Operations" aria-hidden="true">
           <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title" id="operations-modal-title"></h4>
               </div>
                 <div class="modal-body" id="operations-modal-body" style="text-align:center; padding-left: 5px; max-height:250px">
                     <h5>Description</h5>
                     <textarea id="operation-modal-body-description" rows="2" cols="35" disabled style="resize: none;"></textarea><br><br>
                     <h5>Estimated Time</h5>
                     <input type="text" id="operation-modal-body-esttime-hour" style="width:50px" disabled></input> <h6 style="display:inline">Hours</h6>
                     <input type="text" id="operation-modal-body-esttime-min" style="width:50px" disabled></input> <h6 style="display:inline" >Minutes</h6>
                 </div>
             </div>
           </div>
        </div>
    </body>
</html>
