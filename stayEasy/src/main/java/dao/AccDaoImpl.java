package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.AccUpdate;
import model.Accommodation;
import model.CartItem;
import model.Category;
import model.Datee;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomId;
import model.RoomUpdate;
import model.StartEnd;
import model.User;
import model.UserInfo;

@Repository
public class AccDaoImpl implements AccDao {
	

	@Autowired
	private SqlSession sqlSession;
	
	private EntityManagerFactory emf;
	
	@PersistenceUnit
	public void setEmf(EntityManagerFactory emf) {
		this.emf = emf;
	}
	
	@Override
	public List<Room> getRoomList(String acc_id) {
		return this.sqlSession.selectList("reservMapper.getRoomList", acc_id);
	}

	@Override
	public Integer getCount(Category category_id) {
		return this.sqlSession.selectOne("reservMapper.getAccCount", category_id);
	}
	
	@Override
	public Integer getCountByLOC(Category category_id, Accommodation location) {
		Map<String, Object> params = new HashMap<>();
		params.put("category_id", category_id.getCategory_id());
		params.put("location", location.getLocation());
		return this.sqlSession.selectOne("reservMapper.getAccCountByLOC", params);
	}

	@Override
	public List<Accommodation> getAccListByTypeLoc(StartEnd se, Category category_id, Accommodation location) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", se.getStart());
		params.put("end", se.getEnd());
		params.put("TYPE", category_id.getCategory_id());
		params.put("LOC", location.getLocation());
		return this.sqlSession.selectList("reservMapper.getAccListByTypeLoc", params);
	}
	
	@Override
	public List<Accommodation> getAccListByType(StartEnd se, Category TYPE) {
		Map<String, Object> params = new HashMap<>();
		params.put("start", se.getStart());
		params.put("end", se.getEnd());
		params.put("TYPE", TYPE.getCategory_id());
		return this.sqlSession.selectList("reservMapper.getAccListByType", params);
	}

	@Override
	public Accommodation getAccDetail(String acc_id) {
		return this.sqlSession.selectOne("reservMapper.getAccDetail", acc_id);
	}

	@Override
	public List<Room> getRoomId(String acc_id) {
		EntityManager em = this.emf.createEntityManager();
		List<Room> list = em.createQuery(
			    "SELECT r FROM Room r WHERE r.accommodation.accommodation_id = :acc_id"
				, Room.class).setParameter("acc_id", acc_id)
			    .getResultList();
		return list;
	}

	@Override
	public Room getRoomDetail(String acc_id, String roomId) {
		EntityManager em = this.emf.createEntityManager();
		Room roomInfo = em.createQuery(
				"SELECT r FROM Room r WHERE r.accommodation.accommodation_id = :acc_id "
				+ "AND r.id.roomId = :room_id",Room.class)
				.setParameter("acc_id", acc_id).setParameter("room_id", roomId)
				.getSingleResult();
		return roomInfo;
	}

	@Override
	public User getUserId(String id) {
		return this.sqlSession.selectOne("reservMapper.getUserId",id);
	}

	@Override
	public Integer getMaxNumReserv() {
		return this.sqlSession.selectOne("reservMapper.getMaxNumReserv");
	}
	
	@Override
	public void insertReservByCart(CartItem cartItem, LoginUser loginUser) {
		Map<String, Object> params = new HashMap<>();
		params.put("reservation_id", getMaxNumReserv() + 1);
		params.put("user_id", loginUser.getId());
		params.put("accommodation_id", cartItem.getRoom().getId().getAccommodationId());
		params.put("room_id", cartItem.getRoom().getId().getRoomId());
		params.put("check_in_date", cartItem.getCheck_in_date());
		params.put("check_out_date", cartItem.getCheck_out_date());
		params.put("total_price", cartItem.getTotal_price() );
		params.put("count", cartItem.getCount() );
		params.put("r_date", new Date());
		this.sqlSession.insert("reservMapper.insertReserv", params);
	}

	@Override
	public void insertReserv(Reservation reserv,User user) {
		Map<String, Object> params = new HashMap<>();
		params.put("reservation_id", reserv.getReservation_id());
		params.put("user_id", user.getUser_id());
		params.put("accommodation_id", reserv.getRoom().getId().getAccommodationId());
		params.put("room_id", reserv.getRoom().getId().getRoomId());
		params.put("check_in_date", reserv.getCheck_in_date());
		params.put("check_out_date", reserv.getCheck_out_date());
		params.put("total_price", reserv.getTotal_price() );
		params.put("count", reserv.getCount() );
		params.put("r_date", reserv.getR_date() );
		this.sqlSession.insert("reservMapper.insertReserv", params);
	}
    @Override
    public List<Reservation> getUserReservation(String Id) {
        return sqlSession.selectList("reservMapper.getUserReservation", Id);
    }
    
    @Override
	public Reservation getReservationByInquireId(Integer inquire_id) {
		return sqlSession.selectOne("reservMapper.getReservationByInquireId",inquire_id);
	}

	@Override
    public UserInfo getUserInfoById(String user_id) {
        return sqlSession.selectOne("accMapper.getUserInfoById", user_id);
    }
    @Override
    public void insertRoom(Room room, String accommodationId) {
    	// 새로운 방 ID 생성 (기존 방 ID에서 1 증가)
        String nextRoomId = getNextRoomId();
        room.setId(new RoomId(nextRoomId, accommodationId)); // 새로운 Room ID 설정

        // NULL 방지: 기본값 설정
        if (room.getRoom_image() == null || room.getRoom_image().trim().isEmpty()) {
            room.setRoom_image("/imgs/default_room.png");
        }
        if (room.getName() == null || room.getName().trim().isEmpty()) {
            room.setName("기본 방");
        }
        if (room.getCapacity() == null) {
            room.setCapacity(2);  // 기본 인원 설정
        }
        if (room.getPrice_per_night() == null) {
            room.setPrice_per_night(50000);  // 기본 가격 설정
        }

        sqlSession.insert("accMapper.insertRoom", room);
    }



	
    @Override
    public void insertAccommodation(Accommodation accommodation) {
    	String nextId = getNextAccommodationId();
        accommodation.setAccommodation_id(nextId);
        accommodation.setApp_status(0); // 승인 상태 기본값 설정

        sqlSession.insert("accMapper.insertAccommodation", accommodation);
    }

	
    @Override
    public String getNextAccommodationId() {
        Integer maxId = sqlSession.selectOne("accMapper.getMaxAccommodationId");
        return String.valueOf((maxId != null ? maxId : 0) + 1); // ID 1 증가
    }

    @Override
    public String getNextRoomId() {
        Integer maxId = sqlSession.selectOne("accMapper.getMaxRoomId");
        return String.valueOf((maxId != null ? maxId : 0) + 1); // ID 1 증가
    }

    
	@Override
	public List<Datee> getReservDate(Room room) {
		return this.sqlSession.selectList("reservMapper.getReservDate", room);
	}

	@Override
	public Reservation getReservation(String reservation_id) {
		return this.sqlSession.selectOne("reservMapper.getReservation", reservation_id);
	}

	@Override
    public List<Accommodation> getAccommodationsByUser(String userId) {
        return sqlSession.selectList("accMapper.getAccommodationsByUser", userId);
    }

	@Override
	public String getCateIdByAcc(String acc_id) {
		return this.sqlSession.selectOne("accMapper.getCateIdByAcc",acc_id);
	}

	@Override
	public String getCateName(String cate_id) {
		return this.sqlSession.selectOne("accMapper.getCateName", cate_id);
	}

	@Override
	public void updateRoomImage(String room_image) {
		this.sqlSession.update("accMapper.updateRoomImage", room_image);
	}

	@Override
	public void insertAccUpdate(AccUpdate accUpdate) {
		this.sqlSession.insert("accUpdateMapper.insertAccUpdate", accUpdate);
		
	}

	@Override
	public Integer getMaxAccRequest() {
		return this.sqlSession.selectOne("accUpdateMapper.getMaxAccRequest");
	}

	@Override
	public void insertRoomUpdate(RoomUpdate roomUpdate) {
		this.sqlSession.insert("accUpdateMapper.insertRoomUpdate", roomUpdate);
	}

	@Override
	public Integer getMaxRoomRequest() {
		return this.sqlSession.selectOne("accUpdateMapper.getMaxRoomRequest");
	}
	@Override
	public List<AccUpdate> getAccUpdateList() {
		return this.sqlSession.selectList("accUpdateMapper.getAccUpdateList");
	}

	@Override
	public List<AccUpdate> getAccUpdateListByUser(String userId) {
		return this.sqlSession.selectList("accUpdateMapper.getAccUpdateListByAdmin",userId);
	}

	@Override
	public AccUpdate getAccUpdate(Integer accRequest_id) {
		return this.sqlSession.selectOne("accUpdateMapper.getAccUpdate", accRequest_id);
	}

	@Override
	public List<RoomUpdate> getRoomUpdateList(Integer accRequest_id) {
		return this.sqlSession.selectList("accUpdateMapper.getRoomUpdateList", accRequest_id);
	}

	@Override
	public void updateAcc(AccUpdate accUpdate) {
		this.sqlSession.update("accUpdateMapper.updateAcc", accUpdate);
	}

	@Override
	public void updateAccUpdate(AccUpdate accUpdate) {
		this.sqlSession.update("accUpdateMapper.updateAccUpdate", accUpdate);
	}

	@Override
	public void updateRoom(RoomUpdate roomUpdate) {
		this.sqlSession.update("accUpdateMapper.updateRoom",roomUpdate);
	}

	@Override
	public void updateRoomUpdate(RoomUpdate roomUpdate) {
		this.sqlSession.update("accUpdateMapper.updateRoomUpdate",	roomUpdate);
	}

	@Override
	public void deleteAccRequest(Integer accRequestId) {
		this.sqlSession.delete("accUpdateMapper.deleteAccRequest", accRequestId);
	}

	@Override
	public void deleteRoomRequest(Integer roomRequestId) {
		this.sqlSession.delete("accUpdateMapper.deleteRoomRequest", roomRequestId);
	}

	@Override
	public List<Integer> getRoomReqIdList(Integer accRequestId) {
		return this.sqlSession.selectList("accUpdateMapper.getRoomReqIdList",accRequestId);
	}

	@Override
	public void updateAccUpdatePrice(Integer price) {
		this.sqlSession.update("accUpdateMapper.updateAccUpdatePrice", price);
	}
	
}
