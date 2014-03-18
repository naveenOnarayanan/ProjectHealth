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
    public static HashMap<String, String> validatePatient(HttpServletRequest request)
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
        String Email = (String) request.getParameter("Email");
        String PostalCodeRegex = "^[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][ ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]$";
        String PhoneNumberRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){4}$";
        String EmailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
        String HealthCardRegex = "^([0-9]){4}-([0-9]){3}-([0-9]){3}-([ABCDEFGHIJKLMNOPQRSTUVWXYZ]){2}$";
        String SINRegex = "^([0-9]){3}-([0-9]){3}-([0-9]){3}$";
        //FirstName
        if(FirstName == null)
        {
            errors.put("FirstName", "First Name cannot be blank.");
        }
        //LastName
        if(LastName == null)
        {
            errors.put("LastName", "Last Name cannot be blank.");
        }
        //Address
        if(Address == null)
        {
            errors.put("Address", "Address cannot be blank.");
        }
        //City
        if(City == null)
        {
            errors.put("City", "City cannot be blank.");
        }
        //Province
        if(Province == null)
        {
            errors.put("Province", "A Province must be selected from the dropdown menu.");
        }
        //Country
        if(Country == null)
        {
            errors.put("Country", "A Country must be selected from the dropdown menu.");
        }
        //PostalCode
        if(PostalCode == null)
        {
            errors.put("PostalCode", "Postal Code cannot be blank.");
        }
        if(PostalCode != null && !Pattern.matches(PostalCodeRegex,PostalCode))
        {
            errors.put("PostalCode", "Please enter a valid Postal Code. (eg. A0A 0A0)");
        }
        //PhoneNumber
        if(PhoneNumber == null)
        {
            errors.put("PhoneNumber", "Phone Number cannot be blank.");
        }
        if(PhoneNumber != null && !Pattern.matches(PhoneNumberRegex, PhoneNumber))
        {
            errors.put("PhoneNumber", "Please enter a valid Phone Number. (eg. XXX-XXX-XXXX)");
        }
        //Email
        if(Email == null)
        {
            errors.put("Email", "Email Address cannot be blank.");
        }
        if(Email != null && !Pattern.matches(EmailRegex, Email))
        {
            errors.put("Email", "Please enter a valid Email Address. (eg. name@domain.com)");
        }
        //HealthCardNumber
        if(HealthCardNumber == null)
        {
            errors.put("HealthCardNumber", "Health Card Number cannot be blank.");
        }
        if(HealthCardNumber != null && !Pattern.matches(HealthCardRegex, HealthCardNumber))
        {
            errors.put("Email", "Please enter a valid Health Card Number. (eg. 0000-000-000-AA)");
        }
        //SIN
        if(SIN == null)
        {
            errors.put("SIN", "SIN cannot be blank.");
        }
        if(SIN != null && !Pattern.matches(SINRegex, SIN))
        {
            errors.put("SIN", "Please enter a valid SIN. (eg. 000-000-000)");
        }
        //DefaultDoctorID
        if(DefaultDoctorID == null)
        {
            errors.put("DefaultDoctorID", "Default Doctor ID cannot be blank.");
        }
        //PrimaryContactNo
        if(PrimaryContactNo == null)
        {
            errors.put("PrimaryContactNo", "Primary Contact Phone Number cannot be blank.");
        }
        if(PrimaryContactNo != null && !Pattern.matches(PhoneNumberRegex, PrimaryContactNo))
        {
            errors.put("PrimaryContactNo", "Please enter a valid Primary Contact Phone Number. (eg. XXX-XXX-XXXX)");
        }
        return errors;
    }
}
