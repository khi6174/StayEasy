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
	private SqlSession sqlSession;
	@Override
	public void updateNotice(Notice notice) {
		this.sqlSession.update("noticeMapper.updateNotice", notice);
	}

	@Override
	public void deleteNotice(Integer num) {
		this.sqlSession.delete("noticeMapper.deleteNotice", num);
	}

	@Override
	public Notice getNotice(Integer num) {
		return this.sqlSession.selectOne("noticeMapper.getNotice", num);
	}

	@Override
	public Integer getCount() {
		return this.sqlSession.selectOne("noticeMapper.getNoticeCount");
	}

	@Override
	public List<Notice> getNoticeList(StartEnd st) {
		return this.sqlSession.selectList("noticeMapper.getNoticeList", st);
	}

	@Override
	public Integer getMaxNum() {
		Integer max = this.sqlSession.selectOne("noticeMapper.getMaxNum");
		if(max == null) return 0;
		else return max;
	}

	@Override
	public void putNotice(Notice notice) {
		this.sqlSession.insert("noticeMapper.putNotice", notice);
	}

}



