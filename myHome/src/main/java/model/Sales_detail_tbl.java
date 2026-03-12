package model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Sales_detail_tbl {
	@Id
	private Integer sale_detail_id;
	
	@ManyToOne
	@JoinColumn(name="sale_id")
	private Sales_tbl sale;
	private String item_id;
	private Integer quantity;
	private Integer delivery_state;//배송상태 0:주문완료,1:배송중,2:배송완료
	
	public Integer getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(Integer delivery_state) {
		this.delivery_state = delivery_state;
	}
	public Integer getSale_detail_id() {
		return sale_detail_id;
	}
	public void setSale_detail_id(Integer sale_detail_id) {
		this.sale_detail_id = sale_detail_id;
	}
	public Sales_tbl getSale() {
		return sale;
	}
	public void setSale(Sales_tbl sale) {
		this.sale = sale;
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
}








