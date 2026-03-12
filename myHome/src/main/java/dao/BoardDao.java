 package dao;

import java.util.List;

import model.Board;

public interface BoardDao {
	Integer totalCount();//전체 게시글의 갯수 리턴 메서드
	void updateBoard(Board board);//게시글 변경(제목,내용) 메서드
	void deleteBoard(Integer seq);//게시글 삭제 메서드
	Integer getMaxSeq();//가장 큰 글번호 검색 메서드
	void putBoard(Board bbs);//게시글 삽입 메서드
	List<Board> readBoard(Integer pageNo);//게시글 목록 검색 메서드
	Board readDetail(Integer seq);//글번호로 게시글 검색 메서드
}
