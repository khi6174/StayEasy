package dao;

import model.SellingItem;

public interface SellingItemDao {
	SellingItem getItem(String code);
	//상품번호로 상품 조회
}
