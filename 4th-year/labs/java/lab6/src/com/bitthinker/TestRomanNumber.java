package com.bitthinker;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class TestRomanNumber {

	public static void main(String[] args) {

		System.out.println("=== Starting Roman Number Testing ===");
	
		try {
			System.out.format("> ");
			BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
			String buf = bufferRead.readLine();
			String[] parts = buf.split(" ");
			
			if (3 != parts.length) {
				throw new NumberFormatException("String '" + buf + "' has incorrect format");
			}
			
			RomanNumber x = new RomanNumber(parts[0]);
			RomanNumber y = new RomanNumber(parts[2]);
			

			RomanNumber result;
			if (parts[1].equals("+"))
				result = x.summWith(y);
			else if (parts[1].equals("*"))
				result = x.multiplyBy(y);
			else 
				throw new NumberFormatException("Unknown operation : " + parts[1]);


			
			

			System.out.println("1st number is " + x.toString() + " (" + x.toInt() + ")");
			System.out.println("2nd number is " + y.toString() + " (" + y.toInt() + ")");
			System.out.println("result is: " + result.toString() + " (" + result.toInt() + ")");
			System.out.println("" + x.toString() + " " + parts[1] + " " + y.toString() + " = " + result.toString());
		}
		catch(Exception e) {
				System.err.println(e.getMessage());
		}
	}

}
