package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dao.CartDao;
import dao.UserDao;
import model.Cart;
import model.CartItem;
import model.LoginUser;

@Controller
@Scope("session")
public class LoginController {
	@Autowired
	private Cart cart;
	@Autowired
	private CartDao cartDao;
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value="/login/loginDo.html",method=RequestMethod.POST)
	public ModelAndView loginDo(@Valid LoginUser loginUser, BindingResult br,
			HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}//어노테이션을 이용한 폼체크
		LoginUser user = this.userDao.getLoginUser(loginUser);
		mav.addObject("BODY","loginResult.jsp");
		if(user == null) {//로그인 실패
			mav.addObject("FAIL","YES");
		}else {//로그인 성공
			session.setAttribute("loginUser", user);
			//DB에서 계정으로 장바구니 테이블을 검색한다. 시작
			List<CartItem> cartList = 
					this.cartDao.selectCart(user.getId());//로그인한 계정으로 장바구니 테이블 검색
			if(cartList.size() > 0) {//장바구니에 데이터가 존재하는 경우
				Cart cart = this.cart;//생성된 장바구니를 주입
				cart.setId(user.getId());//장바구니의 주인(계정) 설정
				for(int i=0; i < cartList.size(); i++) {//장바구니에 있는 상품의 수 만큼 반복
					CartItem ci = cartList.get(i);//i번째 상품정보를 검색
					cart.setCodeList(i, ci.getItem_code());//장바구니의 codeList에 상품코드 삽입
					cart.setNumList(i, ci.getNum());//장바구니의 numList에 상품 갯수 삽입
				}
				session.setAttribute("CART", cart);//장바구니를 세션에 저장한다.
			}
			//DB에서 계정으로 장바구니 테이블을 검색한다. 끝
		}
		return mav;
	}

	@RequestMapping(value="/login/login.html")	
	public ModelAndView loginForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("login");
		//mav.addObject(new LoginUser());
		request.setAttribute("loginUser",new LoginUser());//login.jsp에 객체(인스턴스)를 주입한다.
		return mav;
	}
}












