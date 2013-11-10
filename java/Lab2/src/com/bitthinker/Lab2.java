package com.bitthinker;

/**
 * @author Cristian
 * @var 20
 * @lab_num 2
 * @date 2013/11/10
 * @task: you have an A[n] array.
 * 		Replace every element, except first one, with sum of all previous elements. 
 */


public class Lab2 {

	private int[] _array;
	private int N = 10;

	public Lab2()
	{
		_array = new int[N];
		for (int i = 0; i < N; ++i) {
			_array[i] = i;
		}
	}


	void print_array()
	{
		for (int i = 0; i < N; i++) {
			System.out.println(_array[i]);
		}
	}
	
	
	void calculate_sum()
	{
		// staff..
	}



}
