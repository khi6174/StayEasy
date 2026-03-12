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
	public ModelAndView modify(@Valid Notice notice, BindingResult br, String BTN, HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
		if(br.hasErrors()) {
			mav.addObject("BODY","noticeDetailAdminFF.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		if(BTN.equals("삭 제")) {
			this.noticeDao.deleteNotice(notice.getNotice_id());
			mav.addObject("BODY","noticeDeleteResult.jsp");
		}else if(BTN.equals("수 정")) {
			this.noticeDao.updateNotice(notice);
			mav.addObject("BODY","noticeUpdateResult.jsp");
		}
		return mav;
	}
	
	@RequestMapping(value="/notice/input.html")
	public ModelAndView input(HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
		mav.addObject(new Notice());
		mav.addObject("BODY", "noticeInput.jsp");
		return mav;
	}
	
	@RequestMapping(value="/notice/putForm.html")
	public ModelAndView inputform(@Valid Notice notice, BindingResult br, HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
    	//관리자 로그인 체크
        if (loginUser == null || !"admin".equals(loginUser.getId())) {
            mav.addObject("BODY","login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
		if(br.hasErrors()) {
			mav.addObject("BODY","noticeInput.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		int notice_id = this.noticeDao.getMaxNum() + 1;
		notice.setNotice_id(notice_id);//글번호 설정
		this.noticeDao.putNotice(notice);
		mav.addObject("BODY","noticeInputResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/notice/detail.html")
	public ModelAndView detail(Integer notice_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		Notice notice = this.noticeDao.getNotice(notice_id);
		LoginUser user = (LoginUser)session.getAttribute("loginUser");
		mav.addObject(notice);
		if(user != null && user.getId().equals("admin")) {//관리자로 로그인 한 경우
			mav.addObject("BODY","noticeDetailAdmin.jsp");//form:form
		}else {//관리자가 아닌 경우
			mav.addObject("BODY","noticeDetail.jsp");//form:form
		}
		return mav;
	}
	
	@RequestMapping(value="/notice/notice.html")
	public ModelAndView index(Integer pageNo) {
		ModelAndView mav = new ModelAndView("main");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 9;
		int end = ((currentPage - 1) * 9) + 10;
		StartEnd se = new StartEnd(); se.setStart(start); se.setEnd(end);
		List<Notice> noticeList = this.noticeDao.getNoticeList(se);
		int totalCount = this.noticeDao.getCount();
		int pageCount = totalCount / 9;
		if(totalCount % 9 != 0) pageCount++;
		mav.addObject("currentPage",currentPage);
		mav.addObject("PAGES", pageCount);
		mav.addObject("BODY","notice.jsp");
		mav.addObject("NOTICES", noticeList);
		return mav;
	}
}
