package dao;

import java.util.List;

import model.CartItem;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomId;
import model.User;

public interface CartDao {
	List<CartItem> selectCartItem(String user_id); //로그인 시 장바구니 찾기
	void insertCartItem(CartItem cartItem, Reservation reservation, User user); //장바구니 담기
	Integer getMaxCartId(); //장바구니 항목 ID 최대값 찾기
	Room getRoomInfo(RoomId roomId); //장바구니 목록에서  room객체를 넣어주기 위함
	Integer checkRoomInCart(LoginUser loginUser, Room room); //장바구니를 담을 때 똑같은 방이 이미 있는지 중복확인
	void deleteCart(LoginUser loginUser, CartItem cartItem); //장바구니 삭제
	CartItem selectOneCartItem(String cartitem_id); //장바구니 항목 1개 불러오기
	Integer countCartItem(String user_id); //유저id로 장바구니 항목 갯수 확인
	void modifyCartItem(CartItem cartItem); //장바구니 수정
}
