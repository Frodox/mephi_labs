package com.bitthinker;

public class TestRomanNumber {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("=== Starting Roman Number Testing ===");
	
		try {
			RomanNumber x = new RomanNumber("V");
			RomanNumber y = new RomanNumber(20);
			RomanNumber z = new RomanNumber("VIII");

			System.out.println("number is " + x.toString() + " (" + x.toInt() + ")");
			System.out.println("number is " + y.toString() + " (" + y.toInt() + ")");
			System.out.println("number is " + z.toString() + " (" + z.toInt() + ")");
			
		}
		catch(Exception e) {
				System.err.println(e.getMessage());
		}
	

	
	
	}

}
