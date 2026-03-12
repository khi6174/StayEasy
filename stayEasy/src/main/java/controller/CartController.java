package controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.AccDao;
import dao.CartDao;
import model.Accommodation;
import model.CartItem;
import model.Datee;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomId;
import model.User;

@Controller
public class CartController {
	
	@Autowired
	private AccDao accDao;
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value="/cart/noAdmin.html")
	public ModelAndView noAdmin(HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
		mav.addObject("BODY", "cartNo.jsp");
		return mav;
	}
	
	@RequestMapping(value="/cart/modifyDo.html",method=RequestMethod.POST) //숙박 수정하기
	public ModelAndView modifyDo(HttpSession session,
			@Valid CartItem cartItem, BindingResult br) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		// 로그인 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            return mav;
        }
		//폼 체크 시 객체정보 유지를 위해 db에서 데이터 가져옴
		String cartItemId = cartItem.getCartitem_id();
		CartItem localcartItem = this.cartDao.selectOneCartItem(cartItemId);
		String accId = cartItem.getRoom().getId().getAccommodationId();
		String roomId = cartItem.getRoom().getId().getRoomId();
		Accommodation acc = this.accDao.getAccDetail(accId);
		Room room = this.accDao.getRoomDetail(accId, roomId);
		//어노테이션을 이용한 폼체크
		if(br.hasErrors()) {
			mav.addObject("BODY","cartModify.jsp");
			mav.getModel().putAll(br.getModel());
			mav.addObject(acc);
			mav.addObject("cartItem", localcartItem);
			return mav;
		}
		//객실의 최대 숙박 가능 인원 수 보다 많은 인원을 선택했을 때
		int capacity = room.getCapacity();
		if(cartItem.getCount() > capacity) {
			mav.addObject("message","객실의 최대 숙박 가능 인원 수를 초과했습니다.");
			//체크인, 체크아웃 날짜 불러오기
			List<String> checkInDates = new ArrayList<>(); // 전체 체크인 날짜
			List<String> checkOutDates = new ArrayList<>(); // 전체 체크아웃 날짜
			
			//객실의 체크아웃, 체크인 날짜
			List<Datee> dateList = this.accDao.getReservDate(room);
			
			for(Datee d : dateList) { //방의 체크아웃, 체크인 날짜를 분리해서 각각의 리스트에 넣어줌
				checkInDates.add(d.getCheck_in_date().split(" ")[0]); //시간 제거 후 저장
				checkOutDates.add(d.getCheck_out_date().split(" ")[0]); //시간 제거 후 저장
			}
			// 방 ID에 해당하는 체크인, 체크아웃 리스트 묶기
			//체크인, 체크아웃 날짜가 들어갈 리스트
			Map<String, List<String>> reservedDates = new HashMap<>();
			reservedDates.put("checkInDates", checkInDates);
			reservedDates.put("checkOutDates", checkOutDates);
			
			ObjectMapper mapper = new ObjectMapper();
			String reservedDatesJson = mapper.writeValueAsString(reservedDates); // 예약된 날짜를 JSON으로 변환
			
			mav.addObject("reservedDatesJson", reservedDatesJson);
			mav.addObject("BODY","cartModify.jsp");
			mav.addObject(acc);
			mav.addObject("cartItem", localcartItem);
			return mav;
		}
		
		this.cartDao.modifyCartItem(cartItem); //db에서 장바구니 수정
		return new ModelAndView("redirect:/cart/cartList.html");
		
	}
	
	@RequestMapping(value="/cart/modify.html") //장바구니에서 수정하기 화면이동
	public ModelAndView modify(HttpSession session, String cartItemId) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		// 로그인 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            return mav;
        }
		CartItem cartItem = this.cartDao.selectOneCartItem(cartItemId);
		Accommodation acc = this.accDao.getAccDetail(cartItem.getRoom().getId().getAccommodationId());
		String roomId = cartItem.getRoom().getId().getRoomId();
		Room room = this.accDao.getRoomDetail(acc.getAccommodation_id(), roomId);
		
		//체크인, 체크아웃 날짜 불러오기
		List<String> checkInDates = new ArrayList<>(); // 전체 체크인 날짜
		List<String> checkOutDates = new ArrayList<>(); // 전체 체크아웃 날짜
		
		//객실의 체크아웃, 체크인 날짜
		List<Datee> dateList = this.accDao.getReservDate(room);
		
		for(Datee d : dateList) { //방의 체크아웃, 체크인 날짜를 분리해서 각각의 리스트에 넣어줌
			checkInDates.add(d.getCheck_in_date().split(" ")[0]); //시간 제거 후 저장
			checkOutDates.add(d.getCheck_out_date().split(" ")[0]); //시간 제거 후 저장
		}
		// 방 ID에 해당하는 체크인, 체크아웃 리스트 묶기
		//체크인, 체크아웃 날짜가 들어갈 리스트
		Map<String, List<String>> reservedDates = new HashMap<>();
		reservedDates.put("checkInDates", checkInDates);
		reservedDates.put("checkOutDates", checkOutDates);
		
		ObjectMapper mapper = new ObjectMapper();
		String reservedDatesJson = mapper.writeValueAsString(reservedDates); // 예약된 날짜를 JSON으로 변환
		
		mav.addObject("reservedDatesJson", reservedDatesJson);
		mav.addObject("acc",acc);
		mav.addObject("cartItem", cartItem);
		mav.addObject("BODY","cartModify.jsp");
		return mav;
	}
	
	@RequestMapping(value="/cart/delete.html",method=RequestMethod.POST) //장바구니에서 삭제
	public ModelAndView delete(String cartItemId, HttpSession session
			, RedirectAttributes redirectAttributes) {
		ModelAndView mav = new ModelAndView("main");
		// 로그인 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            return mav;
        }
		CartItem cartItem = this.cartDao.selectOneCartItem(cartItemId); //장바구니 항목 1개 불러옴
		this.cartDao.deleteCart(loginUser, cartItem); //db에서 장바구니 항목 삭제
		redirectAttributes.addFlashAttribute("message", "장바구니 항목을 삭제했습니다.");
		return new ModelAndView("redirect:/cart/cartList.html");
	}
	
	@RequestMapping(value="/cart/cartList.html") //장바구니로 이동
	public ModelAndView cartList(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		if(user == null) { //로그인 안했을 때 로그인 화면으로 이동
			mav.addObject(new LoginUser());
			mav.addObject("BODY","login.jsp");
			return mav;
		}
		List<CartItem> cartList = this.cartDao.selectCartItem(user.getId()); //장바구니 리스트 불러옴
		int cartItemNum = this.cartDao.countCartItem(user.getId()); //장바구니 항목 갯수 체크
		
		int rtotal_price = 0;
		
		for(CartItem item : cartList) {
				rtotal_price += item.getTotal_price(); //장바구니에서 총 결제금액
				
		    	String roomId = item.getRoom().getId().getRoomId();
		    	String accId = item.getRoom().getId().getAccommodationId();
		    	
		    	// Date -> LocalDate 변환 (시간 정보 제거)
		    	LocalDate checkInDate = item.getCheck_in_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    	LocalDate checkOutDate = item.getCheck_out_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    	// 일수 차이 계산
		    	long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
		    	item.setNights(nights);
		    	
		    	RoomId room_Id = new RoomId();
		    	room_Id.setAccommodationId(accId); room_Id.setRoomId(roomId);
		    	Room room = this.cartDao.getRoomInfo(room_Id);
		    	Accommodation acc = this.accDao.getAccDetail(accId);
		    	room.setAccommodation(acc);
		    	item.setRoom(room);
		}
		mav.addObject("rtotal_price",rtotal_price);
		mav.addObject("cartItemNum", cartItemNum);
		mav.addObject("cartList",cartList);
		mav.addObject("BODY","cartList.jsp");
		return mav;
	}

	@RequestMapping(value="/cart/addCart.html") //장바구니에 추가
	public ModelAndView addCart(@Valid Reservation reservation, BindingResult br,
			HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		
		String accId = reservation.getRoom().getId().getAccommodationId();
		String roomId = reservation.getRoom().getId().getRoomId();
		
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		//로그인을 안 한 경우, 로그인 창을 띄운다.
		if(user == null) {
			mav.addObject(new LoginUser());
			mav.addObject("BODY","login.jsp");
			return mav;
		}
		else { //로그인을 한 경우
			
		//폼 체크 진행시 객체 유지
		Accommodation acc = this.accDao.getAccDetail(accId);
		Room room = this.accDao.getRoomDetail(accId, roomId);
		
		List<Room> list = this.accDao.getRoomId(accId);
		
		mav.addObject("accID",accId);
		ObjectMapper mapper = new ObjectMapper();
		Map<String,Map<String, List<String>>> reservedDatess = new HashMap<>();
		
		for(Room roomm : list) {
			List<String> checkInDates = new ArrayList<>(); //방마다 체크인 날짜
			List<String> checkOutDates = new ArrayList<>(); //방마다 체크아웃 날짜
			List<Datee> dateList = this.accDao.getReservDate(roomm); //객실의 체크아웃, 체크인 날짜
			for(Datee d : dateList) { //방의 체크아웃, 체크인 날짜를 분리해서 각각의 리스트에 넣어줌
				checkInDates.add(d.getCheck_in_date().split(" ")[0]);
				checkOutDates.add(d.getCheck_out_date().split(" ")[0]);
			}
			 // 방 ID에 해당하는 체크인, 체크아웃 리스트 묶기
	        Map<String, List<String>> dateMap = new HashMap<>();
	        dateMap.put("checkInDates", checkInDates);
	        dateMap.put("checkOutDates", checkOutDates);

			reservedDatess.put(roomm.getId().getRoomId(), dateMap);
		}
		String reservedDatesJson = mapper.writeValueAsString(reservedDatess);
		mav.addObject("reservedDatesJson",reservedDatesJson);
		mav.addObject("roomInfo",room);
		mav.addObject("reservation", reservation);
		mav.addObject("ACC",acc);
		mav.addObject("RoomList", list);
		//어노테이션을 이용한 폼체크
		if(br.hasErrors()) {
			mav.addObject("BODY","accDetail.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		//객실의 최대 숙박 가능 인원 수 보다 많은 인원을 선택했을 때
		int capacity = room.getCapacity();
		if(reservation.getCount() > capacity) {
			mav.addObject("message","객실의 최대 숙박 가능 인원 수를 초과했습니다.");
			mav.addObject("BODY","accDetail.jsp");
			return mav;
		}
		Date checkIn = reservation.getCheck_in_date();
		Date checkOut = reservation.getCheck_out_date();
		// 날짜 차이 계산
        long diffInMillies = checkOut.getTime() - checkIn.getTime();
        int numberOfNights = (int)TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
		
		//총 계산금액 설정
		int total_price =  room.getPrice_per_night() * numberOfNights;
		reservation.setTotal_price(total_price);
		reservation.setRoom(room);
		
		//장바구니에 추가
		CartItem cartItem = new CartItem();
		Integer num = this.cartDao.getMaxCartId();
		if(num == null) {
			num = 1;
		}else {
			num += 1;
		}
		String maxNum = Integer.toString(num);
		cartItem.setCartitem_id(maxNum);
		User uuser = this.accDao.getUserId(user.getId());
		//장바구니에 같은 번호의 방이 있는지 확인
		int checkRoom = this.cartDao.checkRoomInCart(user, room);
		if(checkRoom == 0) { //장바구니에 똑같은 방이 없을 경우
			//db에 장바구니 항목 삽입
			this.cartDao.insertCartItem(cartItem, reservation, uuser);
			mav.addObject("message","장바구니에 추가되었습니다!");
			mav.addObject("BODY","accDetail.jsp");
		}
		else { //장바구니에 똑같은 방이 있는 경우
			mav.addObject("message","이미 장바구니에 추가된 방입니다.");
			mav.addObject("BODY","accDetail.jsp");
		}
		return mav;
		}
	}
}
