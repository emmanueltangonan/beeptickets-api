package com.beepevents.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;

import com.beepevents.model.Client;


public class Validator {
	public void validateEmail(Client	client, Errors errors) {
		if(client.getEmail() != null){
			Pattern pattern = Pattern.compile("[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$");
			Matcher matcher = pattern.matcher(client.getEmail());
			if(!matcher.matches()){
				errors.rejectValue("email","invalid.email", "Please enter a valid email.");
			}
		}
		
	}
	
	
}
