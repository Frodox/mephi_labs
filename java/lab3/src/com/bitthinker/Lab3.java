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

	public Lab3() {	}

	/***************************************************************************
	 * Convert Integer into array
	 * @param guess
	 * 		int to convert. Must be positive!
	 * 		Trim sign at the start.
	 * @return 
	 * 		int[] array with numbers in each ceil
	 */
	public static int[] Int2Array(int guess)
	{
		String temp = Integer.toString(guess);
		int tempLength = 0;
		
		// Trim possible sign
		if ('-' == temp.charAt(0) || '+' == temp.charAt(0)) {
			temp = temp.substring(1);
		}
		tempLength = temp.length();
		int intArray[] = new int[tempLength];
		
		for (int i = 0; i < tempLength; i++) {
			intArray[i] = temp.charAt(i) - '0';
		}

		return intArray;
	}

	
	public static int[] excludeElementFromArray(int[] sArray, int item)
	{
		if (null == sArray || sArray.length < 1) {
			return new int[0];
		}

		if (item < 0 || item > sArray.length -1) {
			return sArray;
		}
		
		int[] newArray = new int[sArray.length -1];
		
		for (int i = 0; i < sArray.length; i++) {
			
			if (i < item) {
				newArray[i] = sArray[i];
			}
			else if (i > item) {
				newArray[i-1] = sArray[i];
			}
		}

		return newArray;
	}
	
	
	
	public static int[] getArrayWithMaxPlusMinusSum(int[] sourceArray)
	{
		if (null == sourceArray || sourceArray.length < 1) {
			return new int[0];
		}
		
		int element2ExcludePosition = 0;
		int plusMinusSum = calculatePlusMinusSumOfIntArray(excludeElementFromArray(sourceArray, element2ExcludePosition));

		/* find position of element to exclude by.. brute-force :) */
		for (int i = 0; i < sourceArray.length; i++)
		{
			int[] tmpArray = excludeElementFromArray(sourceArray, i);
			int tmpSum = calculatePlusMinusSumOfIntArray(tmpArray);
			
			if (tmpSum > plusMinusSum) {
				element2ExcludePosition = i;
				plusMinusSum = tmpSum;
			}
			//			sum of such array
			//			System.out.format("%d ", tmpSum);
		}

		/*
		System.out.format("\nRemove element: %s,  on position: %d\n" 
						, sourceArray[element2ExcludePosition]
						, element2ExcludePosition
						);
		*/

		return excludeElementFromArray(sourceArray, element2ExcludePosition);
	}
	
	
	/***************************************************************************
	 * Calculate plus-Minus sum of given array of int-numbers.
	 * i.e. for {1, 5, 9, 55} -> + 1 - 5 + 9 - 55
	 * @param intArray
	 * 		array with positive int-numbers
	 * @return
	 * 		plus-minus sum of array @intArray
	 */
	public static int calculatePlusMinusSumOfIntArray(int[] intArray)
	{
		int result = 0;
		if (null == intArray) {
			return result;
		}

		for (int i = 0; i < intArray.length; i++) {
			// + - + - ...
			int sign = (0 == i%2) ? 1 : -1;
			result += sign * intArray[i];
		}

		return result;
	}

	
	public static String intArray2String(int[] a, String delimeter)
	{
		if (null == a) { return "null"; }
		StringBuilder result =  new StringBuilder("");

		for (int i = 0; i < a.length; i++) {
			result.append(Integer.toString(a[i]) + delimeter);
		}
		return result.toString();
	}
	
	
	/***************************************************************************
	 * Remove 1 digit, thus "plus minus sum of digit" will be max
	 * @param number
	 * 		number to calculate sum of
	 * @return
	 * 		original int, edited in way of Max plus-minus sum
	 */
	public static String getIntWithMaxPlusMinusSum(int number)
	{
		int[] tmp = Int2Array(number);
		tmp = getArrayWithMaxPlusMinusSum(tmp);
		
		String str = intArray2String(tmp, "");
//		result = calculatePlusMinusSumOfIntArray(tmp);
		
		return str;
	}

	/********************** M A I N ******************************************/
	/**
	 * @throws IOException 
	 */
	public static void main(String args[]) throws IOException {

		String buf = null;
		int number = 0;
		
		System.out.print("Enter a positive integer number number greater then zero: ");
		
		BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
		buf = bufferRead.readLine();
		
		try { // convert to Number
			number = Integer.parseInt(buf);
	
			if (number <= 0 ) {
				throw new NumberFormatException("Your number is bad. Try again!");
			}
		}
		catch(NumberFormatException nfe) {
			System.err.println(nfe.getMessage());
			System.err.println("Oops! Please, try again :)");
			System.exit(-1);
		}

		System.out.println("You entered: " + number);
		System.out.println("New one: " + getIntWithMaxPlusMinusSum(number));

		
		
	}
}
