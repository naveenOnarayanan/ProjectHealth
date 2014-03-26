<%-- 
    Document   : ScheduledOperations
    Created on : Mar 22, 2014, 1:25:26 PM
    Author     : Josh
--%>

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

        <link rel="stylesheet" href="css/index.css"/>
        <%}%>
        <script type="text/javascript" src="js/scheduledoperations.js"></script>
        <title>Scheduled Operations</title>
    </head>
    <body>
        <%if(FullView){%>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
           "<%=request.getSession().getAttribute("firstname")%>",
           "<%=request.getSession().getAttribute("lastname")%>");
        })
        </script>
        <script defer="defer">
	$(document).ready(function() 
            { 
                $("#UpcomingOperationsTable")
                        .tablesorter({
                            widthFixed: true,
                            widgets: ["filter", "zebra"],
                            dateFormat: "MM/dd/yyyy HH:mm aa",
                            widgetOptions: {
                            filter_external : '.search',
                            filter_columnFilters: false,
                            filter_saveFilters : true,
                            filter_reset: '.reset',
                            },
                            headers: {
                                4:{sorter:"shortDate"}
                            }
                        })
                        .tablesorterPager({
                            container: $("#UpcomingPager"),
                            cssGoto: ".pagenum",
                            output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                }); 
                $("#PastOperationsTable")
                        .tablesorter({
                            widthFixed: true,
                            widgets: ["filter", "zebra"],
                            dateFormat: "MM/dd/yyyy HH:mm aa",
                            widgetOptions: {
                            filter_external : '.search',
                            filter_columnFilters: false,
                            filter_saveFilters : true,
                            filter_reset: '.reset',
                            },
                            headers: {
                                4:{sorter:"shortDate"}
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
        <input class="search" type="search" data-column="0">
        <input class="search" type="search" data-column="1">
        <input class="search" type="search" data-column="2">
        <input class="search" type="search" data-column="3">
        <input class="search" type="search" data-column="4">
        <input class="search" type="search" data-column="5">
        <input class="search" type="search" data-column="6">
        <%}%>
        <div id="dynamic-table">
        <h1>Scheduled Operations</h1>
        <ul class="nav nav-tabs" style="margin-bottom: -20px">
               <li class="tab-button active" id="upcoming-operations-tab"><a href="#upcoming-operation" data-toggle="tab">Upcoming Operations</a></li>
               <li class="tab-button" id="past-operations-tab"><a href="#past-operations" data-toggle="tab">Past Operations</a></li>
       </ul>
        <br>
        <div class="tab-content">
            <div class="tab-pane active" id="upcoming-operation">
                    <% if (!queryServletError) { %>
                    <table class="table table-hover tablesorter default-table" id="UpcomingOperationsTable">
                        <thead>
                            <tr>
                                <th>Related Appointment Number</th>
                                <%if(!patientsFuture.isEmpty()){%>
                                <th>Patient ID</th>
                                <th>Patient Name</th>
                                <%}%>
                                <th>Operation</th>
                                <th data-sorter="shortDate" data-date-format="MM/dd/yyyy HH:mm aa">Date</th>
                                <th>Surgeon</th>
                                <%if(!doctorsFuture.isEmpty()){%>
                                <th>Primary Doctor</th>
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
                                <td><%=schedoperationsFuture.get(i).getVisitId()%></td>
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
                    <table class="table table-hover default-table" id="PastOperationsTable">
                        <thead>
                            <tr>
                                <th>Related Appointment Number</th>
                                <%if(!patientsPast.isEmpty()){%>
                                <th>Patient ID</th>
                                <th>Patient Name</th>
                                <%}%>
                                <th>Operation</th>
                                <th data-sorter="shortDate" data-date-format="yyyy-mm-dd">Date</th>
                                <th>Surgeon</th>
                                <%if(!doctorsPast.isEmpty()){%>
                                <th>Primary Doctor</th>
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
                                <td><%=schedoperationsPast.get(i).getVisitId()%></td>
                                <%if(!patientsPast.isEmpty()){%>
                                <td><%=patientsPast.get(i).getUserId()%></td>
                                <td><%=patientsPast.get(i).getFirstName()%> <%=patientsFuture.get(i).getLastName()%></td>
                                <%}%>
                                <td onclick="populateOperationModal('<%=operationsPast.get(i).getName()%>','<%=operationsPast.get(i).getDescription()%>','<%=operationsPast.get(i).getEstTime().getHours()%>','<%=operationsPast.get(i).getEstTime().getMinutes()%>')" style="cursor:pointer"><%=schedoperationsPast.get(i).getOperationName()%></td>
                                <td><%=dateFormat.format(schedoperationsFuture.get(i).getOperationDateTime())%></td>
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
                 <h2 class="modal-title" id="operations-modal-title"></h2>
               </div>
                 <div class="modal-body" id="operations-modal-body" style="text-align:center; padding-left: 5px">
                     <h4>Description</h4><br>
                     <textarea id="operation-modal-body-description" rows="4" cols="50" disabled style="resize: none;"></textarea><br><br>
                     <h4>Estimated Time</h4><br>
                     <input type="text" id="operation-modal-body-esttime-hour" style="width:50px" disabled></input> Hours
                     <input type="text" id="operation-modal-body-esttime-min" style="width:50px" disabled></input> Minutes
                 </div>
                <div class="modal-footer">
                   <button type="button" data-dismiss="modal">Close</button>
               </div>
             </div>
           </div>
        </div>
    </body>
</html>
