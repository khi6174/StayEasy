package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.OrderModify;
import admin.SalesInfoById;
import dao.AdminDao;
import model.StartEnd;
import model.User;

@Controller
public class AdminController {
	@Autowired
	private AdminDao adminDao;
	
	@RequestMapping(value="/admin/memberUpdate.html")
	public ModelAndView update(String ID,
			String PWD,String ADDR,String PHONE,
			Integer GRADE) {
		ModelAndView mav = new ModelAndView("index");
		User user = new User(); user.setUser_id(ID); user.setUser_pwd(PWD);
		user.setAddr(ADDR); user.setPhone(PHONE); user.setGrade(GRADE);
		this.adminDao.updateMember(user);//고객 정보 변경
		mav.addObject("BODY","memberUpdateResult.jsp");
		mav.addObject("user_id",ID);//고객 계정을 ModelAndView에 저장한다.
		return mav;
	}
	
	@RequestMapping(value="/admin/getMember.html")
	public ModelAndView getMember(String id) {
		ModelAndView mav = new ModelAndView("index");
		User user = this.adminDao.findMemberById(id);//계정으로 회원정보 조회
		mav.addObject("BODY","memberDetail.jsp");
		mav.addObject("user",user);
		return mav;
	}
	
	@RequestMapping(value="/admin/findmember.html")
	public ModelAndView findmember(String ID,
		String NAME, String ADDR, String EMAIL, Integer PAGE) {
		ModelAndView mav = new ModelAndView("index");
		User user = new User(); user.setUser_id(ID); user.setName(NAME);
		user.setAddr(ADDR); user.setEmail(EMAIL);
		int currentPage = 1;
		if(PAGE != null) currentPage = PAGE;
		int start = (currentPage - 1) * 5;
		int end = ((currentPage - 1) * 5) + 6;
		int totalCount = this.adminDao.findMemberCount(user);
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		user.setStart(start); user.setEnd(end);
		List<User> memberList = this.adminDao.findMember(user);
		System.out.println("조회건수:"+memberList.size());
		mav.addObject("pageCount",pageCount);//페이지 수를 ModelAndView에 저장
		mav.addObject("ID",ID); mav.addObject("NAME",NAME);
		mav.addObject("ADDR",ADDR); mav.addObject("EMAIL",EMAIL);
		mav.addObject("memberList",memberList);
		mav.addObject("BODY","memberList.jsp");
		return mav;
	}
	
	@RequestMapping(value="/admin/findpage.html")
	public ModelAndView findpage() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","findMember.jsp");
		return mav;
	}
	
	@RequestMapping(value="/admin/orderStateSearch.html")
	public ModelAndView searchByState(Integer state, Integer PAGE) {
		ModelAndView mav = new ModelAndView("index");
		int currentPage = 1;
		if(PAGE != null) currentPage = PAGE;
		int start = (currentPage - 1) * 5; 
		int end = ((currentPage - 1) * 5) + 6;
		int totalCount = this.adminDao.getOrdersByStateCount(state);
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		StartEnd st = new StartEnd();
		st.setStart(start); st.setEnd(end); st.setState(state);
		List<OrderModify> orderList = this.adminDao.getOrdersByState(st);
		mav.addObject("state",state);
		mav.addObject("pageCount",pageCount);
		mav.addObject("BODY","allStateList.jsp");
		mav.addObject("allOrders",orderList);
		return mav;
	}
	
	@RequestMapping(value="/admin/deliverylist.html")
	public ModelAndView orderlist(Integer PAGE) {
		ModelAndView mav = new ModelAndView("index");
		int currentPage = 1;
		if(PAGE != null) currentPage = PAGE;
		int totalCount  = this.adminDao.getTotalOrders();//전체 주문 목록의 갯 수
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		int start = (currentPage - 1) * 5;
		int end = ((currentPage - 1) * 5) + 6;
		StartEnd se = new StartEnd(); se.setStart(start); se.setEnd(end);
		List<OrderModify> allOrders = this.adminDao.getAllOrders(se);
		mav.addObject("pageCount",pageCount);//페이지 수를 ModelAndView에 저장
		mav.addObject("BODY","allOrderList.jsp");
		mav.addObject("allOrders",allOrders);
		return mav;
	}
	
	@RequestMapping(value="/admin/deliverymenu.html")
	public ModelAndView menu() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","deliveryMenu.jsp");
		return mav;
	}
	@RequestMapping(value="/admin/orderModifyFromList.html")
	public ModelAndView modifyfromlist(String user_id, Integer sale_id,
			Integer sale_detail_id, Integer state) {
		OrderModify om = new OrderModify();
		om.setUser_id(user_id); om.setSale_id(sale_id); om.setState(state);
		om.setSale_detail_id(sale_detail_id);
		this.adminDao.modifyOrderState(om);//고객의 배송정보 update
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","orderModifyFromListResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/admin/orderModify.html")
	public ModelAndView modify(String user_id, Integer sale_id,
									Integer sale_detail_id, Integer state) {
		OrderModify om = new OrderModify();
		om.setUser_id(user_id); om.setSale_id(sale_id); om.setState(state);
		om.setSale_detail_id(sale_detail_id);
		this.adminDao.modifyOrderState(om);//고객의 배송정보 update
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","orderModifyResult.jsp");
		mav.addObject("user_id",user_id);
		return mav;
	}
	
	@RequestMapping(value="/admin/order.html")
	public ModelAndView order(String ID) {
		ModelAndView mav = new ModelAndView("index");
		List<SalesInfoById> salesList = this.adminDao.getCustomerSales(ID);
		mav.addObject("BODY","customerOrderList.jsp");
		mav.addObject("salesList",salesList);
		return mav;
	}
	
	@RequestMapping(value="/admin/delivery.html")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","findCustomer.jsp");//주문 고객 정보 검색 JSP
		return mav;
	}
}


