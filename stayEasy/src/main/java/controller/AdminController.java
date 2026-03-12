package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.AccDao;
import dao.AdminDao;
import dao.InquireDao;
import dao.MyInformationDao;
import model.AccUpdate;
import model.Accommodation;
import model.Inquire;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomCompareDTO;
import model.RoomUpdate;
import model.StartEnd;
import model.UserInfo;

@Controller
public class AdminController {
    
    @Autowired
    private AdminDao adminDao;
    @Autowired
    private MyInformationDao myinformationDao;
    @Autowired
    private InquireDao inquireDao;
    @Autowired
    private AccDao accDao;
    
    @RequestMapping(value="/admin/rejectAccUpdateDo") //숙소 수정 신청 거절
    public ModelAndView rejectAccUpdateDo(HttpSession session, String acc_request_id,
    		String rejection_reason, RedirectAttributes redirectAttributes) {
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
        	ModelAndView mav = new ModelAndView("main");
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(acc_request_id));
    	accUpdate.setAcc_approval_status("승인거절");
    	accUpdate.setAcc_rejection_reason(rejection_reason);
    	this.accDao.updateAccUpdate(accUpdate);
    	
    	List<RoomUpdate> roomUpdate = this.accDao.getRoomUpdateList(Integer.parseInt(acc_request_id));
    	for(RoomUpdate r : roomUpdate) {
    		r.setRoom_approval_status("승인거절");
    		this.accDao.updateRoomUpdate(r);
    	}
    	
    	redirectAttributes.addFlashAttribute("msg", "숙소 수정 요청을 거절했습니다.");
    	redirectAttributes.addFlashAttribute("msgType", "rejecy");
    	
    	return new ModelAndView("redirect:/admin/adminAccAccept.html");
    }
    
    @RequestMapping(value="/admin/rejectAccUpdate.html") //숙소 수정 신청 거절 화면이동
    public ModelAndView rejectAccUpdate(HttpSession session, String acc_request_id) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(acc_request_id));
    	List<RoomUpdate> roomUpdate = this.accDao.getRoomUpdateList(Integer.parseInt(acc_request_id));
    	UserInfo user = this.myinformationDao.getUser(accUpdate.getUser().getUser_id());
    	
    	mav.addObject("user", user);
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("roomUpdate", roomUpdate);
    	mav.addObject("BODY","rejectAccUpdate.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/admin/approveAccUpdate.html") //숙소 수정 신청 승인
    public ModelAndView approveAccUpdate(HttpSession session, String acc_request_id, 
    		RedirectAttributes redirectAttributes) {
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
        	ModelAndView mav = new ModelAndView("main");
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(acc_request_id));
    	accUpdate.setAcc_approval_status("승인완료");
    	List<RoomUpdate> roomUpdate = this.accDao.getRoomUpdateList(Integer.parseInt(acc_request_id));
    	
    	//숙소 정보 업데이트
    	this.accDao.updateAccUpdate(accUpdate); //db에서 승인상태를 완료로 업데이트
    	this.accDao.updateAcc(accUpdate); //db에서 숙소 정보 업데이트
    	
    	//객실 정보 업데이트
    	for(RoomUpdate r : roomUpdate) {
    		r.setRoom_approval_status("승인완료");
    		this.accDao.updateRoomUpdate(r);
    		this.accDao.updateRoom(r);
    	}
    	
//    	//객실 수정사항 삭제
//    	List<Integer> roomReqId = this.accDao.getRoomReqIdList(Integer.parseInt(acc_request_id));
//    	for(Integer i : roomReqId) {
//    		this.accDao.deleteRoomRequest(i);
//    	}
//    	//슥소 수정사항 삭제
//    	this.accDao.deleteAccRequest(Integer.parseInt(acc_request_id));
    	
    	redirectAttributes.addFlashAttribute("msg", "숙소 수정 요청을 승인했습니다.");
    	redirectAttributes.addFlashAttribute("msgType", "success");

    	return new ModelAndView("redirect:/admin/adminAccAccept.html");
    }
    
    @RequestMapping(value="/admin/adminAccApproveDetail.html")
    public ModelAndView adminAccApproveDetail(HttpSession session, String accId, String accRequestId) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
    	Accommodation acc = this.accDao.getAccDetail(accId);
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(accRequestId));
    	List<Room> roomList = this.accDao.getRoomList(accId);
		List<RoomUpdate> roomUpdateList  = this.accDao.getRoomUpdateList(accUpdate.getAcc_request_id());
		
		// 1. room_id로 방 수정 요청 매핑
		Map<String, RoomUpdate> updateRoomMap = new HashMap<>();
		for (RoomUpdate update : roomUpdateList) {
		    updateRoomMap.put(update.getRoom().getId().getRoomId(), update); // room_id로 매핑
		}

		// 2. roomList 순서대로 RoomCompareDTO 생성
		List<RoomCompareDTO> roomCompareList = new ArrayList<>();
		for (Room room : roomList) {
		    RoomUpdate update = updateRoomMap.get(room.getId().getRoomId()); // room_id 기준 매칭
		    roomCompareList.add(new RoomCompareDTO(room, update)); // 없으면 null로 들어감
		}
    	
		mav.addObject("roomCompareList", roomCompareList);
    	mav.addObject("acc", acc);
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("BODY","adminAccApproveDetail.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/admin/adminAccAcceptDetail.html")
    public ModelAndView AccAcceptDetail(HttpSession session, String accId, String accRequestId) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
    	Accommodation acc = this.accDao.getAccDetail(accId);
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(accRequestId));
    	List<Room> roomList = this.accDao.getRoomList(accId);
		List<RoomUpdate> roomUpdateList  = this.accDao.getRoomUpdateList(accUpdate.getAcc_request_id());
		
		// 1. room_id로 방 수정 요청 매핑
		Map<String, RoomUpdate> updateRoomMap = new HashMap<>();
		for (RoomUpdate update : roomUpdateList) {
		    updateRoomMap.put(update.getRoom().getId().getRoomId(), update); // room_id로 매핑
		}

		// 2. roomList 순서대로 RoomCompareDTO 생성
		List<RoomCompareDTO> roomCompareList = new ArrayList<>();
		for (Room room : roomList) {
		    RoomUpdate update = updateRoomMap.get(room.getId().getRoomId()); // room_id 기준 매칭
		    roomCompareList.add(new RoomCompareDTO(room, update)); // 없으면 null로 들어감
		}
    	
		mav.addObject("roomCompareList", roomCompareList);
    	mav.addObject("acc", acc);
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("BODY","adminAccAcceptDetail.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/admin/adminAccAccept.html") //숙소 정보 수정 승인 리스트
    public ModelAndView adminUpdate(HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
    	List<AccUpdate> accUpdateList = this.accDao.getAccUpdateList(); //대기 리스트
    	 
    	mav.addObject("accUpdateList", accUpdateList);
    	mav.addObject("BODY","adminAccAccept.jsp");
    	return mav;
    }
    @RequestMapping(value="/admin/adminAccAcceptByAdmin.html") //숙소 정보 수정 승인 리스트
    public ModelAndView adminUpdateByAdmin(String userId) {
    	ModelAndView mav = new ModelAndView("main");
    	List<AccUpdate> accUpdateList = this.accDao.getAccUpdateListByUser(userId);
    	
    	mav.addObject("userID", userId);
    	mav.addObject("accUpdateList", accUpdateList);
    	mav.addObject("BODY","adminAccAccept.jsp");
    	return mav;
    }
    
    @RequestMapping("/admin/userInqList.html")
    public ModelAndView userInqList(HttpSession session, String userId, Integer pageNo) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

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
    
    // 사용자 조회-> 승인 대기 숙소 목록
    @RequestMapping("/admin/adminPendingAccByAdmin.html")
    public ModelAndView pendingAccommodationsByAdmin(HttpSession session, String userId) {
        ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

        List<Map<String, Object>> accommodations = adminDao.getPendingAccommodationsByAdmin(userId);

        // accommodation_id 값 강제 추가
        for (Map<String, Object> acc : accommodations) {
            if (!acc.containsKey("accommodation_id")) {
                acc.put("accommodation_id", acc.get("ACCOMMODATION_ID"));
            }
        }
        mav.addObject("user_Id", userId);
        mav.addObject("pendingAccommodations", accommodations);
        mav.addObject("BODY", "adminPendingAcc.jsp");
        return mav;
    }
    
    
    
    // 사용자 조회 -> 등록된 숙소 목록 조회
    @RequestMapping("/admin/adminRegisteredAccByAdmin.html")
    public ModelAndView registeredAccommodationsByAdmin(HttpSession session, String userId) {
        ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        

        List<Map<String, Object>> accommodations = adminDao.getRegisteredAccommodationsByAdmin(userId);

        // accommodation_id 값 강제 추가
        for (Map<String, Object> acc : accommodations) {
            if (!acc.containsKey("accommodation_id")) {
                acc.put("accommodation_id", acc.get("ACCOMMODATION_ID"));
            }
        }
        mav.addObject("registeredAccommodations", accommodations);
        mav.addObject("BODY", "adminRegisteredAcc.jsp");
        return mav;
    }
    
    @RequestMapping("/admin/userReservList.html") //사용자 조회 -> 사용자 예약목록 리스트
    public ModelAndView userReservList(HttpSession session, String userId) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        //사용자의 예약 리스트
        List<Reservation> reservList = this.myinformationDao.getReservList(userId);
        mav.addObject("reservList", reservList);
    	mav.addObject("BODY", "mypageAccList.jsp");
    	return mav;
    }
    
    // ✅ 사용자 관리 페이지 이동
    @RequestMapping("/admin/adminUserManagement.html")
    public ModelAndView userManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("main"); 
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "adminUserManagement.jsp"); // BODY에 adminUserManagement.jsp 설정
        return mav;
    }

    // ✅ 사용자 조회 페이지 (페이지 이동 및 조회 결과 처리)
    @RequestMapping("/admin/viewUserInfo.html")
    public ModelAndView viewUserInfo(
    		HttpSession session, @RequestParam(value = "user_id", required = false) String user_id) {
        ModelAndView mav = new ModelAndView("main");
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "adminViewUserInfo.jsp");

        if (user_id != null && !user_id.trim().isEmpty()) {
            UserInfo userInfo = adminDao.getUserInfoById(user_id.trim());
            
            if (userInfo != null) {
                mav.addObject("userInfo", userInfo); // 조회된 사용자 정보 추가
            } else {
                mav.addObject("error", "해당 아이디의 사용자가 없습니다.");
                mav.addObject("BODY", "adminUserManagement.jsp");
            }
        } else {
            mav.addObject("error", "사용자 아이디를 입력하세요.");
            mav.addObject("BODY", "adminUserManagement.jsp");
        }

        return mav;
    }
    
    // ✅ 등록된 숙소 목록 조회
    @RequestMapping("/admin/adminRegisteredAcc.html")
    public ModelAndView registeredAccommodations(HttpSession session) {
        ModelAndView mav = new ModelAndView("main");
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "adminRegisteredAcc.jsp");

        List<Map<String, Object>> accommodations = adminDao.getRegisteredAccommodations();

        // accommodation_id 값 강제 추가
        for (Map<String, Object> acc : accommodations) {
            if (!acc.containsKey("accommodation_id")) {
                acc.put("accommodation_id", acc.get("ACCOMMODATION_ID"));
            }
        }

        mav.addObject("registeredAccommodations", accommodations);
        return mav;
    }
    
    // ✅ 등록된 숙소 상세 조회 (app_status = 1인 숙소만)
    @RequestMapping("/admin/viewRegisteredAccommodationDetail.html")
    public ModelAndView viewRegisteredAccommodationDetail(
    		HttpSession session, @RequestParam("accommodationId") String accommodationId) {
        ModelAndView mav = new ModelAndView("main");
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "registeredAccommodationDetail.jsp");

        if (accommodationId == null || accommodationId.trim().isEmpty()) {
            mav.addObject("error", "숙소 ID가 전달되지 않았습니다.");
            return mav;
        }

        Map<String, Object> accommodation = adminDao.getRegisteredAccommodationById(accommodationId.trim());
        List<Map<String, Object>> roomList = adminDao.getRoomsByAccommodationId(accommodationId.trim());

        if (accommodation == null || accommodation.isEmpty()) {
            mav.addObject("error", "해당 숙소 정보를 찾을 수 없습니다.");
        } else {
            mav.addObject("accommodation", accommodation);
        }

        mav.addObject("rooms", roomList);

        return mav;
    }
    
    // ✅ 승인 대기 숙소 목록
    @RequestMapping("/admin/adminPendingAcc.html")
    public ModelAndView pendingAccommodations(HttpSession session) {
        ModelAndView mav = new ModelAndView("main");
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "adminPendingAcc.jsp");

        List<Map<String, Object>> accommodations = adminDao.getPendingAccommodations();

        // accommodation_id 값 강제 추가
        for (Map<String, Object> acc : accommodations) {
            if (!acc.containsKey("accommodation_id")) {
                acc.put("accommodation_id", acc.get("ACCOMMODATION_ID"));
            }
        }

        mav.addObject("pendingAccommodations", accommodations);
        return mav;
    }

    // ✅ 숙소 상세 정보 조회
    @RequestMapping("/admin/viewAccommodationDetail.html")
    public ModelAndView viewAccommodationDetail(HttpSession session,
    		@RequestParam("accommodationId") String accommodationId, String userId) {
        ModelAndView mav = new ModelAndView("main");
        LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        mav.addObject("BODY", "approveAccommodation.jsp");  

        if (accommodationId == null || accommodationId.trim().isEmpty()) {
            mav.addObject("error", "숙소 ID가 전달되지 않았습니다.");
            return mav;
        }

        Map<String, Object> accommodation = adminDao.getAccommodationById(accommodationId.trim());
        List<Map<String, Object>> roomList = adminDao.getRoomsByAccommodationId(accommodationId.trim());

        if (accommodation == null || accommodation.isEmpty()) {
            mav.addObject("error", "해당 숙소 정보를 찾을 수 없습니다.");
        } else {
            if (!accommodation.containsKey("accommodation_id")) {
                accommodation.put("accommodation_id", accommodation.get("ACCOMMODATION_ID"));
            }
            mav.addObject("accommodation", accommodation);
        }
        mav.addObject("userID", userId);
        mav.addObject("rooms", roomList);


        return mav;
    }        
    
    // ✅ 숙소 승인 처리
    @RequestMapping("/admin/approveAccommodation.html")
    public ModelAndView approveAccommodation(HttpSession session,
            @RequestParam("accommodationId") String accommodationId, String btn,
            RedirectAttributes redirectAttributes) {    	
    	if(btn.equals("승인")) {
    		System.out.println("승인입니다.");
    		adminDao.updateAccommodationStatus(accommodationId, 1); // app_status = 1 (승인 처리)
    		redirectAttributes.addFlashAttribute("message", "숙소 승인이 완료되었습니다.");
            return new ModelAndView("redirect:/admin/adminPendingAcc.html");  // 목록 페이지로 이동
    	}
    	else if(btn.equals("거절")) {
    		System.out.println("거절입니다.");
    		adminDao.updateAccommodationStatus(accommodationId, 2); // app_status = 2 (거절 처리)
    		redirectAttributes.addFlashAttribute("message", "숙소 거절이 완료되었습니다.");
            return new ModelAndView("redirect:/admin/adminPendingAcc.html");  // 목록 페이지로 이동
    	}
    	else {
    		redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
    		return new ModelAndView("redirect:/admin/adminPendingAcc.html");
    	}
    }

    // ✅ 승인 성공 페이지
    @RequestMapping("/admin/approvalSuccess.html")
    public ModelAndView approvalSuccess() {
        ModelAndView mav = new ModelAndView("main");
        mav.addObject("BODY", "approvalSuccess.jsp");
        return mav;
    }
}