<%@page import="ece358.utils.Constants"%>
<%@page import="java.util.List"%>
<%@page import="ece358.models.Staff"%>
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
        <script type="text/javascript" src="js/admin.js"></script>
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
           Users user = (Users) request.getSession().getAttribute("user");
           List<Staff> doctors = (List<Staff>) request.getAttribute("doctors");
           List<Staff> staff = (List<Staff>) request.getAttribute("staff");
           List<Users> users = (List<Users>) request.getAttribute("users");
        %>
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
               getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
               "<%=request.getSession().getAttribute("firstname")%>",
               "<%=request.getSession().getAttribute("lastname")%>");
            })
        </script>
        <div id="navbar-container"></div>
        <div class="content content-pad">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#password_reset" data-toggle="tab">Password Manager</a></li>
              <% if (user.getRole().equals(Constants.IT)) {%>
                <li><a href="#staff_manager" data-toggle="tab">Staff Manager</a></li>
              <%}%>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active pwd-padding" id="password_reset">
                    <form action="AdminServlet?action=PasswordReset" onsubmit="return validate();" method="post">
                        <div class="form-group">
                            <select id="user-id" name="userID">
                                <%if (users == null) {%>
                                <option value="<%= user.getUserId()%>"><%= user.getUserId()%></option>
                                <%} else { for (int i = 0; i < users.size(); i++) {%>
                                <option value="<%= users.get(i).getUserId()%>"><%= users.get(i).getUserId()%></option>
                                <%}}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <input id="password" type="password" name="password" placeholder="Password"/>
                        </div>
                        <div class="form-group">
                            <input id="confirm-password" type="password" placeholder="Confirm Password"/>
                        </div>
                        <div class="form-group">
                            <input class="btn btn-primary" type="submit" value="Submit"/>
                        </div>
                    </form>
                </div>
                <div class="tab-pane" id="staff_manager">
                    <button onclick="addUser()" class="btn btn-warning pull-right add-user"><i class="fa fa-user fa-4"></i></button>
                    <table id="staffs" class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <td>User ID</td>
                                <td>First Name</td>
                                <td>Last Name</td>
                                <td>Managing Doctor</td>
                                <td>Job Title</td>
                                <td>Currently Employed?</td>
                            </tr>
                        </thead>
                        <%for (int j = 0; staff != null && j < staff.size(); j++) {%>
                            <tr id="staff-info-<%= j %>" onclick="loadStaffInfo('<%= j %>')" >
                                <td class="user-id"> <%= staff.get(j).getUserId() %></td>
                                <td class="first-name"> <%= staff.get(j).getFirstName() %></td>
                                <td class="last-name"> <%= staff.get(j).getLastName() %></td>
                                <td class="managing-doctor"> <%= (staff.get(j).getManagingDoctorId() != null) ? staff.get(j).getManagingDoctorId() : "" %></td>
                                <td class="job-title"> <%= staff.get(j).getJobTitle() %></td>
                                <td class="currently-employed"> <%= staff.get(j).isCurrentlyEmployed() %></td>
                            </tr>
                        <%}%>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="userUpdate" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title">Staff</h4>
                    </div>
                    <form id="user-submit-form" action="AdminServlet?action=UpdateStaff" method="post">
                        <div class="modal-body">
                                <div class="form-group">
                                    <input class="hidden" class="form-control" id="modal-user-id" type="text" name="userID" readonly/>
                                </div>
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input id="modal-user-fname" class="form-control" type="text" name="firstName"/>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input id="modal-user-lname" class="form-control" type="text" name="lastName"/>
                                </div>
                                <div class="form-group">
                                    <label for="managingDoctorID">Managing Doctor</label>
                                    <select id="modal-user-managing-doctor" class="form-control" name="managingDoctorID">
                                        <option value="">--NONE--</option>
                                        <% for (int i = 0; doctors != null && i < doctors.size(); i++) {%>
                                        <option value="<%= doctors.get(i).getUserId() %>"><%= doctors.get(i).getFirstName() + " " + doctors.get(i).getLastName()%></option> 
                                        <%}%>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="jobTitle">Job Title</label>
                                    <input id="modal-user-jtitle" class="form-control" type="text" name="jobTitle"/>
                                </div>
                                <div class="form-group">
                                    <label for="currentlyEmployed">Currently Employed</label></br>
                                    <input type="checkbox" id="modal-user-fired" name="currentlyEmployed" data-on-text="Yes" data-off-text="No"/>
                                </div>
                        </div>
                        <div class="modal-footer">
                          <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                  </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
              </div><!-- /.modal -->
        </div>
    </body>
</html>
