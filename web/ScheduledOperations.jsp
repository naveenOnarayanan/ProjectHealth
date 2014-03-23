<%-- 
    Document   : ScheduledOperations
    Created on : Mar 22, 2014, 1:25:26 PM
    Author     : Josh
--%>

<%@page import="ece358.models.Operations"%>
<%@page import="ece358.models.Staff"%>
<%@page import="ece358.models.Scheduledoperations"%>
<%@page import="java.util.List"%>
<%@page import="ece358.models.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="js/scheduledoperations.js"></script>

        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
         <% List<Scheduledoperations> schedoperationsPast = (List<Scheduledoperations>) request.getAttribute("schedoperationsPast"); %>
         <% List<Staff> surgeonsPast = (List<Staff>) request.getAttribute("surgeonsPast"); %>
         <% List<Operations> operationsPast= (List<Operations>) request.getAttribute("operationsPast"); %>
         <% List<Scheduledoperations> schedoperationsFuture = (List<Scheduledoperations>) request.getAttribute("schedoperationsFuture"); %>
         <% List<Staff> surgeonsFuture = (List<Staff>) request.getAttribute("surgeonsFuture"); %>
         <% List<Operations> operationsFuture = (List<Operations>) request.getAttribute("operationsFuture"); %>
        <title>Scheduled Operations</title>
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
        <h1>Operations</h1>
        <h4>Upcoming Operations</h4>
        <div id="content">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Related Appointment Number</th>
                        <th>Operation</th>
                        <th>Date</th>
                        <th>Surgeon</th>
                    </tr>
                </thead>
                <tbody>
                    <%if(schedoperationsFuture != null){%>
                    <%for(int i = 0; i<schedoperationsFuture.size(); i++){%>
                    <tr>
                        <td><%=schedoperationsFuture.get(i).getVisitId()%></td>
                        <td onclick="populateOperationModal('<%=operationsFuture.get(i).getName()%>','<%=operationsFuture.get(i).getDescription()%>','<%=operationsFuture.get(i).getEstTime().getHours()%>','<%=operationsFuture.get(i).getEstTime().getMinutes()%>')" style="cursor:pointer"><%=schedoperationsFuture.get(i).getOperationName()%></td>
                        <td><%=schedoperationsFuture.get(i).getOperationDateTime().toString()%></td>
                        <td>Dr.<%=surgeonsFuture.get(i).getLastName()%></td>
                    </tr>
                    <%}
                    }%>
                </tbody>
            </table>
        </div>
        <h4>Past Operations</h4>
        <div id="content">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Related Appointment Number</th>
                        <th>Operation</th>
                        <th>Date</th>
                        <th>Surgeon</th>
                    </tr>
                </thead>
                <tbody>
                    <%if(schedoperationsPast != null){%>
                    <%for(int i = 0; i<schedoperationsPast.size(); i++){%>
                    <tr>
                        <td><%=schedoperationsPast.get(i).getVisitId()%></td>
                        <td onclick="populateOperationModal('<%=operationsPast.get(i).getName()%>','<%=operationsPast.get(i).getDescription()%>','<%=operationsPast.get(i).getEstTime().getHours()%>','<%=operationsPast.get(i).getEstTime().getMinutes()%>')" style="cursor:pointer"><%=schedoperationsPast.get(i).getOperationName()%></td>
                        <td><%=schedoperationsPast.get(i).getOperationDateTime().toString()%></td>
                        <td>Dr.<%=surgeonsPast.get(i).getLastName()%></td>
                    </tr>
                    <%}
                    }%>
                </tbody>
            </table>
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
