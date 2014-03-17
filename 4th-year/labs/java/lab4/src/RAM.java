
public class RAM extends Goods {

	private String amountGBs = ""; 
	
	public RAM(int goodsCost) 
	{
		super(goodsCost);

		String buf;
		
		System.out.format("Введите характеристики оперативной памяти: \n");
		System.out.format("Количество гигабайт: ");
		buf = getLineFromUser();
		this.amountGBs = buf;
		
		this.goodsName = "Оперативная память высокопроизводительная";
	}

	
	@Override
	public String toString() {
		String result = this.goodsName
					+ "\n"
					+ "Объём памяти: " + this.amountGBs + "\n"
					+ "Цена: " + this.cost() + " y.e.";
		return result;
	}
	
}
