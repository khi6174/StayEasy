package dao;

import java.util.List;

import model.Event;
import model.Notice;

public interface StayDao {
	List<Notice> getNoticeList();//공지글 목록
	List<Event> getEventList();//이벤트글 목록
}
