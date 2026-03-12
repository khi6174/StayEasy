package controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.AccDao;
import dao.CartDao;
import model.Accommodation;
import model.CartItem;
import model.Category;
import model.Datee;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.StartEnd;
import model.User;

@Controller
public class ReservController {
	
	@Autowired
	private AccDao accDao;
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value="/reserv/payResult.html")
	public ModelAndView payResult() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("BODY","payResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/reserv/reservPayCart.html",method=RequestMethod.POST) //장바구니에서 결제하기
	public ModelAndView reservPayCart(HttpSession session) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			ModelAndView mav = new ModelAndView("main");
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
		List<CartItem> cartItems = this.cartDao.selectCartItem(loginUser.getId());
		for(CartItem cartItem : cartItems ) {
			this.accDao.insertReservByCart(cartItem, loginUser); //DB에 장바구니 리스트 insert
			this.cartDao.deleteCart(loginUser, cartItem); //구매한 항목 장바구니에서 삭제
		}
		return new ModelAndView("redirect:/reserv/payResult.html");
	}
	
	@RequestMapping(value="/reserv/reservPay.html",method=RequestMethod.POST) //결제하기
	public ModelAndView reservPay(HttpSession session, Reservation reservation) {
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser"); //세션에 저장된 로그인 유저 불러옴
		// 로그인 여부 확인
		if (loginUser == null) {
			ModelAndView mav = new ModelAndView("main");
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
		User user = this.accDao.getUserId(loginUser.getId());
		String setReserv_id = Integer.toString(this.accDao.getMaxNumReserv() + 1);
		reservation.setReservation_id(setReserv_id); //예약id설정
		reservation.setUser(user); //user_id설정
		reservation.setR_date(new Date()); //현재 날짜 설정
		this.accDao.insertReserv(reservation,user);
		return new ModelAndView("redirect:/reserv/payResult.html");
	}
	
	@RequestMapping(value="/reserv/reservGo.html") //예약하기 화면이동
	public ModelAndView reservDo(@Valid Reservation reservation, BindingResult br,
			HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("main");
		
		//세션에 저장된 로그인 유저 불러옴
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		if(loginUser==null) { //로그인을 안했을 시 로그인 창으로 이동
			mav.addObject(new LoginUser());
			mav.addObject("BODY","login.jsp");
			return mav;
		}
		String accId = reservation.getRoom().getId().getAccommodationId();
		String roomId = reservation.getRoom().getId().getRoomId();
		Accommodation acc = this.accDao.getAccDetail(accId);
		List<Room> list = this.accDao.getRoomId(accId);
		Room room = this.accDao.getRoomDetail(accId, roomId);
		int capacity = room.getCapacity();
		
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
		if(reservation.getCount() > capacity) {
			mav.addObject("message","객실의 최대 숙박 가능 인원 수를 초과했습니다.");
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
		mav.addObject("BODY","reservGo.jsp");
		return mav;
	}
	
	@RequestMapping(value="/reserv/reservDatil.html") //숙소 상세페이지
	public ModelAndView reservDatil(String accID) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		Accommodation acc = this.accDao.getAccDetail(accID);
		List<Room> list = this.accDao.getRoomId(accID);
		
		Map<String,Map<String, List<String>>> reservedDates = new HashMap<>();
		
		for(Room room : list) {
			List<String> checkInDates = new ArrayList<>(); //방마다 체크인 날짜
			List<String> checkOutDates = new ArrayList<>(); //방마다 체크아웃 날짜
			List<Datee> dateList = this.accDao.getReservDate(room); //객실의 체크아웃, 체크인 날짜
			for(Datee d : dateList) { //방의 체크아웃, 체크인 날짜를 분리해서 각각의 리스트에 넣어줌
				checkInDates.add(d.getCheck_in_date().split(" ")[0]);
				checkOutDates.add(d.getCheck_out_date().split(" ")[0]);
			}
			 // 방 ID에 해당하는 체크인, 체크아웃 리스트 묶기
	        Map<String, List<String>> dateMap = new HashMap<>();
	        dateMap.put("checkInDates", checkInDates);
	        dateMap.put("checkOutDates", checkOutDates);

			reservedDates.put(room.getId().getRoomId(), dateMap);
		}
		
		//JSON 문자열로 변환
		ObjectMapper mapper = new ObjectMapper();
		String reservedDatesJson = mapper.writeValueAsString(reservedDates);
		
		mav.addObject("accID", accID);
		mav.addObject("TYPE", acc.getCategory().getCategory_id());
		mav.addObject("reservedDatesJson", reservedDatesJson);
		mav.addObject("reservation",new Reservation());
		mav.addObject("ACC", acc);
		mav.addObject("RoomList", list);
		mav.addObject("BODY","accDetail.jsp");
		return mav;
	}
	
	@RequestMapping(value="/reserv/reservList.html")
	public ModelAndView motel(String TYPE, Integer pageNo) {
		ModelAndView mav = new ModelAndView("main");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 4;
		int end = ((currentPage - 1) * 4) + 5;
		StartEnd st = new StartEnd(); st.setStart(start); st.setEnd(end);
		Category category = new Category(); category.setCategory_id(TYPE);
		List<Accommodation> accList = this.accDao.getAccListByType(st, category);
		int totalCount = this.accDao.getCount(category);
		int pageCount = totalCount / 4;
		if(totalCount % 4 != 0) pageCount++;
		List<String> typeList = Arrays.asList("MOT", "HOT", "PEN", "CAM", "GUE", "SPA");
		mav.addObject("typeList", typeList);
		mav.addObject("currentPage",currentPage);
		mav.addObject("PAGES", pageCount);
		mav.addObject("TYPE", TYPE);
		mav.addObject("BODY","accList.jsp");
		mav.addObject("accList",accList);
		return mav;
	}
	   
	@RequestMapping(value="/reserv/reservListLOC.html", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView motelLOC(String TYPE, Integer pageNo, String LOC) {
		ModelAndView mav = new ModelAndView("main");
	       
		//LOC 값이 null이거나 빈 값이면 기본값 설정
		if (LOC == null || LOC.trim().isEmpty()) {
			LOC = "";
		}
	      
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 4;
		int end = ((currentPage - 1) * 4) + 5;
		StartEnd st = new StartEnd(); st.setStart(start); st.setEnd(end);
		Category cate = new Category(); cate.setCategory_id(TYPE);
		Accommodation acc = new Accommodation(); acc.setLocation(LOC);
		List<Accommodation> accList = this.accDao
				.getAccListByTypeLoc(st, cate, acc);
		int totalCount = this.accDao.getCountByLOC(cate, acc);
		int pageCount = totalCount / 4;
		if(totalCount % 4 != 0) pageCount++;
		List<String> typeList = Arrays.asList("MOT", "HOT", "PEN", "CAM", "GUE", "SPA");
		mav.addObject("typeList", typeList);
		mav.addObject("currentPage",currentPage);
		mav.addObject("PAGES", pageCount);
		mav.addObject("TYPE", TYPE);
		mav.addObject("LOC", LOC);
		mav.addObject("BODY","accListByLoc.jsp");
		mav.addObject("accList",accList);
		return mav;
	}
	
	@RequestMapping(value="/reserv/reserv.html")
	public ModelAndView reserv() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("BODY", "reserv.jsp");
		return mav;
	}
}
