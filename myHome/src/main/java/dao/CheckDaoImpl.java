package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CheckDaoImpl implements CheckDao {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public Integer checkDupId(String id) {
		Integer count = this.sqlSession.selectOne("checkMapper.checkDupId",id);
		return count;
	}

}


