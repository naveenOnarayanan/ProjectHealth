<%-- 
    Document   : personalinfo
    Created on : Mar 16, 2014, 4:46:55 PM
    Author     : Josh
--%>

<%@page import="java.lang.String"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="ece358.models.Users"%>
<%@page import="ece358.models.Country"%>
<%@page import="ece358.models.Province"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%Boolean MinimalMode = (Boolean)request.getAttribute("MinimalMode");%>
        <% String error = (String) request.getAttribute("error"); %>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
        <% String Address = (String) request.getAttribute("Address"); %>
        <% String City = (String) request.getAttribute("City"); %>
        <% String Province = (String) request.getAttribute("Province"); %>
        <% String PostalCode = (String) request.getAttribute("PostalCode"); %>
        <% String Country = (String) request.getAttribute("Country"); %>
        <% String DefaultDoctorID = (String) request.getAttribute("DefaultDoctorID"); %>
        <% String DefaultDoctorLName = (String) request.getAttribute("DefaultDoctorLName");%>
        <% String Email = (String) request.getAttribute("Email"); %>
        <% String FirstName = (String) request.getAttribute("FirstName"); %>
        <% String LastName = (String) request.getAttribute("LastName"); %>
        <% String HealthCardNumber = (String) request.getAttribute("HealthCardNumber"); %>
        <% String HealthStatus = (String) request.getAttribute("HealthStatus"); %>
        <% String PhoneNumber = (String) request.getAttribute("PhoneNumber"); %>
        <% String PrimaryContactNo = (String) request.getAttribute("PrimaryContactNo"); %>
        <% String SIN = (String) request.getAttribute("SIN"); %>
        <% String Visits = ((Integer)request.getAttribute("Visits")).toString(); %>
        <% int mode  = Integer.parseInt((String)request.getParameter("mode"));%>
        <% List<Country> Countries = (List<Country>) request.getAttribute("Countries");%>
        <% List<Province> Provinces = (List<Province>) request.getAttribute("Provinces");%>
        <% String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][[ABCEGHJKLMNPRSTVWXYZ][0-9]";
           String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";%>
        <% String buttons = "<button type = \"submit\" class=\"btn btn-success\" formaction=\"PersonalInfo?mode=2\">Edit</button>";%>
        <% String disabled = "";
           if(mode == 1)
           {
               disabled = "disabled";
           }
           else if(mode == 2)
           {
               buttons = "<button class=\"btn btn-success\" type = \"submit\" formaction=\"PersonalInfo?mode=1\" formnovalidate>Cancel</button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<input class=\"btn btn-success\" type=\"submit\"></button>";
           }
           if(MinimalMode)
               buttons="";
        %>
           <% HashMap<String,String> errors = (HashMap<String,String>) request.getAttribute("errors");%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%if(!MinimalMode){%>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <%}%>
        <script>
             $(document).ready(function() { $("#Province").select2(); });
             $(document).ready(function() { $("#Country").select2(); });
        </script>
        <title>Personal Information</title>
    </head>
    <body>
        <%if(!MinimalMode){%>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>", 
           "<%=request.getSession().getAttribute("firstname")%>",
           "<%=request.getSession().getAttribute("lastname")%>");
        })
        </script>

        <div id="navbar-container"></div>
        <%}%>
        <div id="content-patient-info" style="padding-left: 13%; padding-right: 13%">
        
        <% if (error != null && !error.equals("")) { %>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <%= error %>
            </div>
        <% } %>
        
        <% if (!queryServletError) { %>
        <% if(!MinimalMode){%>
        <div>
            <h1 style="padding-left: 8px">Personal Information</h1>
        </div>
        <%}%>
        <form method ="post" action="/ProjectHealth/PersonalInfo?mode=3" style="padding-left:10px">
            <% if(errors != null && errors.size() != 0){ %>
            <div class="rounded-div"style="background-color:#FF9494; width:900px">
            <h3>Try Again</h3>
                    <ul>
                    <% Collection<String> entries = errors.values();
                       Iterator it = entries.iterator();
                       String s;
                       while(it.hasNext())
                       {
                            s = (String)it.next();%>
                       <li><%=s%></li>
                       <%}%>
                    </ul>
            </div>
            <%}%>
            <table class="rounded-table" cellpadding="10" style="float:left; background-color:#F8F8F8; width: 100%">
                <tr>
                    <td class="patient-info-text">First Name:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="FirstName" name ="FirstName" value = "<%=FirstName%>" disabled></input></td>
                    <input type = "hidden" id="FirstName" name ="FirstName" value = "<%=FirstName%>" ></input>
                    <td class="patient-info-text">Phone Number:<br>(000-000-0000)</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" type = "tel" id="PhoneNumber" name ="PhoneNumber"  pattern='<%=PhoneNumberRegex%>' value = "<%=PhoneNumber%>" <%=disabled%>></input></td>
                </tr>
                <tr>
                    <td class="patient-info-text">Last Name:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="LastName" name ="LastName" value = "<%=LastName%>" disabled></input></td>
                    <input type = "hidden" id="LastName" name ="LastName" value = "<%=LastName%>" ></input>
                    <td class="patient-info-text">Contact Phone Number:<br>(000-000-0000)</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel"  id="PrimaryContactNo" name ="PrimaryContactNo" pattern='<%=PhoneNumberRegex%>' value = "<%=PrimaryContactNo%>" <%=disabled%>></input></td>
                </tr>
                <tr>
                    <td class="patient-info-text">Address:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="Address" name="Address" value = "<%=Address%>" <%=disabled%>></input></td>
                    <td class="patient-info-text">Health Card Number:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>" disabled></input></td>
                    <input type = "hidden" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>"></input>
                </tr>
                <tr>
                    <td class="patient-info-text">City:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="City" name ="City" value = "<%=City%>" <%=disabled%>></input></td>
                    <td class="patient-info-text">SIN</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="SIN" name ="SIN" value = "<%=SIN%>" disabled></input></td>
                    <input type = "hidden" id="SIN" name ="SIN" value = "<%=SIN%>" ></input>
                </tr>
                <tr>
                    <td class="patient-info-text">Province:</td>
                    <td class="patient-info-chart-textbox">
                    <select class="patient-info-chart" id="Province" name ="Province" <%=disabled%>>
                        <%for(Province c : Provinces)
                            {
                                String code = c.getCode();
                                String name = c.getName();
                                if(code.equals(Province)){%>
                                 <option value="<%=code%>" selected><%=name%></option>
                            <%}
                                else{%>
                                 <option value="<%=code%>"><%=name%></option>  
                                <%}
                            }%>
                    </select>
                    </td>
                    <td class="patient-info-text">Doctor:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="DefaultDoctorLName" name ="DefaultDoctorLName" value = "Dr.<%=DefaultDoctorLName%>" disabled></input></td>
                    <input type = "hidden" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" ></input>
                </tr>
                <tr>
                    <td class="patient-info-text">Postal Code:<br>(A0A 0A0)</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" pattern="<%=PostalCodeRegex%>"  id="PostalCode" name ="PostalCode"  value = "<%=PostalCode%>" <%=disabled%>></input></td>
                    <td class="patient-info-text">Health Status:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" disabled></input></td>
                    <input type = "hidden" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" ></input>
      
                </tr>
                <tr>
                    <td class="patient-info-text">Country:</td>
                    <td class="patient-info-chart-textbox">
                    <select class="patient-info-chart" id="Country" name ="Country" <%=disabled%>>
                        <%for(Country c : Countries)
                            {
                                String s = c.getName();
                                if(s.equals(Country)){%>
                                 <option value="<%=s%>" selected><%=s%></option>
                            <%}
                                else{%>
                                 <option value="<%=s%>"><%=s%></option>  
                                <%}
                            }%>
                    </select>
                    </td>
                    <td class="patient-info-text">Visits:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="Visits" name ="Visits" value = "<%=Visits%>" disabled></input></td>
                    <input type = "hidden" id="Visits" name ="Visits" value = "<%=Visits%>" ></input>
                </tr>
                <tr>
                    <td class="patient-info-text">Email:</td>
                    <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "email" id="Email" name ="Email" value = "<%=Email%>" <%=disabled%>></input></td>
                    <td></td>
                    <td align="left"><%=buttons%></td>
                </tr>
            </table>
            </form>
          <% } %>
          </div>
    </body>

</html>
