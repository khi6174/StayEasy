package controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.AccDao;
import dao.AccDeleteDao;
import dao.InquireDao;
import dao.MyInformationDao;
import dao.UserDao;
import model.AccUpdate;
import model.Accommodation;
import model.Category;
import model.Inquire;
import model.LoginUser;
import model.Reservation;
import model.Room;
import model.RoomUpdate;
import model.User;
import model.UserInfo;
import pwdEncoder.PasswordEncoder;

@Controller
public class MypageController {

    @Autowired
    private MyInformationDao myinformationDao;
    @Autowired
    private InquireDao inquireDao;
    @Autowired
    private AccDao accDao;
    @Autowired
    private AccDeleteDao accDeleteDao;
    @Autowired
    private UserDao userDao;
    @Autowired
	private PasswordEncoder pwdEn;
    
    @RequestMapping(value="/mypage/changePwdDo.html",method=RequestMethod.POST)
    public ModelAndView changePwd(HttpSession session, String nowPwd,
    		String ChangePwd, String ConfirmPwd, RedirectAttributes redirectAttributes) {
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			ModelAndView mav = new ModelAndView("main");
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
		//회원 정보 불러오기
		String encodedPwd = pwdEn.encrypt(loginUser.getId(), nowPwd);
		String changeEnPwd = pwdEn.encrypt(loginUser.getId(), ChangePwd);
		String confirmEnPwd = pwdEn.encrypt(loginUser.getId(), ConfirmPwd);
		
		String userPwd = this.userDao.getUserPwd(loginUser.getId());
		if(encodedPwd.equals(userPwd)) { //현재 비밀번호가 db와 맞는지 확인
			
			if(changeEnPwd.equals(confirmEnPwd)) { //변경 비밀번호와 비밀번호 확인이 일치할 때 (비밀번호 변경 실시)
				//db에서 비밀번호 변경
				loginUser.setPassword(changeEnPwd);
				this.userDao.changeUserPwd(loginUser);
				redirectAttributes.addFlashAttribute("msg", "비밀번호를 변경했습니다.");
				return new ModelAndView("redirect:/mypage/mypageMain.html");
			}
			else { //변경 비밀번호 확인이 일치하지 않을 때
				redirectAttributes.addFlashAttribute("msg", "변경할 비밀번호가 일치하지 않습니다.");
				return new ModelAndView("redirect:/mypage/changePwd.html");
			}
		}
		else { //현재 비밀번호가 db와 일치하지 않을 때
			redirectAttributes.addFlashAttribute("msg", "현재 비밀번호가 틀립니다.");
			return new ModelAndView("redirect:/mypage/changePwd.html");
		}
		
    }
    
    @RequestMapping(value="/mypage/changePwd.html")
    public ModelAndView changePwd(HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	mav.addObject("BODY","changePwd.jsp");
    	return mav;
    }
    
    //내 숙소 상세보기
    @RequestMapping(value="/mypage/myAccDetail.html")
    public ModelAndView myAccDetail(String accId, HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	Accommodation accommodation = this.accDao.getAccDetail(accId);
    	List<Room> roomList = this.accDao.getRoomList(accId);
    	mav.addObject("accommodation", accommodation);
    	mav.addObject("rooms", roomList);
    	mav.addObject("BODY","myAccDetail.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/mypage/accRejectDetail.html")
    public ModelAndView accRejectDeatil(String accReqId, HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	AccUpdate accUpdate = this.accDao.getAccUpdate(Integer.parseInt(accReqId));
    	Accommodation acc = this.accDao.getAccDetail(accUpdate.getAccommodation().getAccommodation_id());
    	List<Room> roomList = this.accDao.getRoomList(acc.getAccommodation_id());
    	List<RoomUpdate> roomUpdate = this.accDao.getRoomUpdateList(Integer.parseInt(accReqId));
    	
    	mav.addObject("roomList", roomList);
    	mav.addObject("roomUpdate", roomUpdate);
    	mav.addObject("acc", acc);
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("BODY", "accRejectDetail.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/mypage/accUpdateList.html")
    public ModelAndView accUpdateList(HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	List<AccUpdate> accUpdate = this.accDao.getAccUpdateListByUser(loginUser.getId());
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("BODY", "accUpdateList.jsp");
    	return mav;
    }
    
    //내 숙소 -> 숙소 삭제하기
    @RequestMapping(value="/mypage/deleteAccommodation.html", method=RequestMethod.POST)
    public ModelAndView deleteAccommodation(String accId, RedirectAttributes redirectAttributes,
    		HttpSession session) {
    	List<String> reservIdList = this.accDeleteDao.getReservIdList(accId);
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			ModelAndView mav = new ModelAndView("main");
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	
    	for(String s : reservIdList) {
    		this.accDeleteDao.deleteReview(s); //숙소에 달린 리뷰 삭제
    		this.accDeleteDao.deleteInq(s); //숙소에 대한 문의 삭제
    	}
    	this.accDeleteDao.deleteCartItem(accId); //숙소를 담아놓은 장바구니 항목 삭제
    	this.accDeleteDao.deleteRoomUpdate(accId); //객실 수정 신청사항 삭제
    	this.accDeleteDao.deleteAccUpdate(accId); //숙소 수정 신청사항 삭제
    	this.accDeleteDao.deleteReserv(accId); //숙소 예약 목록 삭제
    	this.accDeleteDao.deleteRoom(accId); //객실 정보 삭제
    	this.accDeleteDao.deleteAcc(accId); //숙소 정보 삭제
    	
    	redirectAttributes.addFlashAttribute("msg", "숙소를 삭제했습니다.");
    	
    	return new ModelAndView("redirect:/acc/myAccommodations.html");
    }
    
    @RequestMapping(value="/mypage/accUpdateDo.html", method=RequestMethod.POST)
    public ModelAndView accUpdateDo(HttpSession session, AccUpdate accUpdate,
    		@RequestParam("roomPhotos") List<MultipartFile> roomPhotos,
    		MultipartFile mainPhoto, String old_mainPhoto, RedirectAttributes redirectAttributes) {
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			ModelAndView mav = new ModelAndView("main");
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	List<RoomUpdate> roomUpdates = accUpdate.getRoomUpdates();
    	
    	//숙소 사진 처리
        if (mainPhoto != null && !mainPhoto.isEmpty()) { //새로 업로드 된 숙소 대표사진 처리
            String fileName = mainPhoto.getOriginalFilename();
            String path = session.getServletContext().getRealPath("/imgs/" + fileName);
            try (OutputStream os = new FileOutputStream(path);
                 BufferedInputStream bis = new BufferedInputStream(mainPhoto.getInputStream())) {
                byte[] buffer = new byte[8156];
                int read;
                while ((read = bis.read(buffer)) > 0) {
                    os.write(buffer, 0, read);
                }
                accUpdate.setAcc_image(fileName); // 새 이미지 저장
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            //업로드 안 했을 때 기존 이미지 유지
        	accUpdate.setAcc_image(old_mainPhoto);
        }
        
        
        //방 사진 처리
    	for(int i=0; i < roomPhotos.size(); i++) {
    		RoomUpdate roomUpdate = roomUpdates.get(i);
            MultipartFile photo = roomPhotos.get(i); // 각 방에 대한 사진
            
    		if(!photo.isEmpty()) { //새로 업로드 된 방 사진처리
    			String fileName = photo.getOriginalFilename();
    			String path = session.getServletContext().getRealPath("/imgs/" + fileName);
    			try (OutputStream os = new FileOutputStream(path);
    	                BufferedInputStream bis = new BufferedInputStream(photo.getInputStream())) {
    	                byte[] buffer = new byte[8156];
    	                int read;
    	                while ((read = bis.read(buffer)) > 0) {
    	                    os.write(buffer, 0, read);
    	                }
    	                roomUpdate.setRoom_image(fileName);
    	            } catch (Exception e) {
    	                e.printStackTrace();
    	            }
    			
    		}
    		else { //새로 업로드 안했을 때 기존 이미지 유지
    			roomUpdate.setRoom_image(roomUpdate.getRoom_image());
    		}
    		
    	}
    	
    	//슥소 수정 id 최댓값
        Integer accRequest_id = this.accDao.getMaxAccRequest();
        if(accRequest_id == null || accRequest_id == 0) {
        	accRequest_id = 1;
        	accUpdate.setAcc_request_id(accRequest_id);
        }
        else {
        	accUpdate.setAcc_request_id(accRequest_id + 1);
        }
        accUpdate.setPrice_per_night(0);
        accUpdate.setAcc_approval_status("대기");
        accUpdate.setAcc_rejection_reason("없음");
        
        //숙소 수정 db삽입
        this.accDao.insertAccUpdate(accUpdate);
        int a[] = new int[roomUpdates.size()];
        int i = 0;
        
        //객실 수정 id 최댓값
        for(RoomUpdate ru : roomUpdates) {
        	Integer roomRequest_id = this.accDao.getMaxRoomRequest();
            if(roomRequest_id == null || roomRequest_id == 0) {
            	roomRequest_id = 1;
            	ru.setRoom_request_id(roomRequest_id);
            }
            else {
            	ru.setRoom_request_id(roomRequest_id + 1);
            }
        	User user = accUpdate.getUser();
        	ru.setUser(user);
        	ru.setRoom_approval_status("대기");
        	ru.setRoom_rejection_reason("없음");
        	
        	ru.setAccUpdate(accUpdate);
        	//객실 수정 db삽입
        	this.accDao.insertRoomUpdate(ru);
        	a[i] = ru.getPrice_per_night();
        	i++;
        }
        
        //객실 3개의 가격 중 제일 낮은 가격을 숙소 가격으로 함
        int accPrice = Math.min(a[0], Math.min(a[1], a[2]));
        
        accUpdate.setPrice_per_night(accPrice);
        this.accDao.updateAccUpdatePrice(accPrice);
        accUpdate.setRoomUpdates(roomUpdates); //숙소의 객실 정보 수정 신청
        
        redirectAttributes.addFlashAttribute("successMessage", "숙소 및 객실 정보 수정 신청이 완료되었습니다.");
    	
    	return new ModelAndView("redirect:/acc/myAccommodations.html");
    }
    
    @RequestMapping(value="/mypage/accUpdate.html") //숙소 수정하기
    public ModelAndView accUpdate(String accId, HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	Accommodation acc = this.accDao.getAccDetail(accId);
    	User user = acc.getUser();
    	AccUpdate accUpdate = new AccUpdate();
    	accUpdate.setAccommodation(acc);
    	accUpdate.setUser(user);
    	accUpdate.setAccname(acc.getAccname());
    	accUpdate.setLocation(acc.getLocation());
    	accUpdate.setDescription(acc.getDescription());
    	accUpdate.setCategory(new Category());
    	accUpdate.getCategory().setCategory_id(acc.getCategory().getCategory_id());
    	
    	List<Room> roomList = this.accDao.getRoomList(accId);
    	
    	mav.addObject("roomList",roomList);
    	mav.addObject("accUpdate", accUpdate);
    	mav.addObject("BODY","updateAccommodation.jsp");
    	return mav;
    }
    
    @RequestMapping(value="/mypage/cancelReserv.html")
    public ModelAndView cancelReserv(String reservation_id,HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	//예약의 모든 문의 가져오기
    	List<Inquire> inqList = this.inquireDao.getInq(reservation_id);
    	for(Inquire i : inqList) {
    		int inqId = i.getInquire_id();
    		this.inquireDao.deleteInquire(inqId); //db에서 예약과 관련된 모든 문의 삭제
    	}
    	
    	this.myinformationDao.deleteReserv(reservation_id); //db에서 예약정보 삭제
    	return new ModelAndView("redirect:/mypage/accList.html");
    }

    @RequestMapping(value="/mypage/accList.html") //나의 예약 리스트
    public ModelAndView accList(HttpSession session) {
    	ModelAndView mav = new ModelAndView("main");
    	LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
    	
    	List<Reservation> reservList = this.myinformationDao.getReservList(loginUser.getId());
    	for(Reservation item : reservList) {
    		// Date -> LocalDate 변환 (시간 정보 제거)
	    	LocalDate checkInDate = item.getCheck_in_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	    	LocalDate checkOutDate = item.getCheck_out_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	    	// 일수 차이 계산
	    	long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
	    	item.setNights(nights);
    	}
    	
    	// 오늘 날짜 추가
        mav.addObject("today", new java.sql.Date(System.currentTimeMillis()));
    	mav.addObject("reservList",reservList);
    	mav.addObject("BODY","mypageAccList.jsp");
    	return mav;
    }

    // 마이페이지 메인 (회원 정보 조회)
    @RequestMapping(value="/mypage/mypageMain.html")
    public ModelAndView mypageMain(HttpSession session) {
        ModelAndView mav = new ModelAndView("main");
        
        //로그인 여부 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

        UserInfo user = this.myinformationDao.getUser(loginUser.getId());
        mav.addObject("BODY", "mypage.jsp");
        mav.addObject("userInfo", user); // ✅ user 객체 추가
        return mav;
    }
    

    // ✅ 회원 정보 수정 (POST /mypage/update.html)
    @RequestMapping(value="/mypage/update.html")
    public ModelAndView modify(@Valid UserInfo userInfo, BindingResult br, HttpSession session
    		,RedirectAttributes redirectAttributes) {
        ModelAndView mav = new ModelAndView("main");
        
        //로그인 검사
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        
        //폼체크
        if (br.hasErrors()) {
            mav.addObject("BODY", "mypage.jsp");
            mav.getModel().putAll(br.getModel());
            return mav;
        }
        
        UserInfo user = this.myinformationDao.getUser(userInfo.getUser_id());
        //입력받은 비밀번호 암호화
        String userInfoEnPwd = pwdEn.encrypt(userInfo.getUser_id(), userInfo.getUser_pwd());
        
        //틀린 비밀번호 입력 시
        if(!user.getUser_pwd().equals(userInfoEnPwd)) {
        	redirectAttributes.addFlashAttribute("msg", "비밀번호가 틀립니다.");
        	return new ModelAndView("redirect:/mypage/mypageMain.html");
        }
        
        this.myinformationDao.updateMyInfomation(userInfo);

        redirectAttributes.addFlashAttribute("msg", "회원정보가 수정되었습니다.");
    	return new ModelAndView("redirect:/mypage/mypageMain.html");
    }
    
    
	
    // 마이페이지 기본 화면 (기본 index.html 대신 사용 가능)
    @RequestMapping(value="/mypage/index.html")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("main");
        mav.addObject("BODY", "mypage.jsp");
        return mav;
    }
}