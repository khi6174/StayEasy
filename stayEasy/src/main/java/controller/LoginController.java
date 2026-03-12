package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.CartDao;
import dao.UserDao;
import model.CartItem;
import model.LoginUser;
import model.User;
import pwdEncoder.PasswordEncoder;

@Controller
@Scope("session")
public class LoginController {
   @Autowired
   private UserDao userDao;
   
   @Autowired
   private CartDao cartDao;
   
   @Autowired
	private PasswordEncoder pwdEn;
   
   @RequestMapping(value="/login/idCheck.html")
   public ModelAndView idCheck(String USER_ID) { //아이디 중복검사
      ModelAndView mav = new ModelAndView("idCheckResult");
      Integer count = this.userDao.idCheck(USER_ID);
      if(count > 0) {//이미 계정이 존재하는 경우, 즉 계정 중복
         mav.addObject("DUP","YES");
      }else {//계정이 존재하지 않는 경우, 즉 사용 가능
         mav.addObject("DUP","NO");
      }
      mav.addObject("ID", USER_ID);
      return mav;
   }
   
   @RequestMapping(value="/login/registerResult.html")
   public ModelAndView registerResult() {
	   ModelAndView mav = new ModelAndView("main");
	   mav.addObject("BODY","registerResult.jsp");
	   return mav;
   }
   
   @RequestMapping(value="/login/registerDo.html",method=RequestMethod.POST)
   public ModelAndView registerDo(@Valid User user, BindingResult br) {
      ModelAndView mav = new ModelAndView("main");
      if(br.hasErrors()) {
         mav.addObject("BODY","register.jsp");
         mav.getModel().putAll(br.getModel());
         return mav;
      }//어노테이션을 이용한 폼체크
      
      //passwordEncoder를 이용한 비밀번호 암호화
      String encodedPwd = pwdEn.encrypt(user.getUser_id(), user.getUser_pwd());
      user.setUser_pwd(encodedPwd);
      
      //db에 저장
      this.userDao.putUser(user);
      return new ModelAndView("redirect:/login/registerResult.html");
   }
   
   @RequestMapping(value="/login/register.html")
   public ModelAndView register(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView("main");
      mav.addObject("BODY","register.jsp");
      request.setAttribute("user", new User());
      return mav;
   }
   
   @RequestMapping(value="/login/loginDo.html", method=RequestMethod.POST)
   public ModelAndView loginDo(@Valid LoginUser loginUser, BindingResult br,
         HttpSession session, RedirectAttributes redirectAttributes) {
       
       if (br.hasErrors()) {
           redirectAttributes.addFlashAttribute("errors", br.getAllErrors());
           return new ModelAndView("redirect:/login/login.html");
       }
       
       String encodedPwd = pwdEn.encrypt(loginUser.getId(), loginUser.getPassword());
       loginUser.setPassword(encodedPwd);
       //로그인 진행(id, pwd확인)
       LoginUser loginuser = this.userDao.loginUser(loginUser);
       
       // 로그인 실패
       if (loginuser == null) {
           redirectAttributes.addFlashAttribute("FAIL", "YES");
           return new ModelAndView("redirect:/login/login.html");
       }

       if (loginuser != null) {
           User user = userDao.findUserById(loginuser.getId());
           session.setAttribute("currentUser", user);
       }
       
       // 로그인 성공
       session.setAttribute("loginUser", loginuser);
       
       // 장바구니 정보 저장
       List<CartItem> cartItem = this.cartDao.selectCartItem(loginuser.getId());
       session.setAttribute("CARTITEM", cartItem);
       
       return new ModelAndView("redirect:/stay/main.html"); // 로그인 성공 시 메인 화면으로 바로 이동
   }

   
   @RequestMapping(value="/login/login.html")
   public ModelAndView login(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView("main");
      mav.addObject("BODY","login.jsp");
      request.setAttribute("loginUser",new LoginUser());//login.jsp에 객체(인스턴스)를 주입한다.
      return mav;
   }
}
