package dao;

import java.util.List;
import java.util.Map;

import model.Accommodation;
import model.Inquire;
import model.User;
import model.UserInfo;

public interface AdminDao {
	List<User> getAllUsers(); // 모든 사용자 조회
	UserInfo getUserInfoById(String user_id); // 특정 사용자 조회
    List<Inquire> getAllInquires(); // 모든 문의 조회
    List<Map<String, Object>> getRegisteredAccommodations(); // 등록된 숙소 조회
    Map<String, Object> getRegisteredAccommodationById(String accommodationId);
    List<Map<String, Object>> getPendingAccommodations(); // 승인 대기 숙소 조회 (app_status = 0)
    Map<String, Object> getAccommodationById(String accommodationId);
    List<Map<String, Object>> getRoomsByAccommodationId(String accommodationId);
    int updateAccommodationStatus(String accommodationId, int status); // 숙소 승인 처리
    
    List<Map<String, Object>> getRegisteredAccommodationsByAdmin(String userId);// 사용자 조회-> 등록된 숙소 조회
    List<Map<String, Object>> getPendingAccommodationsByAdmin(String userId); 
}
