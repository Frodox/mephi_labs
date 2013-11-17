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
		return intArray2String(a, "");
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
		
		/****** Int2Array *****************************************************/
		System.out.println("= Int2Array =");
		for (int i = -5; i < 15; i++)
		{
			int[] tmp = Lab3.Int2Array(i);
			System.out.format("| %d \t| %s\n", i, intArray2String(tmp, " : "));
		}
		/**********************************************************************/
		

		
		/****** CalculatePlusMinusSum *****************************************/
		System.out.println("\n\n= CalculatePlusMinusSum =");
		int[] testA = {1, 2, 3};
		System.out.format("%s \t+/- %d\n", intArray2String(testA),
				Lab3.CalculatePlusMinusSum(testA));

		testA = null;
		System.out.format("%s \t+/- %d\n", intArray2String(testA),
				Lab3.CalculatePlusMinusSum(testA));
		
		testA = new int[] {1, -2, 30, 40, 1000001};
		System.out.format("%s \t+/- %d\n", intArray2String(testA, ":"),
				Lab3.CalculatePlusMinusSum(testA));		
		/**********************************************************************/

	}

}
