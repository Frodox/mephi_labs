import java.util.Scanner;

/**
 * 
 */

/**
 * @author frodox
 *
 */
public class Goods {
	
	private int cost = 0;
	protected String goodsName = "";
	
	/**
	 * Create a goods with some price:
	 * @param goodsCost
	 */
	public Goods(int goodsCost) 
	{
		this.cost = goodsCost;
	}

	
	/* getters */
	public int cost() {
		return this.cost;
	}
	
	
	public String toString() {
		return "Cost: " + this.cost;
	}
	
	
	
	
	/* helpers */
	
	protected String getLineFromUser() {
		Scanner sc = new Scanner(System.in);
		String result = sc.nextLine();
		return result;
	}
}
