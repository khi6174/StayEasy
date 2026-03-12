package model;

import java.sql.Timestamp;

public class SaleDetail {
	private Integer saleId;//매출번호		
	private String itemId;//상품번호
	private Sale sale;//매출 객체			
	private Item item;//과일 객체(상품 객체)
	private String saleTime;//매출 시간	
	private Integer quantity;//구매 갯수
	private Integer saleDetailId;//매출 상세 번호
	public SaleDetail(Sale sale, Integer saleDetailId, ItemSet itemSet, Timestamp currentTime) {
		this.sale = sale;	this.saleDetailId = saleDetailId;
		this.item = itemSet.getItem();		this.quantity = itemSet.getQuantity();
		this.itemId = itemSet.getItem().getItem_code();//상품번호 설정
		this.saleTime = String.valueOf(currentTime);
	}//생성자
	public Integer getSaleId() {
		return saleId;
	}
	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public Sale getSale() {
		return sale;
	}
	public void setSale(Sale sale) {
		this.sale = sale;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public String getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(String saleTime) {
		this.saleTime = saleTime;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getSaleDetailId() {
		return saleDetailId;
	}
	public void setSaleDetailId(Integer saleDetailId) {
		this.saleDetailId = saleDetailId;
	}
	
}








