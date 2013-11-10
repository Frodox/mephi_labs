package com.bitthinker;

public class Main {

	public static void main(String[] args) {

		Lab2 lab = new Lab2();
		
		System.out.println("Before Magic:");
		lab.print_array();
		
		lab.calculate_sum();
		
		System.out.println("After magic:");
		lab.print_array();

	}

}
