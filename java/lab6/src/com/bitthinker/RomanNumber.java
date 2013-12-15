/**
 * 
 */
package com.bitthinker;


/**
 * @author Christian
 * lab #2.2
 * task: Написать Java-класс, умеющий суммировать и умножать римские числа.
 *		 Ответ должен также быть римским числом.
		 Переопределить метод toString(),
		 сделать конструктор из строки, задающей число.
 */



public class RomanNumber {


	private static final String digits[/* powers of 10 */][/* digit */] =
		{
			{"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
			{"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"},
			{"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"},
			{"", "M", "MM", "MMM"}
		};

	private int value;

	
	/**
	 * Construct RomanNumber from Integer (@val) representation
	 */
	public RomanNumber(int val) throws Exception
	{
		if (val <= 0 || val > 3999)
			throw new Exception("Value " + val + " cannot be represented as roman number");
		
		this.value = val;
	}

	
	/**
	 * Construct RomanNumber from String (@roman_str) representation
	 */
	public RomanNumber(String roman_str) throws Exception
	{
		this.value = romanToInt(roman_str);
	}

	
	/**
	 * Get integer representation for String's RomanNumber
	 * @param roman
	 * 		RomanNumber in string
	 * @return
	 * 		integer representations
	 * @throws Exception
	 */
	private int romanToInt(String roman) throws Exception {
		if (roman.isEmpty())
			throw new Exception("Uncorrect roman number \"\"");

		int result = 0;
		int pos = 0;
		String big_roman = roman.toUpperCase();

		for (int power = 3, ten_power = 1000; power >= 0; --power, ten_power /= 10)
		{
			for (int digit = digits[power].length - 1; digit >= 0; --digit)
			{
				//System.out.println("ChecK : " + digits[power][digit]);
				
				if (big_roman.startsWith(digits[power][digit], pos))
				{
					result += digit*ten_power;
					pos += digits[power][digit].length();
					break;
				}
			}
		}
		if (pos != big_roman.length())
			throw new Exception("Uncorrect roman number \"" + roman + "\"");
		
		return result;		
	}

	
	/**
	 * Get string representation(Roman) of int (decimal)
	 * @param number
	 * 		Int number to represent
	 * @return
	 * @throws Exception
	 */
	private String intToRoman(int number) throws Exception {

		if (number <= 0 || number > 3999)
			throw new Exception("Value " + number + " cannot be represented as roman number");

		String result = "";
		int power = 0;
		while (number > 0)
		{
			int digit = number%10;
			result = digits[power][digit] + result;

			number /= 10;
			++power;
		}
		return result;	
	}
	
	
	/* Overrided methods */

	public int toInt()
	{
		return this.value;
	}
	
	public String toString()
	{
		try {
			return intToRoman(value);
		}
		catch (Exception e) {
			return "UNREPRESENTABLE";
		}
	}

}
