package dao;

import java.util.List;

import model.Inquire;
import model.StartEnd;
import model.User;

public interface InquireDao {
	void updateInquire(Inquire inquire);//공지글 수정
	void deleteInquire(Integer num);//공지글 삭제 
    List<Inquire> getInquireList(StartEnd se);
    List<Inquire> getInquireListByUser(StartEnd se);
    Integer getInquireCountUser(String userId);
    Integer getInquireCountAll();
    Inquire getInquireDetail(Integer inquire_id);
    Integer getMaxNum();
    void putInquire(Inquire inquire);
	User getUserId(String id); //loginUser_id로 User_id찾기
	void updateOrderNo(Inquire inquire);
	Integer getReplyCount(Integer id);
	void updateInquireStatus(Inquire inquire);
	User getOriginalUser(Integer inquire_id);
	String getReservId(Integer inquire_id); //reservation_id 불러오기
	Integer countInqId(); //inquire_id 카운트
	void setStatus(int inquire_id, String status); //답변 상태 변경
	Integer getMaxOrder(int group_id); //order_no 최댓값
	Inquire getReply(Integer parent_id); //답변 불러오기
	List<Inquire> getInq(String reserv_id); //문의 모두 불러오기(답변포함)
}
