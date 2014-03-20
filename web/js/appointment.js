/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function() {
    $('#appointment-modal-date').datetimepicker({
        language: 'en',
        useCurrent: true
    });
    $('#appointment-modal-length').datetimepicker({
        pickDate: false,
        useSeconds: false,
        language: 'ru',
        minuteStepping: 5
    });
    $('#appointment-edit').on('hidden.bs.modal', function () {
        $("#appointment-modal-date").val("");
        $("#appointment-modal-patientID").val("");
        $("#appointment-modal-doctorID").val("");
        $("#appointment-modal-symptoms").text("");
        $("#appointment-modal-diagnosis").text("");
        $("#appointment-modal-type").val("");
        $("#appointment-modal-length").val("");
        $("#appointment-modal-comments").val("");
        $("#appointment-modal-date input").val("");
        $("#appointment-modal-length input").val("");
    });
});

function updateAppointmentModal(index) {
    if (index >= 0) {
        $("#appointment-modal-doctorID").attr("readonly", true);

        $("#appointment-modal-visitID").val($("#appointment-" + index).attr("data-id"));
        $("#appointment-modal-date").data("DateTimePicker").setDate($("#appointment-" + index + " .appointment-date").text().trim());
        
        var patientPicker = $("#appointment-modal-patientID #" + $("#appointment-" + index + " .appointment-patient").attr("data-id"));
        patientPicker.attr("selected", true);
        patientPicker.change();

        var doctorPicker = $("#appointment-modal-doctorID #" + $("#appointment-" + index + " .appointment-doctor").attr("data-id"));
        doctorPicker.attr("selected", true);
        doctorPicker.change();

        $("#appointment-modal-symptoms").text($("#appointment-" + index + " .appointment-symptoms").text().trim());
        $("#appointment-modal-diagnosis").text($("#appointment-" + index + " .appointment-diagnosis").text().trim());
        $("#appointment-modal-type").val($("#appointment-" + index + " .appointment-type").text().trim());
        $("#appointment-modal-length").data("DateTimePicker").setDate("1/1/2013 " + $("#appointment-" + index + " .appointment-length").text().trim());
        $("#appointment-modal-comments").val($("#appointment-" + index + " .appointment-comments").text().trim());
    } else {
        $("#appointment-modal-doctorID").attr("disabled", false);
    }
    $('#appointment-edit').modal('show'); 
}
