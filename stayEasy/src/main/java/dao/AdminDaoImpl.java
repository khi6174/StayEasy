package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Accommodation;
import model.Inquire;
import model.User;
import model.UserInfo;

@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
    private SqlSession session; // MyBatis SQL 세션

	// 모든 사용자 조회
    @Override
    public List<User> getAllUsers() {
        return session.selectList("adminMapper.getAllUsers");
    }
    
    @Override
    public UserInfo getUserInfoById(String user_id) {
        return session.selectOne("adminMapper.getUserInfoById", user_id);
    }

    // 모든 문의 조회
    @Override
    public List<Inquire> getAllInquires() {
        return session.selectList("adminMapper.getAllInquires");
    }

    // 등록된 숙소 목록 조회 (승인된 숙소)
    @Override
    public List<Map<String, Object>> getRegisteredAccommodations() {
        return session.selectList("adminMapper.getRegisteredAccommodations");
    }

    // ✅ 특정 숙소 상세 조회
    @Override
    public Map<String, Object> getRegisteredAccommodationById(String accommodationId) {
        return session.selectOne("adminMapper.getRegisteredAccommodationById", accommodationId);
    }
    
    // ✅ 승인 대기 숙소 목록 (app_status = 0인 숙소만)
    @Override
    public List<Map<String, Object>> getPendingAccommodations() {
        return session.selectList("adminMapper.getPendingAccommodations");
    }

    // ✅ 특정 숙소 상세 조회
    @Override
    public Map<String, Object> getAccommodationById(String accommodationId) {
        return session.selectOne("adminMapper.getAccommodationById", accommodationId);
    }
    
    @Override
    public List<Map<String, Object>> getRoomsByAccommodationId(String accommodationId) {
        return session.selectList("adminMapper.getRoomsByAccommodationId", accommodationId);
    }

    // ✅ 숙소 승인 처리
    @Override
    public int updateAccommodationStatus(String accommodationId, int status) {
        Map<String, Object> params = new HashMap<>();
        params.put("accommodationId", accommodationId);
        params.put("status", status);

        return session.update("adminMapper.updateAccommodationStatus", params);
    }

	@Override
	public List<Map<String, Object>> getRegisteredAccommodationsByAdmin(String userId) {
		return this.session.selectList("adminMapper.getRegisteredAccommodationsByAdmin", userId);
	}

	@Override
	public List<Map<String, Object>> getPendingAccommodationsByAdmin(String userId) {
		return this.session.selectList("adminMapper.getPendingAccommodationsByAdmin",userId);
	}
    
	
    
}