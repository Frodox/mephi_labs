
public class SystemBox extends Goods {

	private String dimensions = "";
	
	public SystemBox(int goodsCost) 
	{
		super(goodsCost);
		
		String buf;
		
		System.out.format("Введите характеристики Системного блока:\n");
		System.out.format("Ширина х Высота х Длинна: ");
		buf = getLineFromUser();
		this.dimensions = buf;
	
		this.goodsName = "Системный блок высоковместительный";
	}

	
	@Override
	public String toString() {
		String result = this.goodsName
					+ "\n"
					+ "Размеры: " + this.dimensions + "\n"
					+ "Цена: " + this.cost() + " y.e.";
		return result;
	}
	
}
