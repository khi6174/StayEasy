package controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.NoticeDao;
import model.LoginUser;
import model.Notice;
import model.StartEnd;

@Controller
public class NoticeController {
	@Autowired
	private NoticeDao noticeDao;
	
	@RequestMapping(value="/notice/modify.html")
	public ModelAndView modify(Integer NUM,String TITLE,String CONTENT,String BTN) {
		ModelAndView mav = new ModelAndView("index");
		if(BTN.equals("삭 제")) {
			this.noticeDao.deleteNotice(NUM);
			mav.addObject("BODY","noticeDeleteResult.jsp");
		}else if(BTN.equals("수 정")) {
			Notice notice = new Notice();
			notice.setNum(NUM); notice.setTitle(TITLE); notice.setContent(CONTENT);
			this.noticeDao.updateNotice(notice);
			mav.addObject("BODY","noticeUpdateResult.jsp");
		}
		return mav;
	}
	
	@RequestMapping(value="/notice/modifyFF.html")
	public ModelAndView modifyFF(@Valid Notice notice, BindingResult br, String BTN) {
		ModelAndView mav = new ModelAndView("index");
		if(br.hasErrors()) {
			mav.addObject("BODY","noticeDetailAdminFF.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		if(BTN.equals("삭 제")) {
			this.noticeDao.deleteNotice(notice.getNum());
			mav.addObject("BODY","noticeDeleteResult.jsp");
		}else if(BTN.equals("수 정")) {
			this.noticeDao.updateNotice(notice);
			mav.addObject("BODY","noticeUpdateResult.jsp");
		}
		return mav;
	}
	
	@RequestMapping(value="/notice/detail.html")
	public ModelAndView detail(Integer NO, HttpSession session) {
		Notice notice = this.noticeDao.getNotice(NO);//글번호로 공지글 검색
		ModelAndView mav = new ModelAndView("index");
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		//mav.addObject("NOTICE",notice);
		mav.addObject(notice);//조회결과 객체 주입
		if(user != null && user.getId().equals("admin")) {//관리자로 로그인 한 경우
			//mav.addObject("BODY","noticeDetailAdmin.jsp");//일반 form
			mav.addObject("BODY","noticeDetailAdminFF.jsp");//form:form
		}else {//관리자가 아닌 경우
			//mav.addObject("BODY","noticeDetail.jsp");//일반 form
			mav.addObject("BODY","noticeDetailFF.jsp");//form:form
		}
		return mav;
	}
	
	@RequestMapping(value="/notice/list.html")
	public ModelAndView noticeList(Integer pageNo) {
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 5;
		int end = ((currentPage - 1) * 5) + 6;
		StartEnd se = new StartEnd(); se.setStart(start); se.setEnd(end);
		List<Notice> noticeList = this.noticeDao.getNoticeList(se);
		int totalCount = this.noticeDao.getCount();
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("currentPage",currentPage);
		mav.addObject("PAGES", pageCount);
		mav.addObject("BODY","noticeList.jsp");
		mav.addObject("NOTICES",noticeList);//검색 결과를 저장한다.
		return mav;
	}
	
	@RequestMapping(value="/notice/putForm.html")
	public ModelAndView inputform(@Valid Notice notice, BindingResult br, 
				HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		if(br.hasErrors()) {
			mav.addObject("BODY","notice_inputForm.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		String id = user.getId();
		int num = this.noticeDao.getMaxNum() + 1;
		notice.setNum(num);//글번호 설정
		notice.setWriter(id);//작성자 설정
		this.noticeDao.putNotice(notice);
		mav.addObject("BODY","noticeInputResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/notice/formform.html")
	public ModelAndView formform() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject(new Notice());//주입할 인스턴스 생성
		mav.addObject("BODY","notice_inputForm.jsp");
		return mav;
	}
	
	@RequestMapping(value="/notice/inputForm.html")
	public ModelAndView form() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","notice_input.jsp");
		return mav;
	}
	
	@RequestMapping(value="/notice/input.html")
	public ModelAndView input(String TITLE, String CONTENT, HttpSession session) {
		Notice notice = new Notice();
		int num = this.noticeDao.getMaxNum() + 1;
		notice.setNum(num); //공지글 설정
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		notice.setWriter(user.getId());//작성자 설정
		notice.setTitle(TITLE); notice.setContent(CONTENT);
		this.noticeDao.putNotice(notice);//공지글을 DB에 삽입
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","noticeInputResult.jsp");
		return mav;
	}
}












