/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function addDoctor(selectedDoctor, firstName, lastName, expiry)
{
    var modalList = document.getElementById("sDoctor-modal-list");
    var firstlastname;
    var today = new Date();
    var dd = today.getDate().toString();
    if(dd.length === 1)
        dd = "0" + dd;
    var mm = (today.getMonth()+1).toString();
    if(mm.length === 1)
        mm = "0" + mm;
    var yyyy = today.getFullYear();
    var todayFormatted = yyyy+"-"+mm+"-"+dd;
    if(typeof selectedDoctor === "undefined") 
        selectedDoctor = $("#SecondaryDoctor").select2("val");
    if(typeof firstName === "undefined" || typeof lastName === "undefined")
    {
                firstlastname = $("#SecondaryDoctor").select2("data").text;
        firstName = firstlastname.split(" ")[0];
        lastName = firstlastname.split(" ")[1];
    }
    if(typeof expiry === "undefined")
    {
        expiry = todayFormatted;
    }  
    modalList.innerHTML += "<div id=\"" + selectedDoctor + "Div\" style=\"text-align:center\";\">"+
                            "   <br><input type=\"date\" min=\"" + todayFormatted + "\" id=\""+ selectedDoctor +"InputDT\" value=\"" + expiry + "\"></input>"+
                            "   <input type=\"text\" id=\""+ selectedDoctor +"InputUID\" hidden value=\"" + selectedDoctor + "\"></input>"+
                            "   <input type=\"text\" disabled value=\"" + firstName + " " + lastName + "\"></input>"+
                            "   <button type=\"button\" style=\"margin-left:10px\"onClick=\"removeDoctor('" + selectedDoctor + "','"+ firstName +"','"+ lastName +"')\">&minus;</button>"+
                            "</div>";
    $("#SecondaryDoctor option[value='"+ selectedDoctor +"']").remove();
    $("#SecondaryDoctor").select2("val", $("#SecondaryDoctor").select2("val"));
    if(document.getElementById("SecondaryDoctor").length === 0)
    {
        $("#SecondaryDoctor").select2("disable");
        document.getElementById("addSDoctorButton").disabled = true;
    }
}

function removeDoctor(selectedDoctor, firstName, lastName)
{
    var div = document.getElementById(selectedDoctor + "Div");
    div.parentNode.removeChild(div);
    $("#SecondaryDoctor").append($('<option>', {value:""+selectedDoctor+"", text: ""+firstName + " " + lastName + ""}));
    if(document.getElementById("SecondaryDoctor").length !== 0)
    {
        $("#SecondaryDoctor").select2("enable");
        document.getElementById("addSDoctorButton").disabled = false;
    }
    
}

function populateDoctors(secondaryDoctors, firstNames, lastNames, expiries)
{
    for(var i=0; i<secondaryDoctors.length; i++)
    {
        addDoctor(secondaryDoctors[i], firstNames[i], lastNames[i], expiries[i]);
    }
}

function clearDoctors()
{
    var modalList = document.getElementById("sDoctor-modal-list");
    while(modalList.firstChild)
    {
        modalList.removeChild(modalList.firstChild);
    }
}

function writeDoctors()
{
    var inputs = document.getElementById("sDoctor-modal-list").getElementsByTagName("input");
    var url = "PatientLookup?mode=5";
    var count = 0;
    for (var i = 0, input; input = inputs[i]; i++) {
        if(input.id.indexOf("InputUID") !== -1)
        {
            url = url + "&" + "SecondaryDoctorID" + count + "=" + input.value;
            url = url + "&" + "SecondaryDoctorDT" + count + "=" + document.getElementById(input.id.replace("InputUID","InputDT")).value;
            count++;
        }
    }
    url = url + "&DefaultDoctorID=" + document.getElementById("DefaultDoctorID").value +
                "&PatientUserID=" + document.getElementById("PatientUserID").value;
     console.log(url);
    window.location = url;
}
