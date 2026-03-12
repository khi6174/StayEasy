package dao;

import java.util.List;

import model.Item;
import model.Nation;
import model.StartEnd;

public interface ItemDao {
	List<Item> getItemByName(StartEnd st);//상품이름으로 검색
	Integer getItemCountByName(String name);//상품이름의 상품 갯수
	
	void deleteCart(String id);//고객의 계정에 해당하는 장바구니 삭제
	void updateItem(Item item);//상품코드로 상품정보 변경
	void deleteItem(String code);//상품코드로 상품 삭제
	Item getItem(String code);//상품코드로 상품 검색
	Integer getTotalItems();//전체 상품 갯수 검색
	List<Item> getItems(StartEnd se);//상품 목록 검색
	List<Nation> getNation();//상품 원산지 콤보박스용
	Integer getCodeDup(String code);//상품코드 중복 검사용
	void putItem(Item item);//상품 등록용
}














