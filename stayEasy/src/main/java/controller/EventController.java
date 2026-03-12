package controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.EventDao;
import model.Event;
import model.LoginUser;
import model.StartEnd;
import utils.FileValidator;

@Controller
public class EventController {
	@Autowired
	private FileValidator fileValidator;
	@Autowired
	private EventDao eventDao;
	
	
	@RequestMapping(value="/event/modify.html")
	public ModelAndView modify(@Valid Event event, BindingResult br, String BTN, 
			Integer event_id, HttpSession session, RedirectAttributes redirectAttributes) {
	    ModelAndView mav = new ModelAndView("main");
	    
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        //관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        
	    if (br.hasErrors()) {
	        mav.addObject("BODY", "eventDetailAdmin.jsp");
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }

	    if (BTN.equals("삭 제")) {
	        this.eventDao.deleteEvent(event.getEvent_id());
	        redirectAttributes.addFlashAttribute("msg", "이벤트 삭제를 완료했습니다.");
		    return new ModelAndView("redirect:/event/eventList.html");
	    } else if (BTN.equals("수 정")) {
	        Event oldEvent = this.eventDao.getEvent(event.getEvent_id());

	        // 파일 업로드 확인 및 처리
	        MultipartFile multiFile = event.getImage();
	        if (multiFile != null && !multiFile.isEmpty()) {
	            String fileName = multiFile.getOriginalFilename();
	            String path = session.getServletContext().getRealPath("/imgs/" + fileName);
	            try (OutputStream os = new FileOutputStream(path);
	                 BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
	                byte[] buffer = new byte[8156];
	                int read;
	                while ((read = bis.read(buffer)) > 0) {
	                    os.write(buffer, 0, read);
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            event.setEvent_image(fileName);
	        } else {
	            event.setEvent_image(oldEvent.getEvent_image());
	        }

	        // 날짜 NULL이면 기존 값 유지
	        if (event.getStart_date() == null) {
	            event.setStart_date(oldEvent.getStart_date());
	        }
	        if (event.getEnd_date() == null) {
	            event.setEnd_date(oldEvent.getEnd_date());
	        }
	        if (event.getE_date() == null) {
	            event.setE_date(oldEvent.getE_date());
	        }

	        this.eventDao.updateEvent(event);
	        redirectAttributes.addFlashAttribute("msg", "이벤트 수정을 완료했습니다.");
		    return new ModelAndView("redirect:/event/eventList.html");
	    }
	    return mav;
	}
	
	
	
	@RequestMapping(value="/event/eventWrite.html")
	public ModelAndView writeform(HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        //관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
		mav.addObject( new Event());
		mav.addObject("BODY","eventWrite.jsp");
		return mav;
	}
	
	@RequestMapping(value="/event/write.html")
	public ModelAndView write(@Valid Event event, 
	                          BindingResult br, HttpSession session, RedirectAttributes redirectAttributes) {
	    this.fileValidator.validate(event, br);//파일 선택 유무를 검사한다.
	    ModelAndView mav = new ModelAndView("main");
	    
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        //관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

	    if (br.hasErrors()) {
	        mav.addObject("BODY", "eventWrite.jsp");
	        mav.getModel().putAll(br.getModel());
	        return mav; // 유효성 검사가 실패했으면 바로 리턴해야 함.
	    }

	    ///이미지 파일 업로드 및 DB에 삽입
	    MultipartFile multipart = event.getImage();//선택한 파일을 불러온다.
	    String fileName = null;
	    String path = null;
	    OutputStream os = null;

	    if (multipart != null && !multipart.isEmpty()) { // 파일이 선택됐을 때만 업로드
	        fileName = multipart.getOriginalFilename();//선택한 파일의 이름을 찾는다.
	        ServletContext ctx = session.getServletContext();//ServletContext 생성
	        path = ctx.getRealPath("/imgs/" + fileName);// upload 폴더의 절대 경로를 획득
	        
	        // 여기에 추가!
	        System.out.println("파일명: " + multipart.getOriginalFilename());
	        System.out.println("업로드 경로: " + path);
	        System.out.println("파일 크기: " + multipart.getSize());
	        try {
	            os = new FileOutputStream(path);//OutputStream을 생성한다.즉, 파일 생성
	            BufferedInputStream bis = new BufferedInputStream(multipart.getInputStream());
	            byte[] buffer = new byte[8156];
	            int read = 0;
	            while ((read = bis.read(buffer)) > 0) {
	                os.write(buffer, 0, read);
	            }
	        } catch (Exception e) {
	            System.out.println("파일 업로드 중 문제 발생! " + e.getMessage());
	        } finally {
	            try {
	                if (os != null) os.close();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }

	        event.setEvent_image(fileName);
	    } else {
	        // 파일 선택 안 했으면 기본 이미지 설정
	        event.setEvent_image("default.png");
	    }
	    int maxNum = this.eventDao.getMaxNum() + 1;
	    event.setEvent_id(maxNum);
	    event.setE_date(new Date()); // 현재 날짜 설정 (이 부분 중요)
	    this.eventDao.putEventImage(event);
	    
	    redirectAttributes.addFlashAttribute("msg", "이벤트 작성을 완료했습니다.");
	    return new ModelAndView("redirect:/event/eventList.html");
	}

	
	@RequestMapping(value="/event/detail.html")
	public ModelAndView detail(Integer event_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		Event event = this.eventDao.getEvent(event_id);
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		mav.addObject(event);
		if(user != null && user.getId().equals("admin")) {//관리자로 로그인 한 경우
			mav.addObject("BODY","eventdetailAdmin.jsp");//form:form
		}else {//관리자가 아닌 경우
			mav.addObject("BODY","eventdetail.jsp");//form:form
		}
		return mav;
	}
	@RequestMapping(value="/event/eventList.html")
	public ModelAndView eventList(Integer pageNo) {
		ModelAndView mav = new ModelAndView("main");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 6;
		int end = ((currentPage - 1) * 6) + 7;
		StartEnd se = new StartEnd(); se.setStart(start); se.setEnd(end);
		List<Event> eventList = this.eventDao.getEventList(se);
		int totalCount = this.eventDao.getEventCount();
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		mav.addObject("currentPage",currentPage);
		mav.addObject("PAGES", pageCount);
		mav.addObject("BODY","event.jsp");
		mav.addObject("EVENT",eventList);
		return mav;
	}


}
