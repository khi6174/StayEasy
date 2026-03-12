package dao;

import java.util.List;

public interface AccDeleteDao {
	List<String> getReservIdList(String accId); //숙소의 예약Id 불러오기
	void deleteInq(String reservId); //문의 삭제
	void deleteCartItem(String accId); //장바구니 삭제
	void deleteRoomUpdate(String accId); //방 수정 신청 삭제
	void deleteAccUpdate(String accId); //숙소 수정 신청 삭제
	void deleteReserv(String accId); //예약 정보 삭제
	void deleteReview(String reservId); //리뷰 삭제
	void deleteRoom(String accId); //방 정보 삭제
	void deleteAcc(String accId); //숙소 삭제
}
