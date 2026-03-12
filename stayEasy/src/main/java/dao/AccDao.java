package dao;

import java.util.List;

import model.AccUpdate;
import model.Accommodation;
import model.CartItem;
import model.Category;
import model.Datee;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomUpdate;
import model.StartEnd;
import model.User;
import model.UserInfo;

public interface AccDao {
	List<Room> getRoomList(String acc_id);
	Accommodation getAccDetail(String acc_id);//숙소 번호로 숙소 검색
	List<Accommodation> getAccListByTypeLoc(StartEnd se, Category category_id, Accommodation location);
	List<Accommodation> getAccListByType(StartEnd se, Category TYPE);//타입별 숙소 검색
	Integer getCount(Category category_id);//숙소 갯수 검색
	Integer getCountByLOC(Category category_id, Accommodation location);
	List<Room> getRoomId(String acc_id); //숙소번호로 room조회
	Room getRoomDetail(String acc_id,String roomId); //숙소번호와 roomId로 room조회
	User getUserId(String id); //loginUser_id로 User_id찾기
	Integer getMaxNumReserv(); //예약번호Max 검색
	void insertReserv(Reservation reserv,User user);
    List<Reservation> getUserReservation(String Id);
    Reservation getReservationByInquireId(Integer inquire_id);
    UserInfo getUserInfoById(String user_id); // 특정 사용자 조회
    void insertReservByCart(CartItem cartItem, LoginUser loginUser); //장바구니에서 결제
    void insertAccommodation(Accommodation accommodation);
    void insertRoom(Room room, String accommodationId);
    String getNextAccommodationId();
    String getNextRoomId();
    List<Datee> getReservDate(Room room); //체크인, 체크아웃 날짜 가져오기
    Reservation getReservation(String reservation_id); //예약 불러오기
    List<Accommodation> getAccommodationsByUser(String userId);
    String getCateIdByAcc(String acc_id); //카테고리 ID 불러오기
    String getCateName(String cate_id); //카테고리 이름 불러오기
    void updateRoomImage(String room_image); //방 이미지 업데이트
    void insertAccUpdate(AccUpdate accUpdate); //숙소 수정 신청하기
    Integer getMaxAccRequest(); //숙소 수정 id 최댓값
    void insertRoomUpdate(RoomUpdate roomUpdate); //객실 수정 신청하기
    Integer getMaxRoomRequest(); //객실 수정 id 최댓값
    List<AccUpdate> getAccUpdateList(); //숙소 수정 신청 리스트
    List<AccUpdate> getAccUpdateListByUser(String userId);
    AccUpdate getAccUpdate(Integer accRequest_id); //숙소 수정 불러오기
    List<RoomUpdate> getRoomUpdateList(Integer accRequest_id); //객실 수정 신청 리스트
    void updateAcc(AccUpdate accUpdate); //숙소 수정 요청 승인
    void updateAccUpdate(AccUpdate accUpdate);
    void updateRoom(RoomUpdate roomUpdate); //객실 수정 요청 승인
    void updateRoomUpdate(RoomUpdate roomUpdate);
    void deleteAccRequest(Integer accRequestId);
    void deleteRoomRequest(Integer roomRequestId);
    List<Integer> getRoomReqIdList(Integer accRequestId);
    void updateAccUpdatePrice(Integer price);
    
}