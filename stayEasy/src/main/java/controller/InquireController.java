	package controller;
	
	import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.AccDao;
import dao.InquireDao;
import model.Accommodation;
import model.Inquire;
import model.LoginUser;
import model.Reservation;
import model.StartEnd;
import model.User;
	
	
	@Controller
	public class InquireController {
		
	    @Autowired
	    private InquireDao inquireDao;
	    @Autowired 
	    private AccDao accDao;
	    
	    @RequestMapping(value="/inquire/replyDo.html") //문의 답변하기(관리자)
	    public ModelAndView replyDo(HttpSession session, Inquire inq) {
	    	ModelAndView mav = new ModelAndView("main");
	    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    	//관리자 로그인 체크
	        if (loginUser == null || !"admin".equals(loginUser.getId())) {
	            mav.addObject("BODY","login.jsp");
	            mav.addObject(new LoginUser());
	            return mav;
	        }
	        
	        //이때 inq는 답변에 대한 객체이지만 inquire_id는 아직 문의에 대한 값임
	        int parent_id = inq.getInquire_id();
	        int group_id = inq.getGroup_id();
	        
	    	//원글 정보 가져오기
	    	Inquire parentInq = this.inquireDao.getInquireDetail(parent_id);
	    	
	    	Reservation reservation = this.accDao.getReservation(parentInq.getReservation().getReservation_id());
	    	
	    	//새 답변 문의ID 생성
	    	Integer maxNum = this.inquireDao.countInqId();
	    	int newInqId = (maxNum == null) ? 1 : maxNum + 1;
	    	
	    	//그룹 내 순서 지정(order_no)
	    	Integer maxOrderNo = this.inquireDao.getMaxOrder(group_id);
	    	int orderNo = (maxOrderNo == null) ? 1 : maxOrderNo + 1;
	    	
	    	//답변 데이터 구성
	    	Inquire reply = new Inquire();
	    	reply.setInquire_id(newInqId);
	    	reply.setParent_id(parentInq.getInquire_id());
	    	reply.setGroup_id(parentInq.getGroup_id());
	    	reply.setReservation(reservation);
	    	reply.setOrder_no(orderNo);
	    	reply.setStatus("관리자 답변");
	    	reply.setTitle("Re] " + parentInq.getTitle());
	    	reply.setContent(inq.getContent());
	    	reply.setUser(new User());
	    	reply.getUser().setUser_id(loginUser.getId());
	    	
	    	//답변 저장
	    	this.inquireDao.putInquire(reply);
	    	
	    	//원글 상태 업데이트
	    	this.inquireDao.setStatus(parentInq.getInquire_id(), "답변완료");
	    	
	    	return new ModelAndView("redirect:/inquire/inquireList.html");
	    }
	    
	    @RequestMapping(value="/inquire/inquireReply.html") //문의 답변하기 화면(관리자)
	    public ModelAndView reply(HttpSession session, Integer inquire_id, 
	    		Integer parent_id, Integer group_id, String status) {
	    	ModelAndView mav = new ModelAndView("main");
	    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    	if(loginUser.getId() == null || !"admin".equals(loginUser.getId())) {
	    		mav.addObject("BODY","login.jsp");
	    		mav.addObject(new LoginUser());
	    		System.out.println("로그인이 안되었거나 관리자 계정이 아닙니다.");
	    		return mav;
	    	}
	    	
	    	//문의 정보 가져오기
	    	Inquire inquire = this.inquireDao.getInquireDetail(inquire_id);
	    	String reserv_id = inquire.getReservation().getReservation_id(); //문의 예약번호 가져옴
	    	Date i_date = inquire.getI_date(); //문의 작성 날짜
	    	
	    	//문의한 예약 정보 가져오기
	    	Reservation reservation = this.accDao.getReservation(reserv_id);
	        reservation.setReservation_id(reserv_id);
	        inquire.setReservation(reservation);
	        Accommodation acc = this.accDao.getAccDetail(reservation.getRoom().getId().getAccommodationId());
	        
	        String ReTitle = "RE]"+inquire.getTitle();
	        
	        mav.addObject("acc", acc);
	        mav.addObject("reservation", reservation);
	    	mav.addObject("i_date", i_date);
	    	mav.addObject("title", ReTitle);
	    	mav.addObject("content",inquire.getContent());
	    	mav.addObject("reserv_id",reserv_id);
	    	mav.addObject("BODY","inquireWriteAdmin.jsp");
	    	mav.addObject("inquire",inquire);
	    	
	    	return mav;
	    }
	    
		@RequestMapping(value="/inquire/modify.html")
		public ModelAndView modify(@Valid Inquire inquire, BindingResult br, 
				String BTN, Integer event_id, HttpSession session, RedirectAttributes redirectAttributes) {
		    ModelAndView mav = new ModelAndView("main");
		    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	        //로그인 체크
	        if (loginUser == null) {
	            mav.addObject("BODY","login.jsp");
	            mav.addObject(new LoginUser());
	            return mav;
	        }
		    if (br.hasErrors()) {
		        mav.addObject("BODY", "inquireDetailOwner.jsp");
		        mav.getModel().putAll(br.getModel());
		        return mav;
		    }
	
		    if (BTN.equals("삭 제")) {
		        this.inquireDao.deleteInquire(inquire.getInquire_id());
		        redirectAttributes.addFlashAttribute("msg", "문의를 삭제했습니다.");
		        return new ModelAndView("redirect:/inquire/inquireList.html");
		    } else if (BTN.equals("수 정")) {
		        this.inquireDao.updateInquire(inquire);
		        redirectAttributes.addFlashAttribute("msg", "문의를 수정했습니다.");
		        return new ModelAndView("redirect:/inquire/inquireList.html");
		    }
	
		    return mav;
		}
	    
		//문의 작성하기 화면(사용자)
		@RequestMapping(value="/inquire/inquireWrite.html", method=RequestMethod.GET)
	    public ModelAndView writeform(HttpSession session) {
	        ModelAndView mav = new ModelAndView("main");
	        // 로그인된 사용자 정보 가져오기
	        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            mav.addObject("BODY", "login.jsp");
	            mav.addObject(new LoginUser());
	            return mav;
	        }
	
	        // 사용자의 예약 리스트
	        List<Reservation> reservation = accDao.getUserReservation(loginUser.getId());
	        for(Reservation r : reservation) {
	        	String accId = r.getRoom().getId().getAccommodationId();
	        	Accommodation acc = this.accDao.getAccDetail(accId);
	        	r.getRoom().setAccommodation(acc);
	        }
	        
	        mav.addObject("reservList", reservation);
	
	        // 문의 객체 생성 및 사용자, 예약 정보 설정
	        Inquire inquire = new Inquire();
	        
	        //문의번호 최대 값 + 1
	        Integer inq_id = this.inquireDao.countInqId(); 
	        if(inq_id == null || inq_id == 0) {
	        	inq_id = 1;
	        } else {
	        	inq_id +=1;
	        }
	    	inquire.setInquire_id(inq_id);
	        
	        mav.addObject("inquire", inquire);
	        mav.addObject("BODY", "inquireWrite.jsp");
	        
	        return mav;
	    }
		
		//문의 올리기(사용자)
		@RequestMapping(value="/inquire/write.html", method=RequestMethod.POST)
		public ModelAndView write(@Valid Inquire inquire, BindingResult br, 
				HttpSession session, RedirectAttributes redirectAttributes) {
		    ModelAndView mav = new ModelAndView("main");
		    String reservationId = inquire.getReservation().getReservation_id(); //예약 번호
		    Reservation reservation = this.accDao.getReservation(reservationId);
		    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		    
		    // 로그인 사용자 확인
		    if (loginUser == null) {
		        mav.addObject("BODY", "login.jsp");
		        mav.addObject(new LoginUser());
		        return mav;
		    }
		    
		    List<Reservation> reservList = accDao.getUserReservation(loginUser.getId());
		    
		    // 유효성 검사 실패 시
		    if (br.hasErrors()) {
		        mav.addObject("BODY", "inquireWrite.jsp");
		        mav.addObject("reservList",reservList);
		        mav.getModel().putAll(br.getModel());
		        return mav;
		    }
	
		    //예약번호
		    String reserv_id = this.inquireDao.getReservId(inquire.getInquire_id());
		    mav.addObject("reserv_id",reserv_id);
		    
		    // 예약 정보 없을 때 예외 처리
		    if (reservation == null) {
		        mav.addObject("errorMessage", "최근 예약 정보가 없습니다. 예약 후 문의를 등록하세요.");
		        System.out.println("예약 정보 없음");
		        mav.addObject("BODY", "inquireWrite.jsp");
		        return mav;
		    }
	
		    // 문의 정보 세팅
		    inquire.setParent_id(0); //원글이므로 부모 번호 0
		    inquire.setOrder_no(0);  //원글이므로 그룹 내 순서 0
		    inquire.setGroup_id(inquire.getInquire_id());
		    inquire.setStatus("대기"); //답변 상태
		    inquire.setUser(new User());
		    inquire.getUser().setUser_id(loginUser.getId()); //사용자 Id
		    inquire.setReservation(reservation); // 예약 정보 세팅
		    
		    // 최종 저장
		    this.inquireDao.putInquire(inquire);
		    
		    // 결과 페이지 이동
		    redirectAttributes.addFlashAttribute("msg", "문의작성이 완료되었습니다.");
		    return new ModelAndView("redirect:/inquire/inquireList.html");
		}
	
	
	    /**
	     * 문의 내용을 실제 DB에 저장하는 메소드 (POST)
	     */
	   
	    @RequestMapping(value="/inquire/inquireList.html")
	    public ModelAndView list(HttpSession session, Integer pageNo) {
	    	ModelAndView mav = new ModelAndView("main");
	        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            mav.addObject("BODY", "login.jsp");
	            mav.addObject(new LoginUser());
	            return mav;
	        }
	        String userId = loginUser.getId(); // 현재 로그인한 사용자 ID
	        
	    	int currentPage = 1;
	    	if(pageNo != null) currentPage = pageNo;
	    	int start =(currentPage-1) * 4;
	    	int end = ((currentPage-1)*4)+5;
	    	StartEnd se = new StartEnd();se.setStart(start);se.setEnd(end); se.setUserId(userId);  // 🔥 추가: 현재 로그인한 user_id를 필터링 조건으로 전달
	    	List<Inquire> inquireList;
	        if ("admin".equals(userId)) {
	            // 🔥 admin은 모든 문의 조회
	            inquireList = this.inquireDao.getInquireList(se);
	        } else {
	            // 🔥 일반 사용자는 본인의 문의 + admin이 작성한 문의만 조회
	            inquireList = this.inquireDao.getInquireListByUser(se);
	        }
	        int totalCount = "admin".equals(userId) ? this.inquireDao.getInquireCountAll() : this.inquireDao.getInquireCountUser(userId);
	    	int pageCount = totalCount/4;
	    	if(totalCount %4 !=0) pageCount++;
	    	mav.addObject("currentPage",currentPage);
	    	mav.addObject("PAGES",pageCount);
	    	mav.addObject("BODY","inquireList.jsp");
	    	mav.addObject("INQUIRE",inquireList);
	    	return mav;
	    }
	
		@RequestMapping(value="/inquire/detail.html")
		public ModelAndView readinquire(Integer inquire_id, HttpSession session) {
			ModelAndView mav = new ModelAndView("main");
			
			//원글 가져오기
			Inquire inquire = this.inquireDao.getInquireDetail(inquire_id);
			mav.addObject("inquire",inquire);
			
			//답글 가져오기
			Inquire reply = this.inquireDao.getReply(inquire_id);
			mav.addObject("reply", reply);
			
			LoginUser user = (LoginUser)session.getAttribute("loginUser");
		        if (user != null && user.getId().equals("admin")) {
		            mav.addObject("BODY", "inquireDetailAdmin.jsp");
		        } else {
		            mav.addObject("BODY", "inquireDetailOwner.jsp");
		        } 
	
		    return mav;
		}
	
	
	}