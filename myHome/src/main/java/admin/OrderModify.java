package admin;

public class OrderModify {
	private String user_id;
	private Integer sale_id;
	private Integer sale_detail_id;
	private Integer state;
	private String sale_time;
	private String item_id;
	private Integer quantity;
	private Integer delivery_state;
	
	public Integer getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(Integer delivery_state) {
		this.delivery_state = delivery_state;
	}
	public String getSale_time() {
		return sale_time;
	}
	public void setSale_time(String sale_time) {
		this.sale_time = sale_time;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String ite_id) {
		this.item_id = ite_id;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getSale_id() {
		return sale_id;
	}
	public void setSale_id(Integer sale_id) {
		this.sale_id = sale_id;
	}
	public Integer getSale_detail_id() {
		return sale_detail_id;
	}
	public void setSale_detail_id(Integer sale_detail_id) {
		this.sale_detail_id = sale_detail_id;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
}
