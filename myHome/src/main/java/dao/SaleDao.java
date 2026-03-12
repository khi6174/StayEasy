package dao;

import model.Sale;

public interface SaleDao {
	Integer findMaxSaleId();//주문번호 자동증가용 메서드
	void create(Sale sale);//매출정보 삽입 메서드
}//매출정보 삽입에 사용하는 DAO
