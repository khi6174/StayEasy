package model;

public class ItemSet {
	private Item item;//상품
	private Integer quantity;//갯수
	
	public ItemSet(Item item, Integer quantity) {
		this.item = item; this.quantity = quantity;
	}//생성자

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
}
