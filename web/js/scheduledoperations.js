/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() 
            { 
                $("#UpcomingOperationsTable")
                        .tablesorter({
                            widthFixed: true,
                            headerTemplate: '{content} {icon}',
                            widgets: ["uitheme", "filter", "zebra"],
                            dateFormat: "yyyy-mm-dd",
                            headers: {
                                4:{sorter:"shortDate"}
                            }
                        })
                        .tablesorterPager({
                            container: $("#UpcomingPager"),
                            cssGoto: ".pagenum",
                            output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                }); 
                $("#PastOperationsTable")
                        .tablesorter({
                            widthFixed: true,
                            headerTemplate: '{content} {icon}',
                            widgets: ["uitheme", "filter", "zebra"],
                            dateFormat: "yyyy-mm-dd",
                            headers: {
                                4:{sorter:"shortDate"}
                            }
                        })
                        .tablesorterPager({
                            container: $("#PastPager"),
                            cssGoto: ".pagenum",
                            output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
                }); 
                
            }); 
function populateOperationModal(Name, Desc, EstTimeHour, EstTimeMin)
{
    document.getElementById("operations-modal-title").textContent = Name;
    document.getElementById("operation-modal-body-description").textContent = Desc;
    document.getElementById("operation-modal-body-esttime-hour").value = EstTimeHour;
    document.getElementById("operation-modal-body-esttime-hour").value = EstTimeHour;
    $('#operation-modal').modal('show');
}
