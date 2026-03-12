package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Inquire;
import model.StartEnd;
import model.User;

@Repository
public class InquireDaoImpl implements InquireDao {

    @Autowired
    private SqlSession sqlSession;

    

	@Override
	public void updateOrderNo(Inquire inquire) {
		this.sqlSession.update("inquireMapper.updateOrderNo",inquire);
		
	}

	@Override
	public Integer getReplyCount(Integer id) {
		return this.sqlSession.selectOne("inquireMapper.getReplyCount",id);
	}

	@Override
	public void updateInquire(Inquire inquire) {
		this.sqlSession.update("inquireMapper.updateInquire",inquire);
		
	}

	@Override
	public void deleteInquire(Integer num) {
		this.sqlSession.delete("inquireMapper.deleteInquire",num);
		
	}

	@Override
	public User getUserId(String id) {
		return this.sqlSession.selectOne("inquireMapper.getUserId",id);
	}
    
    @Override
    public List<Inquire> getInquireList(StartEnd se) {   
        return this.sqlSession.selectList("inquireMapper.getInquireList", se);
    }
    @Override
    public List<Inquire> getInquireListByUser(StartEnd se) {   
        return this.sqlSession.selectList("inquireMapper.getInquireListByUser", se);
    }
    
    @Override
    public Integer getInquireCountUser(String userId) {
        return this.sqlSession.selectOne("inquireMapper.getInquireCountByUser",userId);
    }
    @Override
    public Integer getInquireCountAll() {
        return this.sqlSession.selectOne("inquireMapper.getInquireCountAll");
    }


    @Override
    public Inquire getInquireDetail(Integer inquire_id) {
        return this.sqlSession.selectOne("inquireMapper.getInquireDetail", inquire_id);
    }


    @Override
    public Integer getMaxNum() {
        return this.sqlSession.selectOne("inquireMapper.getMaxNum");
    }

    @Override
    public void putInquire(Inquire inquire) {
        this.sqlSession.insert("inquireMapper.putInquire", inquire);
    }

	@Override
	public void updateInquireStatus(Inquire inquire) {
		this.sqlSession.update("inquireMapper.modifyInquireStatus",inquire);
		
	}

	@Override
	public User getOriginalUser(Integer inquire_id) {
	    return this.sqlSession.selectOne("inquireMapper.getOriginalUser", inquire_id);
	}

	@Override
	public String getReservId(Integer inquire_id) {
		return this.sqlSession.selectOne("inquireMapper.getReservId",inquire_id);
	}

	@Override
	public Integer countInqId() {
		return this.sqlSession.selectOne("inquireMapper.countInqId");
	}

	@Override
	public void setStatus(int inquire_id, String status) {
		Map<String, Object> param= new HashMap<>();
		param.put("inquire_id", inquire_id);
		param.put("status", status);
		this.sqlSession.update("inquireMapper.setStatus", param);
	}

	@Override
	public Integer getMaxOrder(int group_id) {
		return this.sqlSession.selectOne("inquireMapper.getMaxOrder", group_id);
	}

	@Override
	public Inquire getReply(Integer parent_id) {
		return this.sqlSession.selectOne("inquireMapper.getReply",parent_id);
	}

	@Override
	public List<Inquire> getInq(String reserv_id) {
		return this.sqlSession.selectList("inquireMapper.getInq", reserv_id);
	}
	
	
}
