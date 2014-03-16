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

function getNavbar(role) {
    var patientNav =
        "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='#'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='#'>Personal Information</a></li>" +
                    "<li class='dropdown'>" +
                        "<a href='#' class='dropdown-toggle' data-toggle='dropdown'> Records <b class='caret'></b></a>" +
                        "<ul class='dropdown-menu'>" +
                            "<li><a href='#'>Appointments</a></li>" +
                            "<li><a href='#'>Prescriptions</a></li>" +
                            "<li><a href='#'>Diagnosis</a></li>" +
                        "</ul>" +
                    "</li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li><a id='logout' href='#'>Logout</a></li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var doctorNav =
        "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='#'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='#'>Patient Lookup</a></li>" +
                    "<li><a href='#'>Record Lookup</a></li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li><a id='logout' href='#'>Logout</a></li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var staffNav =
        "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='#'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='#'>Appointments</a></li>" +
                    "<li><a href='#'>Patient Records</a></li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li><a id='logout' href='#'>Logout</a></li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var financeNav =
        "<nav class='navbar navbar-default' role='navigation'>" +
            "<div class='navbar-header'>" +
                "<a class='navbar-brand' href='#'><img class='icon-header' src='images/plus-red.png' width='25px' height='25px'>&nbsp;<i>ProjectHealth</i></a>" +
            "</div>" +
            "<div class='project-navbar navbar-collapse collapse navbar-responsive-collapse'>" +
                "<ul class='nav navbar-nav'>" +
                    "<li><a href='#'>Doctor Lookup</a></li>" +
                "</ul>" +
                "<ul class='nav navbar-nav navbar-right'>" +
                    "<li><a id='logout' href='#'>Logout</a></li>" +
                "</ul>" +
            "</div>" +
        "</nav>";

    var appendNav;
    if (role == "patient") {
        appendNav = patientNav;
    } else if (role == "doctor") {
        appendNav = doctorNav;
    } else if (role == "staff") {
        appendNav = staffNav;
    } else if (role == "finance") {
        appendNav = doctorNav;
    }

    $("#navbar-container").append(
        appendNav
    );
}

