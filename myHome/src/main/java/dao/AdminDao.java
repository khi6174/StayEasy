package dao;

import java.util.List;

import admin.OrderModify;
import admin.SalesInfoById;
import model.StartEnd;
import model.User;

public interface AdminDao {
	void updateMember(User user);//회원 정보 변경
	User findMemberById(String id);//회원 계정으로 회원 정보 검색
	Integer findMemberCount(User user);//4가지 조건의 결과 건 수 조회
	List<User> findMember(User user);//4가지 조건으로 회원 조회
	Integer getOrdersByStateCount(Integer state);//배송상태에 따른 주문 건 수 검색
	List<OrderModify> getOrdersByState(StartEnd se);//배송상태로 모든 계정의 주문정보 검색
	
	Integer getTotalOrders();//전체 주문 정보의 갯 수 검색
	List<OrderModify> getAllOrders(StartEnd se);//모든 계정의 주문정보 검색(페이지당 5개 출력)
	void modifyOrderState(OrderModify om);//배송정보 update
	List<SalesInfoById> getCustomerSales(String id);
	//고객 계정으로 매출상세 정보 검색
}












