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
 * @lab_num 3
 * @date 2013/11/17
 * @task: ...
 */
public class Lab3 {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {

	
		String buf = null;
		int number = 0;
		
		System.out.print("Enter a positive number number greater then zero: ");
		
		BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
		buf = bufferRead.readLine();
		
		try {
			// convert to Number
			number = Integer.parseInt(buf);
					
			if (number <= 0 ) {
				throw new NumberFormatException("Your number is bad. Try again!");
			}
		
		} catch(NumberFormatException nfe){
			System.err.println(nfe.getMessage());
			System.err.println("Oops! Please, try again :)");
			System.exit(-1);
		}

		
		
	}
}
