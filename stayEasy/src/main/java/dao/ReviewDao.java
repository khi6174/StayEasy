package dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.omg.CORBA.REBIND;

import model.Reservation;
import model.Review;
import model.Room;
import model.RoomId;

public interface ReviewDao {
	void deleteReview(Integer review_id);
	void putReview(Review review);
	Integer getMaxNum();//가장 큰 글번호 검색
	
	BigDecimal getRatingAVG(String ACC);
	
	String getACCName(String ACC);
	String getACCByName(String ACC);
	Room getRoomById(RoomId ROOM);
	
	List<Review> getReviewByReserv(String RESERV);
	List<Reservation> getReservByAcc(String ACC);
	
	List<Reservation> getReservByUser(String userId, String ACC);
}
