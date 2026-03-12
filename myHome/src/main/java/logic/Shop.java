package logic;

import java.util.List;

import model.Cart;
import model.ItemSet;
import model.User;

public interface Shop {
	Integer calculateTotal(List<ItemSet> itemList);//총액 계산 메서드
	void checkout(User user, Cart cart);//장바구니 상품 구매(매출정보 DB에 저장) 메서드
}
