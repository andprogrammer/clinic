package com.clinic;

public class GlobalFunctions {
	
	public static boolean isValidEmailAddress(String email) {
		return !email.contains(" ") && email.matches(".+@.+\\.[a-z]+");
	}
	public static boolean isValidPesel(String pesel) {
		return (pesel.length()==11);
	}
}
