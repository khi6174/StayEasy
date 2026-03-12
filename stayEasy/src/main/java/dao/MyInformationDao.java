package dao;

import java.util.List;

import model.Reservation;
import model.UserInfo;

public interface MyInformationDao {
	UserInfo getUser(String user_id);//계정으로 정보 조회
	void updateMyInfomation(UserInfo userInfo);//정보 수정
	List<Reservation> getReservList(String user_id); //예약 리스트 조회
	void deleteReserv(String reservation_id); //예약취소
}
