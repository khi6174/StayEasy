package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Event;
import model.StartEnd;

@Repository
public class EventDaoImpl implements EventDao {
	@Autowired
	private SqlSession sqlSession;
	

	
	@Override
	public void updateEvent(Event event) {
		this.sqlSession.update("eventMapper.updateEvent", event);
		
	}

	@Override
	public void deleteEvent(Integer num) {
		this.sqlSession.delete("eventMapper.deleteEvent", num);
	}

	@Override
	public Integer getMaxNum() {
		Integer max = this.sqlSession.selectOne("eventMapper.getMaxNum");
		if(max == null) return 0;
		else return max; 
	}

	@Override
	public Event getEvent(Integer event_id) {
		// TODO Auto-generated method stub
		return this.sqlSession.selectOne("eventMapper.getEvent", event_id);
	}

	@Override
	public Integer getEventCount() {
		// TODO Auto-generated method stub
		return this.sqlSession.selectOne("eventMapper.getEventCount");
	}

	@Override
	public List<Event> getEventList(StartEnd se) {
		return this.sqlSession.selectList("eventMapper.getEventList",se);
	}

	@Override
	public void putEventImage(Event event) {
		this.sqlSession.insert("eventMapper.putEventImage", event);
		
	}
	

	
}
