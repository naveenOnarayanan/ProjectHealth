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
        <% int mode  = Integer.parseInt((String)request.getParameter("mode"));%>
        <% List<Country> Countries = (List<Country>) request.getAttribute("Countries");%>
        <% List<Province> Provinces = (List<Province>) request.getAttribute("Provinces");%>
        <% String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][[ABCEGHJKLMNPRSTVWXYZ][0-9]";
           String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";%>
        <% String buttons = "<button type = \"button\" style=\"width:54px;height:35px;\"><a href = 'PersonalInfo?mode=2' style=\"text-decoration: none;\">Edit</a>";%>
        <% String disabled = "";
           if(mode == 1)
           {
               disabled = "disabled";
           }
           else if(mode == 2)
           {
               buttons = "<button type = \"button\" style=\"width:54px;height:35px;\"><a href = 'PersonalInfo?mode=1' style=\"text-decoration: none\">Cancel</a></button>"
                       + "&nbsp&nbsp&nbsp"
                       + "<input type=\"submit\"></button>";
           }%>
           <% HashMap<String,String> errors = (HashMap<String,String>) request.getAttribute("errors");%>

           
        <title>Personal Information</title>
    </head>
    <body>
        <script>
        $(function() {
           getNavbar("<%= ((Users) request.getSession().getAttribute("user")).getRole()%>"); 
        })
        </script>

        <div id="navbar-container"></div>
        <h1>Personal Information</h1>
        <form method ="post" action="/ProjectHealth/PersonalInfo?mode=3">
            <table width="900" cellpadding="10" style="float:left">
                <tr>
                    <td>First Name:</td>
                    <td><input type = "text" id="FirstName" name ="FirstName" value = "<%=FirstName%>" disabled></input></td>
                    <input type = "hidden" id="FirstName" name ="FirstName" value = "<%=FirstName%>" ></input>
                    <td>Phone Number:<br>(000-000-0000)</td>
                    <td><input type = "tel" type = "tel" id="PhoneNumber" name ="PhoneNumber"  pattern='<%=PhoneNumberRegex%>' value = "<%=PhoneNumber%>" <%=disabled%>></input></td>
                </tr>
                <tr>
                    <td>Last Name:</td>
                    <td><input type = "text" id="LastName" name ="LastName" value = "<%=LastName%>" disabled></input></td>
                    <input type = "hidden" id="LastName" name ="LastName" value = "<%=LastName%>" ></input>
                    <td>Contact Phone Number:<br>(000-000-0000)</td>
                    <td><input type = "tel"  id="PrimaryContactNo" name ="PrimaryContactNo" pattern='<%=PhoneNumberRegex%>' value = "<%=PrimaryContactNo%>" <%=disabled%>></input></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><input type = "text" id="Address" name="Address" value = "<%=Address%>" <%=disabled%>></input></td>
                    <td>Health Card Number:</td>
                    <td><input type = "text" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>" disabled></input></td>
                    <input type = "hidden" id="HealthCardNumber" name ="HealthCardNumber" value = "<%=HealthCardNumber%>"></input>
                </tr>
                <tr>
                    <td>City:</td>
                    <td><input type = "text" id="City" name ="City" value = "<%=City%>" <%=disabled%>></input></td>
                    <td>SIN</td>
                    <td><input type = "text" id="SIN" name ="SIN" value = "<%=SIN%>" disabled></input></td>
                    <input type = "hidden" id="SIN" name ="SIN" value = "<%=SIN%>" ></input>
                </tr>
                <tr>
                    <td>Province:</td>
                    <td>
                    <select id="Province" name ="Province" <%=disabled%>>
                        <%for(Province c : Provinces)
                            {
                                String s = c.getCode();
                                if(s.equals(Province)){%>
                                 <option value="<%=s%>" selected><%=s%></option>
                            <%}
                                else{%>
                                 <option value="<%=s%>"><%=s%></option>  
                                <%}
                            }%>
                    </select>
                    </td>
                    <td>Doctor:</td>
                    <td><input type = "text" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" disabled></input></td>
                    <input type = "hidden" id="DefaultDoctorID" name ="DefaultDoctorID" value = "<%=DefaultDoctorID%>" ></input>
                </tr>
                <tr>
                    <td>Postal Code:<br>(A0A 0A0)</td>
                    <td><input type = "tel" pattern="<%=PostalCodeRegex%>"  id="PostalCode" name ="PostalCode"  value = "<%=PostalCode%>" <%=disabled%>></input></td>
                    <td>Health Status:</td>
                    <td><input type = "text" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" disabled></input></td>
                    <input type = "hidden" id="HealthStatus" name ="HealthStatus" value = "<%=HealthStatus%>" ></input>
      
                </tr>
                <tr>
                    <td>Country:</td>
                    <td>
                    <select id="Country" name ="Country" <%=disabled%>>
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
            <% if(errors != null && errors.size() != 0){ %>
            <h3>Try Again</h3>
                    <ul>
                    <% Collection<String> entries = errors.values();
                       Iterator it = entries.iterator();
                       String s;
                       while(it.hasNext())
                       {
                            s = (String)it.next();%>
                       <li><%=s%></li>
                       <%}
            
        }%>
                    </ul>
            <div style="clear:both"></div>
        </form>
                
    </body>

</html>
