package dao;

import java.util.List;

import model.Notice;
import model.StartEnd;

public interface NoticeDao {
	void updateNotice(Notice notice);//공지글 수정
	void deleteNotice(Integer num);//공지글 삭제 
	Integer getMaxNum();//가장 큰 글번호 검색
	void putNotice(Notice notice);//게시글 삽입
	Integer getCount();//공지글 갯수 검색
	List<Notice> getNoticeList(StartEnd st);//공지글 목록 검색
	Notice getNotice(Integer num);//글번호로 공지글 검색
}
















