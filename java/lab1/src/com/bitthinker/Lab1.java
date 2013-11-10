/**
 * 
 */
package com.bitthinker;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @author Cristian
 * @var 20
 * @lab_num 1
 * @date 2013/11/10
 * @task: you have 3 number. Check, if you can constuct a triangle 
 * 		with such parties
 *		 		 
 */
public class Lab1 {


	public static void main(String[] args) throws IOException {
		
		
		/*  Get 3 numbers from console */
		double a = 0;
		double b = 0;
		double c = 0;
		String buf = null;

		/* http://www.mkyong.com/java/how-to-read-input-from-console-java/ */
		System.out.print("Enter 3 number separeted by space: ");
		
	    BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
	    buf = bufferRead.readLine();
	    String[] parts = buf.split(" ");


        try {
        	if (3 != parts.length) {
    	    	throw new NumberFormatException("String '" + buf + "' has incorrect format");
    	    }
        	
        	// convert to Numbers
        	a = Double.parseDouble(parts[0]);
        	b = Double.parseDouble(parts[1]);
        	c = Double.parseDouble(parts[2]);
        	
        	// check for sign
        	if (a <= 0 || b <= 0 || c <= 0) {
        		throw new NumberFormatException("One of numbers you have passed: "
        										+ a + ", " 
        										+ b + ", " 
        										+ c + " is negative or zero!");
			}

        } catch(NumberFormatException nfe){
        	System.err.println(nfe.getMessage());
        	System.err.println("Please, try again :)");
        	System.exit(-1);
        }
        
        if ((a+b) <= c || (a+c) <= b || (b+c) <= a) {
			System.out.println("No, you can't!");
		} else {
			System.out.println("Yes, you can constract such triangle.");
		}

	
		
		
	}
}
