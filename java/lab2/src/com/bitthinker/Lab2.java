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
	private int N = 100;

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
			System.out.format("%d\t", _array[i]);
		}
		System.out.println("");
	}


	void calculate_sum()
	{
		if (N < 2) {
			return;
		}


		int[] tmp = new int[N];
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

}
