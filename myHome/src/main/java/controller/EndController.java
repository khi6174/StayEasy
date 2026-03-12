package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.ItemDao;
import dao.UserDao;
import logic.Shop;
import model.Cart;
import model.LoginUser;
import model.User;

@Controller
public class EndController {
	@Autowired
	private Shop shop;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ItemDao itemDao;
	@RequestMapping(value="/end/end.html")
	public ModelAndView end(HttpSession session, 
							HttpServletResponse response) throws IOException{
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");//세션에서 사용자를 찾음
		User user = this.userDao.getUserInfo(loginUser.getId());//계정으로 사용자정보 검색
		if(loginUser == null) {
			//throw new LoginRequiredException("로그인 되어있지 않습니다.");
		}
		Cart cart = (Cart)session.getAttribute("CART");//세션에서 장바구니를 찾음
		if(cart == null || cart.getCodeList().isEmpty()) {
			//throw new CartEmptyException("카트가 비어있습니다.");
		}
		this.shop.checkout(user, cart);//매출정보와 매출상세정보테이블에 매출정보를 삽입한다.
		cart.clearAll();//장바구니를 비운다.
		this.itemDao.deleteCart(user.getUser_id());//계정에 해당하는 장바구니 테이블 삭제
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","end.jsp");
		return mav;
	}
}













