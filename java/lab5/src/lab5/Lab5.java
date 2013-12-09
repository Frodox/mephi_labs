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
		// TODO Auto-generated method stub
		System.out.println("Wow");
		int a = -2;
		int b = 3;
		System.out.println("" + a + " * "+ b + " = "+ multi(a, b) );
		

		for (int i = -10; i < 10; i++) {
			int b1 = i+1;
			System.out.println("" + i + " * "+ b1 + " = "+ multi(i, b1) );
		}

	}


	private static int multi(int a, int b){

	//      int sgn = ((a>0)?1:-1)*((b>0)?1:-1);
	//      a=(a>0)?
	
		int res=0;
	
		while (b!=0) {

			if( (b & 1) != 0 )
				res += a;
	
			b = b >>> 1;
			a = a << 1;
		}
	
		return res;

	}

}
