package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.CartItem;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomId;
import model.User;

@Repository
public class CartDaoImpl implements CartDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	@Override
	public List<CartItem> selectCartItem(String user_id) {
		return this.sqlSession.selectList("cartMapper.selectCartItem", user_id);
	}
	
	@Override
	public void insertCartItem(CartItem cartItem, Reservation reservation, User user) {
		Map<String, Object> params = new HashMap<>();
		params.put("cartItem_id", cartItem.getCartitem_id());
		params.put("user_id", user.getUser_id());
		params.put("accommodation_id",reservation.getRoom().getId().getAccommodationId());
		params.put("room_id", reservation.getRoom().getId().getRoomId());
		params.put("count", reservation.getCount());
		params.put("total_price", reservation.getTotal_price());
		params.put("check_in", reservation.getCheck_in_date());
		params.put("check_out", reservation.getCheck_out_date());
		this.sqlSession.insert("cartMapper.insertCartItem", params); 
	}

	@Override
	public Integer getMaxCartId() {
		return this.sqlSession.selectOne("cartMapper.getMaxCartId");
	}

	@Override
	public Room getRoomInfo(RoomId roomId) {
		return this.sqlSession.selectOne("cartMapper.getRoomInfo", roomId);
	}

	@Override
	public Integer checkRoomInCart(LoginUser loginUser, Room room) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", loginUser.getId());
		params.put("room_id", room.getId().getRoomId());
		return this.sqlSession.selectOne("cartMapper.checkRoomInCart", params);
	}

	@Override
	public void deleteCart(LoginUser loginUser, CartItem cartItem) {
		Map<String, Object> params = new HashMap<>();
		params.put("user_id", loginUser.getId());
		params.put("cartitem_id", cartItem.getCartitem_id());
		this.sqlSession.delete("cartMapper.deleteCart", params);
	}

	@Override
	public CartItem selectOneCartItem(String cartitem_id) {
		return this.sqlSession.selectOne("cartMapper.selectOneCartItem", cartitem_id);
	}

	@Override
	public Integer countCartItem(String user_id) {
		return this.sqlSession.selectOne("cartMapper.countCartItem", user_id);
	}

	@Override
	public void modifyCartItem(CartItem cartItem) {
		this.sqlSession.update("cartMapper.modifyCartItem", cartItem);
	}
	
	
}
