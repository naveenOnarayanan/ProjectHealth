/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358.utils;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.regex.Pattern;

/**
 *
 * @author Josh
 */
public class PatientValidation {
    public static HttpServletRequest validatePatient(HttpServletRequest request)
    {

        HashMap<String, String> errors = new HashMap<String,String>();
        String FirstName = (String) request.getParameter("FirstName");
        String LastName = (String) request.getParameter("LastName");
        String Address = (String) request.getParameter("Address");
        String PostalCode = (String) request.getParameter("PostalCode");
        String City = (String) request.getParameter("City");
        String Country = (String) request.getParameter("Country");
        String Province = (String) request.getParameter("Province");
        String PhoneNumber = (String) request.getParameter("PhoneNumber");
        String HealthCardNumber = (String) request.getParameter("HealthCardNumber");
        String SIN = (String) request.getParameter("SIN");
        String DefaultDoctorID = (String) request.getParameter("DefaultDoctorID");
        String PrimaryContactNo = (String) request.getParameter("PrimaryContactNo");
        String HealthStatus = (String) request.getParameter("HealthStatus");
        String Email = (String) request.getParameter("Email");
        String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]$";
        String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";
        String EmailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
        String HealthCardRegex = "^([0-9]){4}-([0-9]){3}-([0-9]){3}-([ABCDEFGHIJKLMNOPQRSTUVWXYZ]){2}$";
        String SINRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){3}$";
        //FirstName
        if(FirstName == null || FirstName.isEmpty())
        {
            errors.put("FirstName", "First Name cannot be blank.");
        }
        else
        {
            request.setAttribute("FirstName", FirstName.replace("'", "''"));
        }
        //LastName
        if(LastName == null || LastName.isEmpty())
        {
            errors.put("LastName", "Last Name cannot be blank.");
        }
        else
        {
            request.setAttribute("LastName", LastName.replace("'", "''"));
        }
        //Address
        if(Address == null || Address.isEmpty())
        {
            errors.put("Address", "Address cannot be blank.");
        }
        else
        {
            request.setAttribute("Address", Address.replace("'", "''"));
        }
        //City
        if(City == null || City.isEmpty())
        {
            errors.put("City", "City cannot be blank.");
        }
        else
        {
            request.setAttribute("City", City.replace("'", "''"));
        }
        //Province
        if(Province == null || Province.isEmpty())
        {
            errors.put("Province", "A Province must be selected from the dropdown menu.");
        }
        else
        {
            request.setAttribute("Province", Province.replace("'", "''"));
        }
        //Country
        if(Country == null || Country.isEmpty())
        {
            errors.put("Country", "A Country must be selected from the dropdown menu.");
        }
        else
        {
            request.setAttribute("Country", Country.replace("'", "''"));
        }
        //PostalCode
        if(PostalCode == null || PostalCode.isEmpty())
        {
            errors.put("PostalCode", "Postal Code cannot be blank.");
        }
        else
        {
            request.setAttribute("PostalCode", PostalCode.replace("'", "''"));
        }
        if(PostalCode != null && !Pattern.matches(PostalCodeRegex,PostalCode))
        {
            errors.put("PostalCode", "Please enter a valid Postal Code. (eg. A0A 0A0)");
        }
        //PhoneNumber
        if(PhoneNumber == null || PhoneNumber.isEmpty())
        {
            errors.put("PhoneNumber", "Phone Number cannot be blank.");
        }
        else
        {
            request.setAttribute("PhoneNumber", PhoneNumber.replace("'", "''"));
        }
        if(PhoneNumber != null && !Pattern.matches(PhoneNumberRegex, PhoneNumber))
        {
            errors.put("PhoneNumber", "Please enter a valid Phone Number. (eg. XXX-XXX-XXXX)");
        }
        //Email
        if(Email == null || Email.isEmpty())
        {
            errors.put("Email", "Email Address cannot be blank.");
        }
        else
        {
            request.setAttribute("Email", Email.replace("'", "''"));
        }
        if(Email != null && !Pattern.matches(EmailRegex, Email))
        {
            errors.put("Email", "Please enter a valid Email Address. (eg. name@domain.com)");
        }
        //HealthCardNumber
        if(HealthCardNumber == null || HealthCardNumber.isEmpty())
        {
            errors.put("HealthCardNumber", "Health Card Number cannot be blank.");
        }
        else
        {
            request.setAttribute("HealthCardNumber", HealthCardNumber.replace("'", "''"));
        }
        if(HealthCardNumber != null && !Pattern.matches(HealthCardRegex, HealthCardNumber))
        {
            errors.put("Email", "Please enter a valid Health Card Number. (eg. 0000-000-000-AA)");
        }
        //SIN
        if(SIN == null || SIN.isEmpty())
        {
            errors.put("SIN", "SIN cannot be blank.");
        }
        else
        {
            request.setAttribute("SIN", SIN.replace("'", "''"));
        }
        if(SIN != null && !Pattern.matches(SINRegex, SIN))
        {
            errors.put("SIN", "Please enter a valid SIN. (eg. 000-000-000)");
        }
        //DefaultDoctorID
        if(DefaultDoctorID == null || DefaultDoctorID.isEmpty())
        {
            errors.put("DefaultDoctorID", "Default Doctor ID cannot be blank.");
        }
        else
        {
            request.setAttribute("DefaultDoctorID", DefaultDoctorID.replace("'", "''"));
        }
         //Health Status
        if(DefaultDoctorID == null || DefaultDoctorID.isEmpty())
        {
            errors.put("HealthStatus", "Health Status cannot be blank.");
        }
        else
        {
            request.setAttribute("HealthStatus", HealthStatus.replace("'", "''"));
        }
        //PrimaryContactNo
        if(PrimaryContactNo == null || PrimaryContactNo.isEmpty())
        {
            errors.put("PrimaryContactNo", "Primary Contact Phone Number cannot be blank.");
        }
        else
        {
            request.setAttribute("PrimaryContactNo", PrimaryContactNo.replace("'", "''"));
        }
        if(PrimaryContactNo != null && !Pattern.matches(PhoneNumberRegex, PrimaryContactNo))
        {
            errors.put("PrimaryContactNo", "Please enter a valid Primary Contact Phone Number. (eg. XXX-XXX-XXXX)");
        }
        request.setAttribute("Transfered", request.getParameter("Transfered"));
        String Visits = request.getParameter("Visits");
        request.setAttribute("Visits", Visits);
        request.setAttribute("errors", errors);
        return request;
    }
}
