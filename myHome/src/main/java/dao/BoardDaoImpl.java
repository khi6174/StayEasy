package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Board;
import model.StartEnd;
@Repository
public class BoardDaoImpl implements BoardDao {
	@Autowired
	private SqlSession session;
	
	@Autowired
	private StartEnd se;
	
	@Override
	public Integer totalCount() {
		return this.session.selectOne("boardMapper.getTotalCount");
	}

	@Override
	public void updateBoard(Board board) {
		this.session.update("boardMapper.updateBoard", board);
	}

	@Override
	public void deleteBoard(Integer seq) {
		this.session.delete("boardMapper.deleteBoard", seq);
	}

	@Override
	public Board readDetail(Integer seq) {
		Board bbs = this.session.selectOne("boardMapper.getBoard", seq);
		return bbs;
	}

	@Override
	public void putBoard(Board bbs) {
		bbs.setSeq(this.getMaxSeq() + 1);//글번호 설정
		this.session.insert("boardMapper.putBoard",bbs);
	}

	@Override
	public Integer getMaxSeq() {
		Integer maxSeq = this.session.selectOne("boardMapper.getMaxSeq");
		if(maxSeq == null) return 0;
		else return maxSeq;
	}
 

	@Override
	public List<Board> readBoard(Integer pageNo) {
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 5;
		int end = ((pageNo - 1) * 5) + 6;
		se.setStart(start); se.setEnd(end);
		return this.session.selectList("boardMapper.getBoardList", se);
	}

}









