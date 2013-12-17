import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;


public class ComputerShopDemo {

	public static void main(String[] args) {
		
		System.out.println("== Добро пожаловать в магазин компьютерной техники \"Моноблочек\" ==\n");
		
		Customer customer = new Customer(1000);
		System.out.println("У Вас в наличии: " + customer.amountOfMoney() + " y.e.");
		
		while (true) 
		{
			System.out.println("Выберите товар для покупки:\n");
			System.out.println("0. Уходим из магазина!");
			System.out.println("1. CPU (400 y.e.)");
			System.out.println("2. RAM (300 y.e.)");
			System.out.println("3. Системный блок(200 y.e.)");
			System.out.flush();
			
			int choise = getIntInRangeFromUser(0, 3);
	
			if (0 == choise) {
				if (customer.amountOfMoney() < 0) {
					System.out.println("Ууупс! Вы украили из магазина " 
								+ Math.abs(customer.amountOfMoney())
								+ " у.е. Придётся вас посадить в тюрьму... >_<");	
				}
				
				break;
			}
			
			switch (choise) 
			{
				case 1:
					customer.buy(new CPU(400));
					break;
		
				case 2:
					customer.buy(new RAM(300));	
					break;
				
				case 3:
					customer.buy(new SystemBox(200));	
					break;
					
		
				default: /* nothing */
			}

			System.out.println("\n\t-----------\n");
		}
	
		System.out.println("До свидания!");
		System.out.println("\n\t===========\n");
		System.out.println("Вы уходите из магазина со следующим добром:\n");
		customer.showGoods();
		System.out.println();
		System.out.println("Баланс: " + customer.amountOfMoney());
	}

	
	
	
	/**
	 * Read int in range [minRange, maxRange] from user(from terminal)
	 * @param minRange
	 * @param maxRange
	 * // edges are included //
	 * @return int
	 */
	private static int getIntInRangeFromUser(int minRange, int maxRange) {
		int user_choice = 0;
		
		while (true)
		{
			try {
				System.out.format("\n> ");
				String userLine = getInputLine().trim();
				user_choice = Integer.parseInt(userLine); 
				

				if (user_choice < minRange || user_choice > maxRange)
					throw new NumberFormatException("Число не из диапазона!");
				else
					break;
				
			}
			catch (Exception e) {
				System.err.println("Давайте ка ещё раз, и по нормальному!");
				System.err.println(e.getMessage());
			}
		
		}
		return user_choice;
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

}
