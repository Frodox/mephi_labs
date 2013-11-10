package com.bitthinker;

public class Main {

	public static void main(String[] args) {

		Lab2 lab = new Lab2();
		
		System.out.format("Before Magic:\n");
		lab.print_array();
		
		lab.calculate_sum();
		
		System.out.format("After magic:\n");
		lab.print_array();

	}

}
