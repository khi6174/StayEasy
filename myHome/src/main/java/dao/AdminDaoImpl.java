package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.OrderModify;
import admin.SalesInfoById;
import model.StartEnd;
import model.User;
@Repository
public class AdminDaoImpl implements AdminDao {
	@Autowired
	private SqlSession session;
	
	public void updateMember(User user) {
		this.session.update("adminMapper.updateMember",user);
	}

	public User findMemberById(String id) {
		return this.session.selectOne("adminMapper.findMemberById",id);
	}

	public Integer findMemberCount(User user) {
		return this.session.selectOne("adminMapper.findMemberCount",user);
	}

	public List<User> findMember(User user) {
		return this.session.selectList("adminMapper.findMember",user);
	}

	public Integer getOrdersByStateCount(Integer state) {
		return this.session.selectOne("adminMapper.getOrdersByStateCount",state);
	}

	public List<OrderModify> getOrdersByState(StartEnd se) {
		return this.session.selectList("adminMapper.getOrdersByState",se);
	}

	public Integer getTotalOrders() {
		Integer count = this.session.selectOne("adminMapper.getTotalOrders");
		if(count == null) return 0;
		else return count;
	}

	public List<OrderModify> getAllOrders(StartEnd se) {
		return this.session.selectList("adminMapper.getAllOrders", se);
	}

	public void modifyOrderState(OrderModify om) {
		this.session.update("adminMapper.modifyOrderState",om);
	}

	public List<SalesInfoById> getCustomerSales(String id) {
		return this.session.selectList("adminMapper.getSalesInfoById",id);
	}

}









