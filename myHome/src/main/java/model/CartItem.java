package model;

public class CartItem {
	private String id;//계정
	private String item_code;
	private String item_title;
	private int price;
	private String item_spec;
	private String reg_date;
	private String madin;//원산지국가 코드
	
	private int sum;//소계(상품코드 별 구매금액)
	private int num;//갯수(상품코드 별 갯수)
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getItem_title() {
		return item_title;
	}
	public void setItem_title(String item_title) {
		this.item_title = item_title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getItem_spec() {
		return item_spec;
	}
	public void setItem_spec(String item_spec) {
		this.item_spec = item_spec;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getMadin() {
		return madin;
	}
	public void setMadin(String madin) {
		this.madin = madin;
	}

}//상품정보 DTO
