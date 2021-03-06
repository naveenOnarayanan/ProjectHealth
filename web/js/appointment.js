/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function() {
    var removedDrugOptions = [];
    $('#appointment-modal-date').datetimepicker({
        language: 'en',
        useCurrent: true,
        minDate: new Date().toLocaleDateString()
    });
    $('#appointment-modal-length').datetimepicker({
        pickDate: false,
        useSeconds: false,
        language: 'ru',
        defaultDate: '1/1/1900 00:00',
        minuteStepping: 5
    });
    
    $('#appointment-modal-expiry').datetimepicker({
        language: 'en',
        useCurrent: true
    });
    
    $('#appointment-modal-operationTime').datetimepicker({
        language: 'en',
        useCurrent: true
    });

    $("#appointment-modal-add-prescription").click(function() {
       $("#appointment-modal-prescriptions").select2("readonly", false);
       return false;
    });

    $(".appointment-modal-container").css("max-height", $(window).height() - 220);
    $("#remoteContent .modal-content").css("max-height", $(window).height() - 120);

    $("#appointment-modal-apptComplete").bootstrapSwitch();
    $("#appointment-modal-apptComplete").bootstrapSwitch('onText', 'Yes');
    $("#appointment-modal-apptComplete").bootstrapSwitch('offText', 'No');
    $("#appointment-modal-apptCancelled").bootstrapSwitch();
    $("#appointment-modal-apptCancelled").bootstrapSwitch('onText', 'Yes');
    $("#appointment-modal-apptCancelled").bootstrapSwitch('offText', 'No');
    
    $("#remoteContent").on('hidden.bs.modal', function() {
        $(this).removeData('bs.modal');
    });
    
    $(".reset").click(function() {
       $(".search").val("");
       $('#past-appointments').trigger('search', false); 
       $('#upcoming-appointments').trigger('search', false); 
    });
    
    $("#past-appointments").tablesorter({
        theme: "ice",
        widgets: ["filter"],
        dateFormat: "MM/dd/yyyy hh:mm aa",
        widgetOptions: {
            filter_external : '.search',
            filter_columnFilters: false,
            filter_saveFilters : false,
        },
        headers: {
            1:{sorter:"dateFormat"},
            6:{sorter: false},
            7:{sorter: false}
        }
    }).tablesorterPager({
        container: $("#past-pager"),
        cssGoto: ".pagenum",
        output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
    });
    
    $("#upcoming-appointments").tablesorter({
        theme: "ice",
        widgets: ["filter"],
        widgetOptions: {
            filter_external : '.search',
            filter_columnFilters: false,
            filter_saveFilters : false,
        },
        headers: {
            1:{sorter:"dateFormat"},
            6:{sorter: false},
            7:{sorter: false}
        }
    }).tablesorterPager({
        container: $("#upcoming-pager"),
        cssGoto: ".pagenum",
        output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
    });
    
    $('#appointment-modal-date').data("DateTimePicker").getDate();

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
    
    $('#appointment-edit').on('hidden.bs.modal', function () {
        $("#appointment-modal-date").val("");
        $("#appointment-modal-patientID").select2("val", "");
        $("#appointment-modal-doctorID").select2("val", "");
        $("#appointment-modal-symptoms").text("");
        $("#appointment-modal-diagnosis").text("");
        $("#appointment-modal-type").val("");
        $("#appointment-modal-length").val("");
        $("#appointment-modal-comments").val("");
        $("#appointment-modal-date input").val("");
        $("#appointment-modal-length input").val("");
        $("#appointment-modal-prescriptions").val("");
        $("#appointment-modal-operations").val("");

        $("#operations-tab").removeClass("active");
        $("#prescriptions-tab").removeClass("active");
        $("#operations").removeClass("active");
        $("#prescriptions").removeClass("active");

        $("#info").addClass("active");
        $("#info-tab").addClass("active");

        for (var i = 0; i < removedDrugOptions.length; i++) {
            $("#appointment-modal-drugs").append("<option value='" + removedDrugOptions[i].id + "'>" + removedDrugOptions[i].text + "</option>");
        }
        $("#appointment-modal-drugs").select2();
        removedDrugOptions = [];
        $(".drugs-prescribed").remove();
        $("#appointment-modal-drugs").select2("val", "");
    });
    
    $("#appointment-modal-doctorID").select2();
    $("#appointment-modal-patientID").select2();
    $("#appointment-modal-operationName").select2();
    $("#appointment-modal-operationDoctor").select2();
    $("#appointment-modal-operationName").select2("val", "");
    $("#appointment-modal-operationDoctor").select2("val", "");
    $("#appointment-modal-drugs").select2();
    $("#appointment-modal-drugs").select2("val", "");

    $("#add-drug").click(function() {
        var din = $("#appointment-modal-drugs").val();
        var tradeName = $("#appointment-modal-drugs").select2('data').text;
        var quantity = $("#appointment-modal-quantity").val();
        var refills = $("#appointment-modal-refills").val();
        var dosage = $("#appointment-modal-dosage").val();
        var expiry = $("#appointment-modal-expiry input").val();
        var inputString = din + "|" + quantity + "|" + refills + "|" + dosage + "|" + expiry;

        removedDrugOptions.push({
            id: din.toString(),
            text: tradeName
        });

        $("#appointment-modal-quantity").val("");
        $("#appointment-modal-quantity").val("");
        $("#appointment-modal-refills").val("");
        $("#appointment-modal-dosage").val("");
        $("#appointment-modal-expiry").val("");

        $("#appointment-modal-drugs option[value='" + din + "']").remove();
        $("#appointment-modal-drugs").select2();
        $("#appointment-modal-drugs").select2("val", "");

        $("#appointment-modal-prescription-table").append("<tr class='drugs-prescribed'>" +
                "<td>" + din + "</td>" +
                "<td>" + tradeName + "</td>" +
                "<td>" + quantity + "</td>" +
                "<td>" + refills + "</td>" +
                "<td>" + dosage + "</td>" +
                "<td>" + expiry + "</td>" +
                "<td><button data-din='" + din + "' class='btn btn-default btn-xs delete-drug'><i class='fa fa-minus-circle'></i></button></td></tr>"
         );
         var prevValue = $("#appointment-modal-prescriptions").val();
         $("#appointment-modal-prescriptions").val(((prevValue == "") ? prevValue : prevValue + ";") + inputString);
         $(".delete-drug").off().on("click", function() {
             var input = $("#appointment-modal-prescriptions").val().split(";");
             var btnDin = $(this).attr("data-din");
             for (var i = 0; i < input.length; i++) {
                 if (input[i].indexOf(btnDin) == 0) {
                     input.splice(i, 1);
                     break;
                 }
             }

             $("#appointment-modal-prescriptions").val(input.toString().replace(/,/g, ";"));
           
             for (var i = 0; i < removedDrugOptions.length; i++) {
                 $("#appointment-modal-drugs").append("<option value='" + removedDrugOptions[i].id + "'>" + removedDrugOptions[i].text + "</option>");
             }

             removedDrugOptions = [];

             $(this).parent().parent().remove();
         });
         return false;
    });
    
    $("#add-operations").click(function() {
        var operationDates = [];
        $(".appointment-operations-data").each(function(index) {
           var operationStr = $(this).text().trim().split("|");
           var times = operationStr[3].split(":");
           var setDate = new Date(operationStr[0]);
           var endDate = new Date(setDate.toString());
           endDate.setHours(endDate.getHours() + parseInt(times[0]));
           endDate.setMinutes(endDate.getMinutes() + parseInt(times[1]));
           operationDates.push({
               id: $(this).parent().parent().parent().attr("data-id"),
               doctor: operationStr[2],
               startDate: setDate,
               endDate: endDate
           });
        });

        for (var i = 0; i < operationDates.length; i++) {
            var setDateStr = $("#appointment-modal-operationTime").data("DateTimePicker").getDate();
            var setDate = new Date(setDateStr.toString());
            var endSetDate = new Date(setDate.toString());
            var length = $("#appointment-modal-operationName").find(":selected").attr("data-length").split(":");
            endSetDate.setHours(endSetDate.getHours() + parseInt(length[0]));
            endSetDate.setMinutes(endSetDate.getMinutes() + parseInt(length[0]));
            var doctor = $("#appointment-modal-operationDoctor").val();

            if ($("#appointment-modal-visitID").val() != operationDates[i].id && doctor == operationDates[i].doctor && setDate >= operationDates[i].startDate && setDate <= operationDates[i].endDate) {
                $("#form-valiation-error").text("Schedule conflict! The start time is in conflict with Appointment #" + operationDates[i].id).removeClass("hidden");
                return false;
            } else if ($("#appointment-modal-visitID").val() != operationDates[i].id && doctor == operationDates[i].doctor && endSetDate >= operationDates[i].startDate && endSetDate <= operationDates[i].endDate) {
                $("#form-valiation-error").text("Schedule conflict! The length is in conflict with Appointment #" + operationDates[i].id).removeClass("hidden");
                return false;
            } else {
                $("#form-valiation-error").addClass("hidden");
            }
        }

        var operationTime = $("#appointment-modal-operationTime input").val();
        var operationName = $("#appointment-modal-operationName").val();
        var operationDoctor = $("#appointment-modal-operationDoctor").val();
        var inputString = operationTime + "|" + operationName + "|" + operationDoctor;

        $("#appointment-modal-operationTime input").val("");
        $("#appointment-modal-operationName").select2("val", "");
        $("#appointment-modal-operationDoctor").select2("val", "");

        $("#appointment-modal-operations-table").append("<tr class='operations-scheduled'>" +
                "<td>" + operationTime + "</td>" +
                "<td>" + operationName + "</td>" +
                "<td>" + operationDoctor + "</td>" +
                "<td><button data-operation-name='" + operationName + "' class='btn btn-default btn-xs delete-operation'><i class='fa fa-minus-circle'></i></button></td></tr>"
         );

         var prevValue = $("#appointment-modal-operations").val();
         $("#appointment-modal-operations").val(((prevValue == "") ? prevValue : prevValue + ";") + inputString);

         $(".delete-operation").off().on("click", function() {
             var input = $("#appointment-modal-operations").val().split(";");
             var btnId = $(this).attr("data-operation-name");
             for (var i = 0; i < input.length; i++) {
                 if (input[i].indexOf(btnId) != -1) {
                     input.splice(i, 1);
                     break;
                 }
             }

             $("#appointment-modal-operations").val(input.toString().replace(/,/g, ";"));


             $(this).parent().parent().remove();
         });
         
         return false;
    });
    
    $("#appointment-modal-operationName").change(function() {
        $(".operation-doctor-select").remove();
        $("#appointment-modal-operationDoctor").select2("val", "");
        var reqTitle = $("#" + $(this).val().replace(/ /g, '')).attr("data-value");
        var allStaff = JSON.parse($(".info-container-hidden").attr("data-staff"));
        for (var i = 0; i < allStaff.length; i++) {
            if (allStaff[i][3] == reqTitle) {
                $("#appointment-modal-operationDoctor").append("<option class='operation-doctor-select' value='" + allStaff[i][0] + "'>" + allStaff[i][1] + " " + allStaff[i][2] + "</option>");
            }
        }
    });
});

function validate() {
    var dates = [];
    $(".appointment-date").each(function(index) {
        dates.push({
            id: $(this).parent().attr("data-id"),
            doctor: $(this).parent().children(".appointment-doctor").attr("data-id"),
            startDate: Date.parse($(this).text().trim())
        });
    });
    $(".appointment-length").each(function(index) {
        var times = $(this).text().split(":");
        var endDate = new Date(dates[index].startDate);
        endDate.setHours(endDate.getHours() + parseInt(times[0]));
        endDate.setMinutes(endDate.getMinutes() + parseInt(times[1]));
        dates[index].endDate = Date.parse(endDate.toString());
    });
    
    for (var i = 0; i < dates.length; i++) {
       var length = $("#appointment-modal-length").data("DateTimePicker").getDate();
       var lengthDate = new Date(Date.parse(length.toString()));
       var setDate = $("#appointment-modal-date").data("DateTimePicker").getDate();
       var endSetDate = new Date(Date.parse(setDate.toString()));
       endSetDate.setHours(endSetDate.getHours() + lengthDate.getHours());
       endSetDate.setMinutes(endSetDate.getMinutes() + lengthDate.getMinutes());
       var doctorID = $("#appointment-modal-doctorID").val();
       $("#appointment-modal-doctorID").val();
       if (doctorID == dates[i].doctor && dates[i].id != $("#appointment-modal-visitID").val() &&  setDate >= new Date(dates[i].startDate) && setDate <= new Date(dates[i].endDate)) {
           $("#form-valiation-error").text("Schedule conflict! The start time is in conflict with Appointment #" + dates[i].id).removeClass("hidden");
           return false;
       } else if (doctorID == dates[i].doctor && dates[i].id != $("#appointment-modal-visitID").val() && endSetDate >= new Date(dates[i].startDate) && endSetDate <= new Date(dates[i].endDate)) {
           $("#form-valiation-error").text("Schedule conflict! The length is in conflict with Appointment #" + dates[i].id).removeClass("hidden");
           return false;
       }
    }

    return true;
}


function updateAppointmentModal(index, role, appointment) {
    if (index >= 0) {
        $("#appointment-modal-form").attr("action", "AppointmentServlet?action=update");
    } else {
        $("#appointment-modal-form").attr("action", "AppointmentServlet?action=insert");
    }
    if (role == "staff") {
        if (index >= 0) {
            $("#appointment-modal-doctorID").select2("readonly", true);
            
            var appointmentComplete = $("#" + appointment + "-appointment-" + index).attr("data-complete");
            if (appointmentComplete == "true") {
                $("#appointment-modal-apptComplete").attr("checked", "true");
                $("#appointment-modal-apptComplete").bootstrapSwitch('state', true);
            } else {
                $("#appointment-modal-apptComplete").bootstrapSwitch('state', false);
            }

            $("#appointment-modal-visitID").val($("#" + appointment + "-appointment-" + index).attr("data-id"));
            $("#appointment-modal-date").data("DateTimePicker").setDate($("#" + appointment + "-appointment-" + index + " .appointment-date").text().trim());

            var patientPicker = $("#appointment-modal-patientID #" + $("#" + appointment + "-appointment-" + index + " .appointment-patient").attr("data-id"));
            patientPicker.attr("selected", true);
            patientPicker.change();

            var doctorPicker = $("#appointment-modal-doctorID #" + $("#" + appointment + "-appointment-" + index + " .appointment-doctor").attr("data-id"));
            doctorPicker.attr("selected", true);
            doctorPicker.change();

            $("#appointment-modal-symptoms").text($("#" + appointment + "-appointment-" + index + " .appointment-symptoms").text().trim());
            $("#appointment-modal-diagnosis").text($("#" + appointment + "-appointment-" + index + " .appointment-diagnosis").text().trim());
            $("#appointment-modal-type").val($("#" + appointment + "-appointment-" + index + " .appointment-type").text().trim());
            $("#appointment-modal-length").data("DateTimePicker").setDate("1/1/2013 " + $("#" + appointment + "-appointment-" + index + " .appointment-length").text().trim());
            
            $("#appointment-modal-prescriptions").select2("readonly", false);
            $("#appointment-modal-comments").val($("#" + appointment + "-appointment-" + index + " .appointment-comments").text().trim());
        } else {
            $("#appointment-modal-doctorID").select2("readonly", false);
        }
    } else if (role == "doctor") {
        if (index >= 0) {
            if ($("#" + appointment + "-appointment-" + index + " .appointment-operations center .appointment-operations-data").length != 0) {
//                var data = $("#" + appointment + "-appointment-" + index + " .appointment-operations center .appointment-operations-data");
//                $("#appointment-modal-operations").val("");
//                data.each(function(index) {
//                   var entry = $(this).text().trim().split("|");
//                   var date = new Date(entry[0]).toLocaleString().replace(/:\d{2}\s/,' ');
//                   var name = entry[1];
//                   var doctor = entry[2];
//                   $("#appointment-modal-operations").val($("#appointment-modal-operations").val() + date + "|" + name + "|" + doctor + ";");
//
//                   $("#appointment-modal-operations-table").append("<tr class='operations-scheduled'>" +
//                            "<td>" + date + "</td>" +
//                            "<td>" + name + "</td>" +
//                            "<td>" + doctor + "</td>" +
//                            "<td><button data-operation-name='" + name + "' class='btn btn-default btn-xs delete-operation'><i class='fa fa-minus-circle'></i></button></td></tr>"
//                   );
//                });
                $("#operations-tab").hide();
            } else {
                $("#operations-tab").show();
            }
            if ($("#" + appointment + "-appointment-" + index + " .appointment-prescriptions center a").length != 0) {
                $("#prescriptions-tab").hide();
            } else {
                $("#prescriptions-tab").show();
            }
            
            var appointmentComplete = $("#" + appointment + "-appointment-" + index).attr("data-complete");
            if (appointmentComplete == "true") {
                $("#appointment-modal-apptComplete").attr("readonly", "false");
                $("#appointment-modal-apptComplete").bootstrapSwitch('state', true);

            } else {
                $("#appointment-modal-apptComplete").bootstrapSwitch('state', false);
            }

            $("#appointment-modal-visitID").val($("#" + appointment + "-appointment-" + index).attr("data-id"));
            $("#appointment-modal-date").data("DateTimePicker").setDate($("#" + appointment + "-appointment-" + index + " .appointment-date").text().trim());

            var patientPicker = $("#appointment-modal-patientID #" + $("#" + appointment + "-appointment-" + index + " .appointment-patient").attr("data-id"));
            patientPicker.attr("selected", true);
            patientPicker.change();

            var doctorPicker = $("#appointment-modal-doctorID #" + $("#" + appointment + "-appointment-" + index + " .appointment-doctor").attr("data-id"));
            doctorPicker.attr("selected", true);
            doctorPicker.change();

            $("#appointment-modal-symptoms").text($("#" + appointment + "-appointment-" + index + " .appointment-symptoms").text().trim());
            $("#appointment-modal-diagnosis").text($("#" + appointment + "-appointment-" + index + " .appointment-diagnosis").text().trim());
            $("#appointment-modal-type").val($("#" + appointment + "-appointment-" + index + " .appointment-type").text().trim());
            $("#appointment-modal-length").data("DateTimePicker").setDate("1/1/2013 " + $("#" + appointment + "-appointment-" + index + " .appointment-length").text().trim());
            
            $("#appointment-modal-prescriptions").select2("readonly", false);
            $("#appointment-modal-comments").val($("#" + appointment + "-appointment-" + index + " .appointment-comments").text().trim());

            $("#appointment-modal-date input").attr("readonly", true);
            $("#appointment-modal-date").css("width", "100%");
            $("#appointment-modal-length input").attr("readonly", true);
            $("#appointment-modal-length .input-group-addon").remove();
            $("#appointment-modal-length").css("width", "100%");
            $("#appointment-modal-date .input-group-addon").remove();
            $("#appointment-modal-patientID").select2("readonly", true);
            $("#appointment-modal-doctorID").select2("readonly", true);
            $("#appointment-modal-prescriptions").attr("readonly", true);
        }
    }
    $('#appointment-edit').modal('show'); 
}
