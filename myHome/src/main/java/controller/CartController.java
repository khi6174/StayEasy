package controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.CartDao;
import dao.ItemDao;
import model.Cart;
import model.CartItem;
import model.Item;
import model.LoginUser;

@Controller
@Scope("session")
public class CartController {
	@Autowired
	private Cart cart;
	@Autowired
	private ItemDao itemDao;
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value="/cart/modify.html")
	public ModelAndView modify(String CODE,Integer NUM,String BTN,HttpSession session) {
		Cart cart = (Cart)session.getAttribute("CART");
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		if(BTN.equals("삭제")) {
			cart.deleteItem(CODE, user.getId());//장바구니에서 삭제
		}else if(BTN.equals("수정")) {
			cart.modifyItem(CODE, user.getId(), NUM);//장바구니에서 수정
		}
		return new ModelAndView("redirect:/cart/show.html");//장바구니 목록으로 돌아간다.
	}
	
	@RequestMapping(value="/cart/show.html")
	public ModelAndView show(HttpSession session) {
		LoginUser user = (LoginUser)session.getAttribute("loginUser");//세션에서 계정을 찾는다.
		Cart cart = (Cart)session.getAttribute("CART");//세션에서 장바구니를 찾는다.
		ModelAndView mav = new ModelAndView("index");
		if(cart != null) {//장바구니가 세션에 존재하는 경우
			int totalAmount = 0;//주문 총액을 위한 변수 선언
			ArrayList<String> codeList = cart.getCodeList();//장바구니에서 codeList를 가져옴
			ArrayList<Integer> numList = cart.getNumList();//장바구니에서 numList를 가져옴
			ArrayList<CartItem> cartItemList = new ArrayList<CartItem>();
			for(int i=0; i < codeList.size(); i++) {
				String code = codeList.get(i);//i번째 상품코드를 가져옴
				Item item = this.itemDao.getItem(code);//상품번호로 해당 상품을 조회
				CartItem ci = new CartItem();//CartItem을 생성
				ci.setItem_code(item.getItem_code());//Item의 상품번호->CartItem의 상품번호
				ci.setItem_title(item.getItem_title());//Item의 상품이름->CartItem의 상품이름 
				ci.setMadin(item.getMadein());//Item의 원산지->CartItem의 원산지
				ci.setPrice(item.getPrice());//Item의 가격->CartItem의 가격
				ci.setReg_date(item.getReg_date());//Item의 등록일->CartItem의 등록일
				ci.setNum(numList.get(i));//i번째 상품의 갯수를 CartItem에 설정
				ci.setSum(ci.getPrice() * ci.getNum());//소계를 계산한다.
				totalAmount = totalAmount + (ci.getPrice() * ci.getNum());//총액을 누적한다.
				ci.setId(user.getId());//계정을 CartItem에 설정
				cartItemList.add(ci);//CartItem을 ArrayList에 저장한다.
			}//codeList에 저장된 상품의 갯수만큼 반복
			mav.addObject("TOTAL",totalAmount);//주문 총액을 ModelAndView에 저장
			mav.addObject("CARTLIST",cartItemList);//CartItem이 저장된 ArrayList를 ModelAndView에 저장
		}else {//장바구니가 세션에 없는 경우
			mav.addObject("CARTLIST",null);
		}
		mav.addObject("BODY","cartList.jsp");
		return mav;
	}
	
	@RequestMapping(value="/cart/addCart.html")
	public ModelAndView addCart(String CODE, HttpSession session) {
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		if(user == null) {//로그인을 안 한 경우, 로그인 창을 띄운다.
			ModelAndView mav = new ModelAndView("login");
			return mav;
		}else {//로그인을 한 경우
			ModelAndView mav = new ModelAndView("addCartResult");
			Cart cart = (Cart)session.getAttribute("CART");//세션에서 장바구니(Cart)를 찾는다.
			if(cart == null) cart = this.cart;//세션에 장바구니가 없으면 생성된 장바구니를 주입
			cart.setId(user.getId());//장바구니에 계정을 설정
			cart.addCart(CODE, 1);//장바구니에 상품번호를 codeList에, 1을 numList에 저장한다.
			mav.addObject("CODE", CODE);
			mav.addObject("NUM", 1);
			session.setAttribute("CART", cart);//세션에 장바구니(Cart)를 저장한다.
			return mav;
		}
	}
}












