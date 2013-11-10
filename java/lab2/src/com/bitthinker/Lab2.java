package com.bitthinker;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;



/**
 * @author Cristian
 * @var 20
 * @lab_num 2
 * @date 2013/11/10
 * @task: you have an A[n] array.
 * 		Replace every element, except first one, with sum of all previous elements. 
 */


public class Lab2 {

	private double[] _array;
	private int N = 0;
	/* Must be plain text file with numbers, separated with one space */
	private String data_file = "/tmp/data_for_array.txt";
	
	
	/**----------------------------------------------------------------------**/
	public Lab2()
	{
		fill_array_with_data();
	}

	/**----------------------------------------------------------------------**/
	void fill_array_with_data()
	{
		BufferedReader br = null;
		String file_data = null;

		try {
			br = new BufferedReader(new FileReader(data_file));

			StringBuilder sb = new StringBuilder();
			String line = br.readLine();
			if (line != null) {
				sb.append(line);
			}
			else {
				throw new IOException("Bad data in file!");
			}
			file_data = sb.toString();
		}
		catch (IOException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			System.exit(-1);
		}
		finally {
			try { br.close(); } 
			catch (IOException e) { e.printStackTrace(); }
		}
		System.out.println("File contain data: \n" + file_data);


		/* allocate memory and convert String to Double */
		String[] parts = file_data.split(" ");
		try {
			N = parts.length;
			_array = new double[N];

			for (int i = 0; i < N; i++) {
				double tmp_num = Double.parseDouble(parts[i]);
				_array[i] = tmp_num;
			}
		}
		catch(NumberFormatException nfe){
			System.err.println(nfe.getMessage());
			System.err.println("Bad string. Please, edit data file :) " + data_file);
			System.exit(-1);
		}
	}
	
	
	/**----------------------------------------------------------------------**/
	void calculate_sum()
	{
		if (N < 2) {
			return;
		}


		double[] tmp = new double[N];
		tmp[0] = _array[0];
		tmp[1] = tmp[0];

		if (2 == N) {
			_array = tmp;
			return;
		}

		for (int i = 2; i < N; i++) {
			tmp[i] = tmp[i-1] + _array[i-1];
		}
		_array = tmp;
	}

	/**----------------------------------------------------------------------**/
	void print_array()
	{
		for (int i = 0; i < N; i++) {
			System.out.format("%5.2f\t", _array[i]);
		}
		System.out.println("");
	}

	
	
}
