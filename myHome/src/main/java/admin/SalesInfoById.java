package admin;

public class SalesInfoById {
	private String user_id;
	private Integer sale_detail_id;
	private Integer sale_id;
	private String item_id;
	private Integer quantity;
	private Integer delivery_state;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getSale_detail_id() {
		return sale_detail_id;
	}
	public void setSale_detail_id(Integer sale_detail_id) {
		this.sale_detail_id = sale_detail_id;
	}
	public Integer getSale_id() {
		return sale_id;
	}
	public void setSale_id(Integer sale_id) {
		this.sale_id = sale_id;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(Integer delivery_state) {
		this.delivery_state = delivery_state;
	}
}
