/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function populateOperationModal(Name, Desc, EstTimeHour, EstTimeMin)
{
    document.getElementById("operations-modal-title").textContent = Name;
    document.getElementById("operation-modal-body-description").textContent = Desc;
    document.getElementById("operation-modal-body-esttime-hour").value = EstTimeHour;
    document.getElementById("operation-modal-body-esttime-hour").value = EstTimeHour;
    $('#operation-modal').modal('show');
}
