<%-- 
    Document   : PatientLookup
    Created on : Mar 18, 2014, 3:07:44 PM
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
<%@page import="ece358.models.Patients"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <% String Address = (String) request.getAttribute("Address"); %>
        <% String City = (String) request.getAttribute("City"); %>
        <% String Province = (String) request.getAttribute("Province"); %>
        <% String PostalCode = (String) request.getAttribute("PostalCode"); %>
        <% String Country = (String) request.getAttribute("Country"); %>
        <% String DefaultDoctorID = (String) request.getAttribute("DefaultDoctorID"); %>
        <% String Email = (String) request.getAttribute("Email"); %>
        <% String FirstName = (String) request.getAttribute("FirstName"); %>
        <% String LastName = (String) request.getAttribute("LastName"); %>
        <% String HealthCardNumber = (String) request.getAttribute("HealthCardNumber"); %>
        <% String HealthStatus = (String) request.getAttribute("HealthStatus"); %>
        <% String PhoneNumber = (String) request.getAttribute("PhoneNumber"); %>
        <% String PrimaryContactNo = (String) request.getAttribute("PrimaryContactNo"); %>
        <% String SIN = (String) request.getAttribute("SIN"); %>
        <% String Vists = (String) request.getAttribute("Vists"); %>
        <% String PatientUserID = (String) request.getAttribute("PatientUserID"); %>
        <% String FirstNameLookup = (String) request.getAttribute("FirstNameLookup"); %>
        <% String LastNameLookup = (String) request.getAttribute("LastNameLookup"); %>
        <% String PatientUserIDLookup = (String) request.getAttribute("PatientUserIDLookup"); %>
        <% int mode  = Integer.parseInt((String)request.getParameter("mode"));%>
        <% List<Country> Countries = (List<Country>) request.getAttribute("Countries");%>
        <% List<Province> Provinces = (List<Province>) request.getAttribute("Provinces");%>
        <% List<Patients> PatientsList = (List<Patients>) request.getAttribute("Patients");%>
        <% String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][[ABCEGHJKLMNPRSTVWXYZ][0-9]";
           String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";
           String HealthCardRegex = "^([0-9]){4}-([0-9]){3}-([0-9]){3}-([ABCDEFGHIJKLMNOPQRSTUVWXYZ]){2}$";
           String SINRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){3}$";%>
        <% String buttons = "<button class=\"square-button\" type = \"submit\" formaction=\"PatientLookup?mode=2\">Edit</button>";%>
        <% String disabled = "";
           if(mode == 1)
           {
               disabled = "disabled";
               if(PatientUserID == null || PatientUserID == "")
                   buttons = "<button class=\"square-button\" type = \"submit\" formaction=\"PatientLookup?mode=2\" disabled>Edit</button>";
           }
           else if(mode == 2)
           {
               buttons = "<button class=\"square-button\" type = \"submit\" formaction=\"PatientLookup?mode=1\" formnovalidate>Cancel</button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<input class=\"square-button\" type=\"submit\"></button>";
           }%>
           <% HashMap<String,String> errors = (HashMap<String,String>) request.getAttribute("errors");%>

           
        <title>Patient Lookup</title>
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
        <h1>Patient Lookup</h1>
        <h4 style="padding-left: 25px">Search</h4>
        <div style="padding-left: 25px">
            <form method ="post" action="PatientLookup?mode=1">
                <table class="rounded-table" width=1175 cellpadding="10" style="background-color:#F8F8F8;">
                    <tr>
                        <td>First Name:</td>
                        <td><input type = "text" id="FirstNameLookup" name ="FirstNameLookup" value="<%=FirstNameLookup%>"></input></td>
                        <td>Patient ID:</td>
                        <td><input type = "text" id="PatientUserIDLookup" name ="PatientUserIDLookup" value="<%=PatientUserIDLookup%>"></input></td>
                    </tr>
                    <tr>
                        <td>Last Name:</td>
                        <td><input type = "text" id="LastNameLookup" name ="LastNameLookup" value="<%=LastNameLookup%>"></input></td>
                        <td>Last Visit: (not yet implemented)</td>
                        <td><input type = "date" id="LastVisitLookup" name ="LastVisitLookup" disabled></input></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><button class="square-button" type = "submit">Search</button></td>
                    </tr>
                </table> 
            </form>
        </div>
        <div style="width:100%; display:table">
            <div style="display: table-row">
                <div style="width: 200px; display: table-cell; float:left; padding-left: 25px">
                    <h4>Patients</h4>
                    <form method="post" action="PatientLookup?mode=1" name="PatientSelectForm">
                        <input type = "hidden" id="FirstNameLookup" name ="FirstNameLookup" value="<%=FirstNameLookup%>"></input>
                        <input type = "hidden" id="PatientUserIDLookup" name ="PatientUserIDLookup" value="<%=PatientUserIDLookup%>"></input>
                        <input type = "hidden" id="LastNameLookup" name ="LastNameLookup" value="<%=LastNameLookup%>"></input>
                        <select id="PatientSelect" name="PatientSelect" onChange="document.PatientSelectForm.submit();"size="20" style="width:200px">
                        <% if(PatientsList != null){
                            for(Patients p : PatientsList){
                                if(PatientUserID.equals(p.getUserId())){%>
                                <option value="<%=p.getUserId()%>"selected><%=p.getFirstName() + " " + p.getLastName()%></option><br>
                                <%}
                                else{%>
                                     <option value="<%=p.getUserId()%>"><%=p.getFirstName() + " " + p.getLastName()%></option><br>
                            <%}
                            }
                        }%>
                        </select>
                    </form>
                </div>
                <div style="display: table-cell; float:left; padding-left: 100px">
                    <h4>Patient Information</h4>
                    <% if(errors != null && errors.size() != 0){ %>
                        <div width="900" style="background-color:#FF9494;">
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
                    <form method ="post" action="/ProjectHealth/PatientLookup?mode=3">
                        <input type = "hidden" id="FirstNameLookup" name ="FirstNameLookup" value="<%=FirstNameLookup%>"></input>
                        <input type = "hidden" id="PatientUserIDLookup" name ="PatientUserIDLookup" value="<%=PatientUserIDLookup%>"></input>
                        <input type = "hidden" id="LastNameLookup" name ="LastNameLookup" value="<%=LastNameLookup%>"></input>
                        <table class="rounded-table" width="900" cellpadding="10" style="float:left; background-color:#F8F8F8">
                            <tr>
                            <input type="hidden" id="PatientUserID" name="PatientUserID" value="<%=PatientUserID%>"></input>
                                <td>First Name:</td>
                                <td><input type = "text" id="FirstName" name ="FirstName" value = "<%=FirstName%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="FirstName" name ="FirstName" value = "<%=FirstName%>" ></input>
                                <td>Phone Number:<br>(000-000-0000)</td>
                                <td><input type = "tel" type = "tel" id="PhoneNumber" name ="PhoneNumber"  pattern='<%=PhoneNumberRegex%>' value = "<%=PhoneNumber%>" <%=disabled%>></input></td>
                            </tr>
                            <tr>
                                <td>Last Name:</td>
                                <td><input type = "text" id="LastName" name ="LastName" value = "<%=LastName%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="LastName" name ="LastName" value = "<%=LastName%>" ></input>
                                <td>Contact Phone Number:<br>(000-000-0000)</td>
                                <td><input type = "tel"  id="PrimaryContactNo" name ="PrimaryContactNo" pattern='<%=PhoneNumberRegex%>' value = "<%=PrimaryContactNo%>" <%=disabled%>></input></td>
                            </tr>
                            <tr>
                                <td>Address:</td>
                                <td><input type = "text" id="Address" name="Address" value = "<%=Address%>" <%=disabled%>></input></td>
                                <td>Health Card Number:<br>(0000-000-000-AA)</td>
                                <td><input type = "tel" id="HealthCardNumber" pattern='<%=HealthCardRegex%>' name="HealthCardNumber" value = "<%=HealthCardNumber%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>"></input>
                            </tr>
                            <tr>
                                <td>City:</td>
                                <td><input type = "text" id="City" name ="City" value = "<%=City%>" <%=disabled%>></input></td>
                                <td>SIN:<br>(000-000-000)</td>
                                <td><input type = "tel" pattern='<%=SINRegex%>' id="SIN" name ="SIN" value = "<%=SIN%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="SIN" name ="SIN" value = "<%=SIN%>" ></input>
                            </tr>
                            <tr>
                                <td>Province:</td>
                                <td>
                                <select id="Province" name ="Province" <%=disabled%>>
                                    <%if(Provinces != null)
                                    {
                                        for(Province c : Provinces)
                                        {
                                            String s = c.getCode();
                                            if(s.equals(Province)){%>
                                             <option value="<%=s%>" selected><%=s%></option>
                                        <%}
                                            else{%>
                                             <option value="<%=s%>"><%=s%></option>  
                                            <%}
                                        }
                                    }%>
                                </select>
                                </td>
                                <td>Doctor:</td>
                                <td><input type = "text" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" ></input>
                            </tr>
                            <tr>
                                <td>Postal Code:<br>(A0A 0A0)</td>
                                <td><input type = "tel" pattern="<%=PostalCodeRegex%>"  id="PostalCode" name ="PostalCode"  value = "<%=PostalCode%>" <%=disabled%>></input></td>
                                <td>Health Status:</td>
                                <td><input type = "text" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" ></input>

                            </tr>
                            <tr>
                                <td>Country:</td>
                                <td>
                                <select id="Country" name ="Country" <%=disabled%>>
                                    <%if(Countries != null){
                                            for(Country c : Countries)
                                            {
                                                String s = c.getName();
                                                if(s.equals(Country)){%>
                                                 <option value="<%=s%>" selected><%=s%></option>
                                            <%}
                                                else{%>
                                                 <option value="<%=s%>"><%=s%></option>  
                                                <%}
                                            }
                                    }%>
                                </select>
                                </td>
                                <td>Visits:</td>
                                <td><input type = "text" id="Visits" name ="Visits" value = "<%=Vists%>" disabled></input></td>
                                <input type = "hidden" id="Visits" name ="Visits" value = "<%=Vists%>" ></input>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td><input type = "email" id="Email" name ="Email" value = "<%=Email%>" <%=disabled%>></input></td>
                                <td></td>
                                <td align="left"><%=buttons%></td>
                            </tr>
                        </table>
                        <div style="clear:both"></div>
                    </form>
                </div>
            </div>
        </div>
                
    </body>

</html>
