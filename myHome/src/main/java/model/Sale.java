package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Sale {
	private User user;//고객 객체
	private Integer saleId;//매출번호
	private String userId;//고객 계정
	private List<SaleDetail> saleDetailList = new ArrayList<SaleDetail>();
	private String saleTime;//매출시간
	
	public List<SaleDetail> getSaleDetailList() {
		return saleDetailList;
	}

	public void addSaleDetail(SaleDetail detail) {
		this.saleDetailList.add(detail);
	}//매출 상세정보를 추가하는 메서드

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getSaleId() {
		return saleId;
	}

	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSaleTime() {
		return saleTime;
	}

	public void setSaleTime(Timestamp saleTime) {
		this.saleTime = String.valueOf(saleTime);
	}
	
}















