/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function() {
   $("#modal-user-fired").bootstrapSwitch();
   $("#modal-user-managing-doctor").select2();
   $("#user-id").select2();
});

function validate() {
    var password = $("#password").text().trim();
    var passwordRpt = $("#confirm-password").text().trim();
    return password == passwordRpt;
}

function addUser() {
    $("#user-submit-form").attr("action", "AdminServlet?action=AddStaff");
    $("#modal-user-id").val("");
    $("#modal-user-fname").val("");
    $("#modal-user-lname").val("");
    $("#modal-user-jtitle").val("");
    $("#modal-user-managing-doctor").select2("val", "");
    $('#modal-user-fired').bootstrapSwitch('state', true);
    $("#userUpdate").modal("show");
}
function loadStaffInfo(index) {
    $("#user-submit-form").attr("action", "AdminServlet?action=UpdateStaff");
    $("#modal-user-id").val($("#staff-info-" + index + " .user-id").text().trim()).attr("readonly", true);
    $("#modal-user-fname").val($("#staff-info-" + index + " .first-name").text().trim()).attr("readonly", true);
    $("#modal-user-lname").val($("#staff-info-" + index + " .last-name").text().trim()).attr("readonly", true);
    $("#modal-user-jtitle").val($("#staff-info-" + index + " .job-title").text().trim());
    $("#modal-user-managing-doctor").select2("val", $("#staff-info-" + index + " .managing-doctor").text().trim());
    $('#modal-user-fired').bootstrapSwitch('state', ($("#staff-info-" + index + " .currently-employed").text().trim()) == "true");
    $("#userUpdate").modal("show");
}