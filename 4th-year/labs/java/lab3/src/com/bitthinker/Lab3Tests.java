/**
 * 
 */
package com.bitthinker;

/**
 * @author Vitaly
 *
 */
public class Lab3Tests {

	private static String intArray2String(int[] a)
	{
		return intArray2String(a, ":");
	}
	
	private static String intArray2String(int[] a, String delimeter)
	{
		if (null == a) { return "null"; }
		StringBuilder result =  new StringBuilder("");

		for (int i = 0; i < a.length; i++) {
			result.append(Integer.toString(a[i]) + delimeter);
		}
		return result.toString();
	}


	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("== Start Tests ==");
		
		int[] res = null;
		int[] testA = null;
		int[] nullArray = null;
		int[] one23Array = new int[] {1, 0, 1, 2, 3};
		
		/****** Int2Array ***
		 **********************************************************************/
		System.out.println("= Int2Array =");
		for (int i = -5; i < 15; i++)
		{
			int[] tmp = Lab3.Int2Array(i);
			System.out.format("| %d \t| %s\n", i, intArray2String(tmp));
		}
		/**********************************************************************/
		

		
		/****** CalculatePlusMinusSum ***
		 **********************************************************************/
		System.out.println("\n\n= CalculatePlusMinusSum =");
		testA = new int[] {1, 2, 3};
		System.out.format("%s \t+/- %d\n", intArray2String(testA),
				Lab3.calculatePlusMinusSumOfIntArray(testA));

		testA = null;
		System.out.format("%s \t+/- %d\n", intArray2String(testA),
				Lab3.calculatePlusMinusSumOfIntArray(testA));
		
		testA = new int[] {1, -2, 30, 40, 1000001};
		System.out.format("%s \t+/- %d\n", intArray2String(testA),
				Lab3.calculatePlusMinusSumOfIntArray(testA));		
		/**********************************************************************/

		

		/****** getArrayWithMaxPlusMinusSum ***
		 **********************************************************************/
		System.out.println("\n\n\n= getArrayWithMaxPlusMinusSum =\n");

		
		/* ------+------ */
		System.out.format("%s \t -> %s\n"
						 , intArray2String(nullArray)
						 , intArray2String(res = Lab3.getArrayWithMaxPlusMinusSum(nullArray))
						 );
		System.out.format("+/- sum before: %d, after: %d"
						, Lab3.calculatePlusMinusSumOfIntArray(nullArray)
						, Lab3.calculatePlusMinusSumOfIntArray(res)
						);
		System.out.format("\n\n");

		
		/* ------+------ */
		System.out.format("%s \t -> %s\n"
						 , intArray2String(one23Array)
						 , intArray2String(res = Lab3.getArrayWithMaxPlusMinusSum(one23Array))
						 );
		System.out.format("+/- sum before: %d, Max after: %d"
				, Lab3.calculatePlusMinusSumOfIntArray(one23Array)
				, Lab3.calculatePlusMinusSumOfIntArray(res)
				);
		System.out.format("\n\n");
		
		
		/* ------+------ */
		testA = new int[] {1 , 2, 3};
		System.out.format("%s \t -> %s\n"
				 , intArray2String(testA)
				 , intArray2String(res = Lab3.getArrayWithMaxPlusMinusSum(testA))
				 );
		System.out.format("+/- sum before: %d, Max after: %d"
				, Lab3.calculatePlusMinusSumOfIntArray(testA)
				, Lab3.calculatePlusMinusSumOfIntArray(res)
				);
		System.out.format("\n\n");
		
		
		/* ------+------ */
		testA = new int[] {5, 1 , 6 , 0 , 9945, 4 , 55 , 4654, 6574866, 7};
		System.out.format("%s \t -> %s\n"
				 , intArray2String(testA)
				 , intArray2String(res = Lab3.getArrayWithMaxPlusMinusSum(testA))
				 );
		System.out.format("+/- sum before: %d, after: %d"
				, Lab3.calculatePlusMinusSumOfIntArray(testA)
				, Lab3.calculatePlusMinusSumOfIntArray(res)
				);
		System.out.format("\n\n");
		/**********************************************************************/
	}

}


