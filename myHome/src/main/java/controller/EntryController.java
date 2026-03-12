package controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.CheckDao;
import dao.UserDao;
import model.User;

@Controller
public class EntryController {
	@Autowired
	private CheckDao checkDao;
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value="/entry/register.html")
	public ModelAndView register(@Valid User user, BindingResult br) {
		ModelAndView mav = new ModelAndView("index");
		if(br.hasErrors()) {
			mav.addObject("BODY","userEntry.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		this.userDao.putUser(user);//DB에 insert
		mav.addObject("BODY","userEntryResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/entry/idcheck.html")
	public ModelAndView idcheck(String USER_ID) {
		ModelAndView mav = new ModelAndView("idCheckResult");
		Integer count = this.checkDao.checkDupId(USER_ID);
		if(count > 0) {//이미 계정이 존재하는 경우, 즉 계정 중복
			mav.addObject("DUP","YES");
		}else {//계정이 존재하지 않는 경우, 즉 사용 가능
			mav.addObject("DUP","NO");
		}
		mav.addObject("ID", USER_ID);
		return mav;
	}//계정 중복 검사 메서드
	
	@RequestMapping(value="/entry/userEntry.html")
	public ModelAndView userEntry() {
		ModelAndView mav = new ModelAndView("index");
		
		
		
		mav.addObject(new User());//인스턴스 주입
		mav.addObject("BODY","userEntry.jsp");
		return mav;
	}
}









