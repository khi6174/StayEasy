package dao;

import java.util.List;

import model.CartItem;

public interface CartDao {
	void insertCart(CartItem ci);
	void deleteCart(CartItem ci);
	void updateCart(CartItem ci);
	List<CartItem> selectCart(String id);
}
