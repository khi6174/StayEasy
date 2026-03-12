package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Reservation;
import model.User;
import model.UserInfo;

@Repository

public class MyInformationDaoImpl implements MyInformationDao {
	@Autowired
	private SqlSession session;

	@Override
	public UserInfo getUser(String user_id) {
		
		return this.session.selectOne("informationMapper.getUser",user_id);
	}

	@Override
	public void updateMyInfomation(UserInfo userInfo) {
		this.session.update("informationMapper.updateInfo",userInfo);
		
	}

	@Override
	public List<Reservation> getReservList(String user_id) {
		return this.session.selectList("informationMapper.getReservList", user_id);
	}

	@Override
	public void deleteReserv(String reservation_id) {
		this.session.delete("informationMapper.deleteReserv", reservation_id);
	}
	
	
}
