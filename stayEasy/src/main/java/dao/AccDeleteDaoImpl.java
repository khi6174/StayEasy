package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccDeleteDaoImpl implements AccDeleteDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<String> getReservIdList(String accId) {
		return this.sqlSession.selectList("accDeleteMapper.getReservIdList",accId);
	}

	@Override
	public void deleteInq(String reservId) {
		this.sqlSession.delete("accDeleteMapper.deleteInq", reservId);
	}

	@Override
	public void deleteCartItem(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteCartItem", accId);
	}

	@Override
	public void deleteRoomUpdate(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteRoomUpdate", accId);
	}

	@Override
	public void deleteAccUpdate(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteAccUpdate", accId);
	}

	@Override
	public void deleteReserv(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteReserv", accId);
	}

	@Override
	public void deleteReview(String reservId) {
		this.sqlSession.delete("accDeleteMapper.deleteReview", reservId);
	}

	@Override
	public void deleteRoom(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteRoom", accId);
	}

	@Override
	public void deleteAcc(String accId) {
		this.sqlSession.delete("accDeleteMapper.deleteAcc", accId);
	}

}
