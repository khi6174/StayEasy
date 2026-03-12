package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Notice;
import model.StartEnd;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void updateNotice(Notice notice) {
		this.session.update("noticeMapper.updateNotice", notice);
	}
	
	@Override
	public void deleteNotice(Integer num) {
		this.session.delete("noticeMapper.deleteNotice", num);
	}
	
	@Override
	public Integer getMaxNum() {
		Integer max = this.session.selectOne("noticeMapper.getMaxNum");
		if(max == null) return 0;
		else return max; 
	}
	
	@Override
	public void putNotice(Notice notice) {
		this.session.insert("noticeMapper.putNotice", notice);
	}

	@Override
	public Notice getNotice(Integer notice_id) {
		return this.session.selectOne("noticeMapper.getNotice", notice_id);
	}
	
	@Override
	public List<Notice> getNoticeList(StartEnd st) {
		return this.session.selectList("noticeMapper.getNoticeList", st);
	}

	@Override
	public Integer getCount() {
		return this.session.selectOne("noticeMapper.getNoticeCount");
	}

}
