/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    $("#logout").click(function(){
        window.location = "/ProjectHealth/index.jsp";
    });
});

function getNavbar(role, firstname, lastname) {
    var patientNav = [];
        patientNav[0] = "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='main.jsp'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='PersonalInfo?mode=1'>Personal Information</a></li>" +
                    "<li class='dropdown'>" +
                        "<a href='#' class='dropdown-toggle' data-toggle='dropdown'> Records <b class='caret'></b></a>" +
                        "<ul class='dropdown-menu'>" +
                            "<li><a href='AppointmentServlet'>Appointments</a></li>" +
                            "<li><a href='ScheduledOperations'>Operations</a></li>" +
                            "<li><a href='PrescriptionsServlet'>Prescriptions</a></li>" +
                        "</ul>" +
                    "</li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li class='dropdown'>" +
                            "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>";
           patientNav[1] = "<b class='caret'></b></a>" +
                            "<ul class='dropdown-menu'>" +
                                "<li><a id='logout' href='LoginServlet?mode=logout'>Logout</a></li>" +
                            "</ul>" +
                        "</li>" +
                "</ul>" +
            "</div>" +
        "</nav>";
        

    var doctorNav =[];
        doctorNav[0] = "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='main.jsp'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='PatientLookup?mode=1'>Patient Lookup</a></li>" +
                     "<li class='dropdown'>" +
                        "<a href='#' class='dropdown-toggle' data-toggle='dropdown'> Patient Records <b class='caret'></b></a>" +
                        "<ul class='dropdown-menu'>" +
                            "<li><a href='AppointmentServlet'>Appointments</a></li>" +
                            "<li><a href='ScheduledOperations'>Operations</a></li>" +
                            "<li><a href='PrescriptionsServlet'>Prescriptions</a></li>" +
                        "</ul>" +
                    "</li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                        "<li class='dropdown'>" +
                            "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>";
        doctorNav[1] = "<b class='caret'></b></a>" +
                            "<ul class='dropdown-menu'>" +
                                "<li><a id='logout' href='LoginServlet?mode=logout'>Logout</a></li>" +
                            "</ul>" +
                        "</li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var staffNav = [];
        staffNav[0] = "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='main.jsp'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='PatientLookup?mode=1'>Patient Lookup</a></li>" +
                     "<li class='dropdown'>" +
                        "<a href='#' class='dropdown-toggle' data-toggle='dropdown'> Patient Records <b class='caret'></b></a>" +
                        "<ul class='dropdown-menu'>" +
                            "<li><a href='AppointmentServlet'>Appointments</a></li>" +
                            "<li><a href='ScheduledOperations'>Operations</a></li>" +
                            "<li><a href='PrescriptionsServlet'>Prescriptions</a></li>" +
                        "</ul>" +
                    "</li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                        "<li class='dropdown'>" +
                            "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>";
         staffNav[1] = "<b class='caret'></b></a>" +
                            "<ul class='dropdown-menu'>" +
                                "<li><a id='logout' href='LoginServlet?mode=logout'>Logout</a></li>" +
                            "</ul>" +
                        "</li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var financeNav = [];
        financeNav[0] = "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='main.jsp'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='DoctorLookupServlet?mode=1'>Doctor Lookup</a></li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li class='dropdown'>" +
                            "<a href='#' class='dropdown-toggle' data-toggle='dropdown'>";
         financeNav[1] = "<b class='caret'></b></a>" +
                            "<ul class='dropdown-menu'>" +
                                "<li><a id='logout' href='LoginServlet?mode=logout'>Logout</a></li>" +
                            "</ul>" +
                        "</li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var appendNav;
    if (role === "patient") {
        appendNav = patientNav[0].concat(firstname, " ", lastname, patientNav[1]);
    } else if (role === "doctor") {
        appendNav = doctorNav[0].concat(firstname, " ", lastname, doctorNav[1]);
    } else if (role === "staff") {
        appendNav = staffNav[0].concat(firstname, " ", lastname, staffNav[1]);
    } else if (role === "finance") {
        appendNav = financeNav[0].concat(firstname, " ", lastname, financeNav[1]);
    }

    $("#navbar-container").append(
        appendNav
    );
}

