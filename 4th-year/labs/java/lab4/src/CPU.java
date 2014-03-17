import java.util.Scanner;

/**
 * 
 */

/**
 * @author frodox
 *
 */
public class CPU extends Goods {
	
	private String coreCount = "";
	private String frequencyGHz = "0";
	
	/**
	 * Create CPU with according specs and cost
	 * @param goodsCost
	 */
	public CPU(int cost) 
	{
		super(cost);
		
		String buf;
		
		System.out.format("Введите характеристики процессора: \n");
		
		System.out.format("Количество ядер: ");
		buf = getLineFromUser();
		this.coreCount = buf;
		
		System.out.format("Частота в Гигагерцах: ");
		buf = getLineFromUser();
		this.frequencyGHz = buf;
		
		this.goodsName = "Процессор высококлассный";
	}
	
	@Override
	public String toString() {
		String result = this.goodsName
					+ "\n"
					+ "Количество ядер: " + this.coreCount + "\n"
					+ "Частота: " + this.frequencyGHz + " GHz" + "\n"
					+ "Цена: " + this.cost() + " y.e.";
		return result;
	}

		
	
	


}
