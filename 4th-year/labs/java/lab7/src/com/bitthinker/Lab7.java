/**
 *
 */
package com.bitthinker;

import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * @author Christian
 * lab #2.3
 * task: Написать программу, позволяющую делить многочлен
 * 		 степени n на многочлен степени m < n с остатком.
 *
 * 		 На входе задаются коэффициенты первый и второй
 * 		 многочлены от x в нормализованном виде.
 * 		 На выходе должно быть выражение вида U = V*K + I
 */

public class Lab7
{

	private static void console(String s) { System.out.println(s); }


	public static void main(String[] args)
	{
		System.out.println("Добро пожаловать в Универсальный делитель полиномов!\n");

		console("Введите коэфиценты для первого полинома");
		console("Через пробел (a0*x^n + a1*x^n-1 + ... + an-1*x + an)");
		Polynome[] polynomes = new Polynome[2];

		for (int i = 0; i < 2; i++) {

			if(i==1)
				console("Введите коэфиценты для второго полинома:");

			double[] argz;
			do {
				String[] tempArgs = getInputLine().trim().split("\\s+");

				argz = getIntegers(tempArgs);
				if (argz == null)
					console("Кажется.. что-то не так. Попробуйте ещё разок.");
			
			} while (argz == null);

			polynomes[i] = new Polynome(argz);
		}


		StringBuilder sb = new StringBuilder();
		sb.append(polynomes[0].toString());
		sb.append(" = \n");
		sb.append("(");
		sb.append(polynomes[1].toString());
		sb.append(") * (");

		Polynome resultedPolynome = polynomes[0].devideBy(polynomes[1]);

		if (null == resultedPolynome)
		{
			System.out.println("Упс! Как-то плохо они поделились... Извиняюсь! Показывать не буду, стыдно >_<");
		}
		else {
			sb.append(polynomes[0].toString());
			sb.append(")  +  (");
			sb.append(resultedPolynome.toString());
			sb.append(")");
			
			System.out.println(sb.toString());
		}
	}


	/**
	 * Get input line
	 * @return
	 */
	public static String getInputLine()
	{
		BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));

		try {
			return stdin.readLine();
		}
		catch(Exception e) {
			System.out.println("Error: " + e.getMessage());
			return null;
		}
	}

	
	/**
	 * Get array of double from array of string
	 * @param sarr
	 * 		array of strings, which should be corrects doubles
	 * @return
	 */
	public static double[] getIntegers(String[] sarr)
	{
		double[] out = new double[sarr.length];

		for (int i = 0; i < sarr.length; i++)
		{
			try {
				out[i] = Double.parseDouble(sarr[i]);
			}
			catch(NumberFormatException e) {
				return null;
			}
		}
		
		return out;
	}

}
