import java.awt.List;
import java.util.ArrayList;

/**
 * 
 */

/**
 * @author frodox
 *
 */
public class Customer {

	private int amountOfMoney = 0;
	private ArrayList<Goods> goods2buy = new ArrayList<Goods>();

	
	
	/**
	 * Create Customer, with some amount of pocket money.
	 * @param moneyCount
	 */
	public Customer (int moneyCount) 
	{
		this.amountOfMoney = moneyCount;
	}
	
	
		
	/* getters */
	
	public Integer amountOfMoney() {
		return this.amountOfMoney;
	}
	
	
	
	
	/* B u Y*/
	
	private void withdrawSomeMoney(int withdrawCount) {
		this.amountOfMoney -= withdrawCount; 
	}
	
	public void buy(Goods goods) 
	{
		this.withdrawSomeMoney(goods.cost());
		goods2buy.add(goods);
		System.err.println("На счету: " + this.amountOfMoney());
		System.out.flush();
	}



	public void showGoods() {
		for (int i = 0; i < goods2buy.size(); i++) {
			System.out.format("%d. ", i+1);
			System.out.println( goods2buy.get(i).toString() );
			System.out.println();
		}
		
	}
	
	
	
}
