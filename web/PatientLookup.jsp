<%@page import="java.lang.String"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="ece358.models.Users"%>
<%@page import="ece358.models.Country"%>
<%@page import="ece358.models.Province"%>
<%@page import="ece358.models.Patients"%>
<%@page import="ece358.models.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
        <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.0.0rc/js/bootstrap-switch.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>
        <script type="text/javascript" src="js/patientlookup.js"></script>
        <script>
             $(document).ready(function() { $("#Province").select2(); });
             $(document).ready(function() { $("#Country").select2(); });
             $(document).ready(function() { $("#DefaultDoctorID").select2(); });
             $(document).ready(function() { $("#SecondaryDoctor").select2(); });
             $(document).ready(function() { $("#DoctorLookup").select2(); });
        </script>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootswatch/3.0.3/yeti/bootstrap.min.css"/>
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min.css"/>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.0.0rc/css/bootstrap2/bootstrap-switch.min.css"/>
        <link rel="stylesheet" href="css/index.css"/>
        <% String error = (String) request.getAttribute("error"); %>
        <% Boolean queryServletError = (Boolean) request.getAttribute("queryServletError"); %>
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
        <% String Visits = (String) request.getAttribute("Visits"); %>
        <% String PatientUserID = (String) request.getAttribute("PatientUserID"); %>
        <% Boolean Transfered = (Boolean)request.getAttribute("Transfered");%>
        <% String FirstNameLookup = (String) request.getAttribute("FirstNameLookup"); %>
        <% String LastNameLookup = (String) request.getAttribute("LastNameLookup"); %>
        <% String PatientUserIDLookup = (String) request.getAttribute("PatientUserIDLookup"); %>
        <% String HealthCardLookup = (String) request.getAttribute("HealthCardLookup"); %>
        <% String DoctorLookup = (String) request.getAttribute("DoctorLookup"); %>
        <% Boolean TransferedLookup = (Boolean) request.getAttribute("TransferedLookup");%>
        <% int mode  = Integer.parseInt((String)request.getParameter("mode"));%>
        <% List<Country> Countries = (List<Country>) request.getAttribute("Countries");%>
        <% List<Province> Provinces = (List<Province>) request.getAttribute("Provinces");%>
        <% List<Patients> PatientsList = (List<Patients>) request.getAttribute("Patients");%>
        <% List<Staff> Doctors = (List<Staff>) request.getAttribute("Doctors");%>
        <% List<String[]> SecondaryDoctors = (List<String[]>) request.getAttribute("SecondaryDoctors");%>
        <% String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][[ABCEGHJKLMNPRSTVWXYZ][0-9]";
           String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";
           String HealthCardRegex = "^([0-9]){4}-([0-9]){3}-([0-9]){3}-([ABCDEFGHIJKLMNOPQRSTUVWXYZ]){2}$";
           String SINRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){3}$";%>
        <% String buttons = "<button class=\"btn btn-success\" type = \"submit\" formaction=\"PatientLookup?mode=2\">Edit</button>";%>
        <% String disabled = "";
           Users SessionUser = ((Users) request.getSession().getAttribute("user"));
           if(mode == 1)
           {
               disabled = "disabled";
               if(PatientUserID == null || PatientUserID == "")
               {
                   if(PatientsList != null && !PatientsList.isEmpty())
                        PatientUserID = PatientsList.get(0).getUserId();
                   buttons = "<button class=\"btn btn-success\" type = \"submit\" formaction=\"PatientLookup?mode=2\" disabled>Edit</button>";
               }
           }
           else if(mode == 2)
           {
                if((PatientUserID == null || PatientUserID == "") && (PatientsList != null && !PatientsList.isEmpty()))
                   PatientUserID = PatientsList.get(0).getUserId();
               buttons = "<button class=\"btn btn-success\" type = \"submit\" formaction=\"PatientLookup?mode=1&PatientUserID=" + PatientUserID + "\" formnovalidate>Cancel</button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<input class=\"btn btn-success\" type=\"submit\"></button>";
           }
           else if(mode == 4){
                  buttons = "<button class=\"btn btn-success\" type = \"submit\" formaction=\"PatientLookup?mode=1\" formnovalidate>Cancel</button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<input class=\"btn btn-success\" type=\"submit\"></button>";
            
            }%>
           <% HashMap<String,String> errors = (HashMap<String,String>) request.getAttribute("errors");%>
           <% Boolean allowDoctorManage = false; %>
           <% if (DefaultDoctorID != null && DefaultDoctorID.equals(((Users)request.getSession().getAttribute("user")).getUserId()))
           {
               allowDoctorManage = true;
           }%>

           
        <title>Patient Lookup</title>
    </head>
    <body>
        <script>
        $(function() {
           $("#content-patient-info").css("height", $(window).height()-75);
           getNavbar("<%= SessionUser.getRole()%>", 
           "<%=request.getSession().getAttribute("firstname")%>",
           "<%=request.getSession().getAttribute("lastname")%>");
        })
        </script>
        <div id="navbar-container"></div>
        <div id="content-patient-info">       
        
        <% if (error != null && !error.equals("")) { %>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">x</button>
                <%= error %>
            </div>
        <% } %>
        
        <div class="patient-info-position">
            <h1 style="margin-top: 0px">Patient Lookup</h1>
        </div>        
        <% if (!queryServletError) { %>
        <div class="patient-info-position">
            <h4>Search</h4>
        </div>        
        <div class="patient-info-position">
            <form method ="post" action="PatientLookup?mode=1">
                <table class="rounded-table" width=1175 cellpadding="10" style="background-color:#F8F8F8; width: 100%">
                    <tr>
                        <td class="patient-info-text">First Name:</td>
                        <td><input class="patient-info-textbox" type="text" id="FirstNameLookup" name ="FirstNameLookup" value="<%=FirstNameLookup%>"></input></td>
                        <td class="patient-info-text">Patient ID:</td>
                        <td><input class="patient-info-textbox" type="text" id="PatientUserIDLookup" name ="PatientUserIDLookup" value="<%=PatientUserIDLookup%>"></input></td>
                    </tr>
                    <tr>
                        <td><text class="patient-info-text">Last Name:</td>
                        <td><input class="patient-info-textbox" type="text" id="LastNameLookup" name ="LastNameLookup" value="<%=LastNameLookup%>"></input></td>
                        <td class="patient-info-text" style="width: 15%">Health Card Number:<br>(0000-000-000-AA)</td>
                        <td><input class="patient-info-textbox" type="text" id="HealthCardLookup" name ="HealthCardLookup" value="<%=HealthCardLookup%>"></input></td>
                    </tr>
                    <tr>
                        <td class="patient-info-text">Doctor:</td>
                        <td><select id="DoctorLookup" name ="DoctorLookup" class="patient-info-textbox">
                                <option value=" " selected></option>
                                    <% if (Doctors != null) { %>
                                         <%for(Staff s : Doctors)
                                            {
                                                String DID = s.getUserId();
                                                String FName = s.getFirstName();
                                                String LName = s.getLastName();
                                                if(DID.equals(DoctorLookup) && DID != null){%>
                                                 <option value="<%=DID%>" selected><%=LName%>, <%=FName%></option>
                                            <%}
                                                else{%>
                                                <option value="<%=DID%>"><%=LName%>, <%=FName%></option>
                                                <%}
                                            }%>
                                    <% } %>
                                </select></td>
                        <td class="patient-info-text">Transfered:</td>
                        <td>
                            <%if(TransferedLookup){%>
                                    <input type="checkbox" id="TransferedLookup" name="TransferedLookup" checked>
                                    <%}else{%>
                                    <input type="checkbox" id="TransferedLookup" name="TransferedLookup">
                            <%}%>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>                            
                            <button style="width: 125px" class="btn btn-success" type = "submit" onClick="clearSearch()">Clear</button>
                            &nbsp;&nbsp;
                            <button style="width: 125px" class="btn btn-success" type = "submit">Search</button>   
                        </td>
                   </tr>
                </table> 
            </form>
        </div>
        <div class="patient-info-position" style="width:100%; display:table; top: 345px">
            <div style="display: table-row">
                <div style="width: 20%; display: table-cell; float: left;">
                    <h4 style="margin-top: 10.5px">Patients</h4>
                    <form method="post" action="PatientLookup?mode=1" name="PatientSelectForm">
                        <input type = "hidden" id="FirstNameLookup" name ="FirstNameLookup" value="<%=FirstNameLookup%>"></input>
                        <input type = "hidden" id="PatientUserIDLookup" name ="PatientUserIDLookup" value="<%=PatientUserIDLookup%>"></input>
                        <input type = "hidden" id="LastNameLookup" name ="LastNameLookup" value="<%=LastNameLookup%>"></input>
                        <input type = "hidden" id="HealthCardLookup" name ="HealthCardLookup" value="<%=HealthCardLookup%>"></input>
                        <input type = "hidden" id="DoctorLookup" name ="DoctorLookup" value="<%=DoctorLookup%>"></input>
                        <div style="visibility:hidden; display:none">
                        <%if(TransferedLookup){%>
                        <input type = "hidden" id="TransferedLookup" name ="TransferedLookup" value="on"></input>
                        <%}else{%>
                        <input type = "hidden" id="TransferedLookup" name ="TransferedLookup" value="off"></input>
                        <%}%>
                        </div>
                        <select class="patient-info-text" id="PatientSelect" name="PatientSelect" onChange="document.PatientSelectForm.submit();"size="20" style="width:100%; height: 437px">
                            <% if(PatientsList != null && !PatientsList.isEmpty()){
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
                        <button class="btn btn-success" type="submit" style="width:100%; margin-top: 10px" formaction="PatientLookup?mode=4">New Patient</button>
                    </form>
                </div>
                <div style="float: right; padding-left: 5%; width: 80%">
                    <h4 style="margin-top: 10.5px">Patient Information [<%=PatientUserID%>]</h4>
                    <% if(errors != null && errors.size() != 0){ %>
                        <div class="alert fade in rounded-div" width="900" style="background-color:#FF9494">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
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
                        <input type = "hidden" id="HealthCardLookup" name ="HealthCardLookup" value="<%=HealthCardLookup%>"></input>
                        <input type = "hidden" id="DoctorLookup" name ="DoctorLookup" value="<%=DoctorLookup%>"></input>
                        <div style="visibility:hidden; display:none">
                        <%if(TransferedLookup){%>
                        <input type = "hidden" id="TransferedLookup" name ="TransferedLookup" value="on"></input>
                        <%}else{%>
                        <input type = "hidden" id="TransferedLookup" name ="TransferedLookup" value="off"></input>
                        <%}%>
                        </div>
                        <table class="rounded-table" cellpadding="10" style="width: 100%; float:left; background-color:#F8F8F8">
                            <tr>
                            <input type="hidden" id="PatientUserID" name="PatientUserID" value="<%=PatientUserID%>"></input>
                                <td class="patient-info-text">First Name:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="FirstName" name ="FirstName" value = "<%=FirstName%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="FirstName" name ="FirstName" value = "<%=FirstName%>" ></input>
                                <td class="patient-info-text">Phone Number:<br>(000-000-0000)</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" type = "tel" id="PhoneNumber" name ="PhoneNumber"  pattern='<%=PhoneNumberRegex%>' value = "<%=PhoneNumber%>" <%=disabled%>></input></td>
                            </tr>
                            <tr>
                                <td class="patient-info-text">Last Name:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="LastName" name ="LastName" value = "<%=LastName%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="LastName" name ="LastName" value = "<%=LastName%>" ></input>
                                <td class="patient-info-text">Contact Phone Number:<br>(000-000-0000)</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel"  id="PrimaryContactNo" name ="PrimaryContactNo" pattern='<%=PhoneNumberRegex%>' value = "<%=PrimaryContactNo%>" <%=disabled%>></input></td>
                            </tr>
                            <tr>
                                <td class="patient-info-text">Address:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="Address" name="Address" value = "<%=Address%>" <%=disabled%>></input></td>
                                <td class="patient-info-text">Health Card Number:<br>(0000-000-000-AA)</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" id="HealthCardNumber" pattern='<%=HealthCardRegex%>' name="HealthCardNumber" value = "<%=HealthCardNumber%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>"></input>
                            </tr>
                            <tr>
                                <td class="patient-info-text">City:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="City" name ="City" value = "<%=City%>" <%=disabled%>></input></td>
                                <td class="patient-info-text">SIN:<br>(000-000-000)</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" pattern='<%=SINRegex%>' id="SIN" name ="SIN" value = "<%=SIN%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="SIN" name ="SIN" value = "<%=SIN%>" ></input>
                            </tr>
                            <tr>
                                <td class="patient-info-text">Province:</td>
                                <td class="patient-info-chart-textbox">
                                <select id="Province" name ="Province" class="patient-info-chart" <%=disabled%>>
                                    <% if (Provinces != null) { %>
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
                                    <% } %>
                                </select>
                                </td>
                                <td class="patient-info-text">Doctor:</td>
                                <td class="patient-info-chart-textbox">
                                    <select class="patient-info-chart" id="DefaultDoctorID" name ="DefaultDoctorID" <%=disabled%>>
                                        <% if (Doctors != null) { %>
                                            <%for(Staff s : Doctors)
                                                {
                                                    String DID = s.getUserId();
                                                    String FName = s.getFirstName();
                                                    String LName = s.getLastName();
                                                    if(DID.equals(DefaultDoctorID) && DID != null){%>
                                                     <option value="<%=DID%>" selected><%=LName%>, <%=FName%></option>
                                                <%}
                                                    else{%>
                                                    <option value="<%=DID%>"><%=LName%>, <%=FName%></option>
                                                    <%}
                                                }%>
                                        <% } %>
                                    </select>
                                </td>
                                <input type = "hidden" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" ></input>
                            </tr>
                            <tr>
                                <td class="patient-info-text">Postal Code:<br>(A0A 0A0)</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "tel" pattern="<%=PostalCodeRegex%>"  id="PostalCode" name ="PostalCode"  value = "<%=PostalCode%>" <%=disabled%>></input></td>
                                <td class="patient-info-text">Health Status:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" <%=disabled%>></input></td>
                                <input type = "hidden" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" ></input>

                            </tr>
                            <tr>
                                <td class="patient-info-text">Country:</td>
                                <td class="patient-info-chart-textbox">
                                <select id="Country" name ="Country" class="patient-info-chart" <%=disabled%>>
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
                                <td class="medium-text">Visits:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "text" id="Visits" name ="Visits" value = "<%=Visits%>" disabled></input></td>
                                <input type = "hidden" id="Visits" name ="Visits" value = "<%=Visits%>" ></input>
                            </tr>
                            <tr>
                                <td class="patient-info-text">Email:</td>
                                <td class="patient-info-chart-textbox"><input class="patient-info-chart" type = "email" id="Email" name ="Email" value = "<%=Email%>" <%=disabled%>></input></td>
                                <td class="patient-info-text">Transfered:</td>
                                <td>
                                    <%if(Transfered){%>
                                    <input type="checkbox" id="Transfered" name="Transfered" checked <%=disabled%>>
                                    <%}else{%>
                                    <input type="checkbox" id="Transfered" name="Transfered" <%=disabled%>>
                                    <%}%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <%if(SessionUser.getUserId().equals(DefaultDoctorID) || (session.getAttribute("managingDoctorID") != null && session.getAttribute("managingDoctorID").equals(DefaultDoctorID))){%>
                                    <button class="btn btn-success" type="button" onclick="window.location = 'AppointmentServlet?action=query&patientId=<%=PatientUserID%>';">View Appointments</button>&nbsp;
                                    <button class="btn btn-success" type="button" onclick="window.location = 'PrescriptionsServlet?UserID=<%=PatientUserID%>';">View Prescriptions</button>
                                    <%}%>
                                </td>
                                <td>

                                    <% if(allowDoctorManage){%>
                                        <script>
                                            var sDoctorIDs = new Array();
                                            var sDoctorFNames = new Array();
                                            var sDoctorLNames = new Array();
                                            var sDoctorExpiry = new Array();
                                        <%for(Object[] s : SecondaryDoctors)
                                        {%>
                                              sDoctorIDs.push("<%=s[0]%>");
                                              sDoctorFNames.push("<%=s[1]%>");
                                              sDoctorLNames.push("<%=s[2]%>");
                                              sDoctorExpiry.push("<%=s[3]%>");
                                        <%}%>
                                        </script>
                                    <button class="btn btn-success" type="button" onClick="$('#sDoctor-modal').modal('show');clearDoctors();populateDoctors(sDoctorIDs,sDoctorFNames,sDoctorLNames,sDoctorExpiry);">Assign Secondary Doctors</button>
                                    <%}%>
                                </td>
                                <td style="text-align: right"><%=buttons%></td>
                            </tr>
                        </table>
                        <div style="clear:both"></div>
                    </form>
                </div>
            </div>
        </div>
                                
        <div class="modal fade" id="sDoctor-modal" tabindex="-1" role="dialog" aria-labelledby="sDoctor" aria-hidden="true">
           <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Secondary Doctors</h4>
               </div>
                 <div class="modal-body" id="sDoctor-modal-body" style="text-align:center">
                    <select id="SecondaryDoctor" name ="SecondaryDoctor" style="width:200px;">
                        <% if (Doctors != null) { %>
                          <%for(Staff s : Doctors)
                            {
                                String DID = s.getUserId();
                                String FName = s.getFirstName();
                                String LName = s.getLastName();
                                if(!DID.equals(DefaultDoctorID)){%>
                                <option value="<%=DID%>"><%=FName%> <%=LName%></option>
                            <%}
                            }%>
                        <% } %>
                    </select>
                    <button type="button" id="addSDoctorButton" onClick="addDoctor()" style="margin-left:10px">&plus;</button>
                    <div id="sDoctor-modal-list" name="sDoctor-modal-list">
                        
                    </div>
                 </div>
                <div class="modal-footer">
                   <button class="btn btn-success" type="button" data-dismiss="modal">Close</button>
                   <button class="btn btn-success" type="button" onClick="writeDoctors()">Save</button>
               </div>
             </div>
           </div>
        </div>
        </div>
        </div>

        <% } %>
    </body>

</html>
