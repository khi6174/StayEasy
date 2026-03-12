package dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Reservation;
import model.Review;
import model.Room;
import model.RoomId;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void deleteReview(Integer review_id) {
		this.session.delete("reviewMapper.deleteReview", review_id);
	}

	@Override
	public void putReview(Review review) {
		if (review.getReservation() == null || review.getReservation().getReservation_id() == null) {
			throw new IllegalArgumentException("Reservation ID가 없습니다.");
	    }
		this.session.insert("reviewMapper.putReview", review);
	}

	public List<Reservation> getReservByUser(String userId, String ACC) {
	    Map<String, String> params = new HashMap<>();
	    params.put("ID", userId);
	    params.put("ACC", ACC);
	    return session.selectList("reviewMapper.getReservByUser", params);
	}
	
	@Override
	public BigDecimal getRatingAVG(String ACC) {
		return this.session.selectOne("reviewMapper.getRatingAVG", ACC);
	}

	@Override
	public String getACCName(String ACC) {
		return this.session.selectOne("reviewMapper.getAccName", ACC);
	}
	
	@Override
	public String getACCByName(String ACC) {
		return this.session.selectOne("reviewMapper.getACCByName", ACC);
	}

	@Override
	public List<Reservation> getReservByAcc(String ACC) {
		return this.session.selectList("reviewMapper.getReservByAcc", ACC);
	}

	@Override
	public List<Review> getReviewByReserv(String RESERV) {
	    List<Review> reviews = this.session.selectList("reviewMapper.getReviewByReserv", RESERV);

	    if (reviews == null || reviews.isEmpty()) {
	        return new ArrayList<>(); // 빈 리스트 반환하여 NullPointerException 방지
	    }

	    // 각 Review 객체에 Reservation 정보 주입
	    for (Review review : reviews) {
	        Reservation reservation = review.getReservation();
	        
	        // ✅ 예약 정보가 NULL인 경우 방지
	        if (reservation == null) {
	            reservation = new Reservation();
	            review.setReservation(reservation);
	        }

	     // ✅ Room 정보가 없는 경우, DB에서 조회하여 추가
	        if (reservation.getRoom() == null || reservation.getRoom().getId() == null) {
	            // ✅ reservation에서 room_id와 accommodation_id를 개별적으로 가져올 수 없으므로, room이 null이 아닌지 확인 후 추출
	            RoomId roomId = this.session.selectOne("reviewMapper.getRoomIdByReserv", reservation.getReservation_id());

	            // ✅ roomId가 null이 아닐 때만 room 조회 진행
	            if (roomId != null && roomId.getRoomId() != null && roomId.getAccommodationId() != null) {
	                Room room = this.session.selectOne("reviewMapper.getRoomById", roomId);
	                if (room != null) {
	                    reservation.setRoom(room);
	                }
	            }
	        }
	    }
	    return reviews;
	}

	@Override
	public Integer getMaxNum() {
		Integer max = this.session.selectOne("reviewMapper.getMaxNum");
		if(max == null) return 0;
		else return max;
	}

	@Override
	public Room getRoomById(RoomId ROOM) {
		return this.session.selectOne("reviewMapper.getRoomById", ROOM);
	}
	
}
