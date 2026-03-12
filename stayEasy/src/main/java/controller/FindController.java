package controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.UserDao;
import mail.MailUtil;
import model.UserId;
import model.UserInfo;
import model.UserPwd;
import pwdEncoder.PasswordEncoder;

@Controller
public class FindController {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private PasswordEncoder pwdEn;
	
	@RequestMapping(value="/find/findPwdDo.html")
	public ModelAndView findPwdDo(@Valid UserPwd userPwd,
			BindingResult br, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mav = new ModelAndView("main");
		
		//어노테이션을 이용한 폼체크
		if(br.hasErrors()) {
			mav.addObject("BODY","findPwd.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		
		//회원정보 불러오기
		UserInfo userInfo = this.userDao.getUserInfo(userPwd);
		
		//가입된 이메일이 존재한다면 이메일 전송
		if(userInfo != null) {
			//임시 비밀번호 생성(UUID이용)
			String tempPw=UUID.randomUUID().toString().replace("-", "");//-를 제거
			tempPw = tempPw.substring(0,10);//tempPw를 앞에서부터 10자리 잘라줌
			
			userInfo.setUser_pwd(tempPw);//임시 비밀번호 담기
	
			MailUtil mail = new MailUtil(); //메일 전송하기
			mail.sendEmail(userInfo);
			
			//임시 비밀번호를 암호화하고 db에 저장
			String encodedPWd = pwdEn.encrypt(userInfo.getUser_id(), tempPw);
			userInfo.setUser_pwd(encodedPWd);
			this.userDao.updateUserPwd(userInfo);
			
			redirectAttributes.addFlashAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
			return new ModelAndView("redirect:/find/findPwd.html");
		}
		else {
		redirectAttributes.addFlashAttribute("message", "등록된 회원 정보가 없습니다.");
		return new ModelAndView("redirect:/find/findPwd.html");
		}
	}
	
	@RequestMapping(value="/find/findPwd.html")
	public ModelAndView findPwd(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("main");
		request.setAttribute("userPwd", new UserPwd());
		mav.addObject("BODY","findPwd.jsp");
		return mav;
	}
	
	@RequestMapping(value="/find/findIdDo.html")
	public ModelAndView findIdDo(@Valid UserId userId,
			BindingResult br) {
		ModelAndView mav = new ModelAndView("main");
		//어노테이션을 이용한 폼체크
		if(br.hasErrors()) {
			mav.addObject("BODY","findId.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		String foundId = this.userDao.findId(userId);
		mav.addObject("findUserId", foundId);
		 mav.addObject("submitted", true);
		mav.addObject("BODY","findId.jsp");
		return mav;
	}
	
	@RequestMapping(value="/find/findId.html")
	public ModelAndView findId(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("main");
		request.setAttribute("userId", new UserId());
		mav.addObject("BODY","findId.jsp");
		return mav;
	}
}
