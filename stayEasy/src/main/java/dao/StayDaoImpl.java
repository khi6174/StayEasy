package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Event;
import model.Notice;

@Repository
public class StayDaoImpl implements StayDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<Event> getEventList() {
		return this.session.selectList("stayMapper.getEventList");
	}
	
	@Override
	public List<Notice> getNoticeList() {
		return this.session.selectList("stayMapper.getNoticeList");
	}

}
