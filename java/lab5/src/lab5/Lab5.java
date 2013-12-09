/**
 * 
 */
package lab5;

/**
 * @author Christian
 * lab #2.1
 * task: Написать программу, умножающую 2 числа,
 *		 представимых типом int с помощью операций сложения и сдвига.
 *		 Подсказка: представить числа в виде суммы степеней 2
 */
public class Lab5 {

	public static void main(String[] args) {

		int a = 2;
		int b = 10;
		
		
		System.out.println("a = " + Integer.toBinaryString(a)  + ", b = " + Integer.toBinaryString(b));
		b = b >>> 1;
		a = a << 1;

		System.out.println("a = " + Integer.toBinaryString(a)  + ", b = " + Integer.toBinaryString(b));

		
		
		
		System.out.println("");
		a = -2;
		b = 3;
		System.out.println("" + a + " * "+ b + " = "+ multi(a, b) );
		a = 2;
		b = -3;
		System.out.println("" + a + " * "+ b + " = "+ multi(a, b) );
		

		for (int i = -10; i < 10; i++) {
			int b1 = i+1;
			System.out.println("" + i + " * "+ b1 + " = "+ multi(i, b1) );
		}

	}


	private static int multi(int a, int b) {

	
		int res=0;

		while (0 != b) {

			if ( 0 != (b & 1) )
				res += a;
	
			b = b >>> 1;
			a = a << 1;
		}
	
		return res;
	}

}
