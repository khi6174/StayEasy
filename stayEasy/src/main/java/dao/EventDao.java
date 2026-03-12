package dao;

import java.util.List;

import model.Event;
import model.StartEnd;

public interface EventDao {
	void updateEvent(Event event);//공지글 수정
	void deleteEvent(Integer num);//공지글 삭제 
	Integer getMaxNum();//가장 큰 글번호 검색
	Event getEvent(Integer event_id);//글번호로 공지글 검색
	
	
    Integer getEventCount(); // 이벤트 전체 개수 조회
    List<Event> getEventList(StartEnd se); // 페이징 처리된 이벤트 목록 조회
    void putEventImage(Event event);//이미지 게시글 insert

}