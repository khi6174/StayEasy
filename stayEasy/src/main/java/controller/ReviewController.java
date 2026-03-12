package controller;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.ReviewDao;
import model.LoginUser;
import model.Reservation;
import model.Review;
import model.User;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewDao reviewDao;
	
	@RequestMapping(value="/review/delete.html")
	public ModelAndView delete(Integer review_id, String ACC, HttpSession session) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if (loginUser == null) {
			mav.addObject("BODY", "login.jsp");
			mav.addObject(new LoginUser());
			return mav;
		}
		this.reviewDao.deleteReview(review_id);
		mav.addObject("BODY", "reviewDeleteResult.jsp");
		mav.addObject("ACC", ACC);
		return mav;
	}
	
	@RequestMapping(value="/review/input.html")
	public ModelAndView input(@Valid Review review, BindingResult br,
	                HttpSession session, String ACC) {
	    ModelAndView mav = new ModelAndView("main");

	    if (br.hasErrors()) {
	        mav.addObject("BODY", "reviewWrite.jsp");
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }

	    // 리뷰 ID 설정
	    int review_id = this.reviewDao.getMaxNum() + 1;
	    review.setReview_id(review_id);

	    // ⭐ 세션에서 로그인 유저 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

	    if (loginUser != null) {
	        User user = new User();
	        user.setUser_id(loginUser.getId());
	        review.setUser(user);
	    } else {
	        System.out.println("🚨 로그인한 유저 정보가 없음!");
	        mav.addObject("BODY", "login.jsp");
	        mav.addObject(new LoginUser());
	        return mav;
	    }

	    // 🚨 reservation_id가 NULL이거나 존재하지 않으면 예외 처리
	    if (review.getReservation() == null || review.getReservation().getReservation_id() == null || review.getReservation().getReservation_id().trim().isEmpty()) {
	        System.out.println("🚨 오류: 유효하지 않은 reservation_id!");
	        mav.addObject("BODY", "reviewWrite.jsp");
	        return mav;
	    }

	    // 🔹 쉼표(`,`)가 앞에 붙어 있는 경우 제거
	    String reservationId = review.getReservation().getReservation_id().trim();
	    reservationId = reservationId.replaceAll("^,+", ""); // 쉼표 연속 제거
	    review.getReservation().setReservation_id(reservationId);

	    // 리뷰 저장
	    this.reviewDao.putReview(review);
	    mav.addObject("ACC", ACC);
	    mav.addObject("BODY", "reviewInputResult.jsp");
	    return mav;
	}

	
	@RequestMapping(value="/review/write.html")
	public ModelAndView write(HttpSession session, String ACC) {
		ModelAndView mav = new ModelAndView("main");
		LoginUser user = (LoginUser)session.getAttribute("loginUser");	
		//로그인을 안 한 경우, 로그인 창을 띄운다.
		if(user == null) {
			mav.addObject(new LoginUser());
			mav.addObject("BODY","login.jsp");
			return mav;
		}
		else {//로그인을 한 경우
			String accname = this.reviewDao.getACCName(ACC);
			String ID = user.getId();
			
			List<Reservation> reservList = this.reviewDao.getReservByUser(user.getId(), ACC);
			
			// ✅ 예약 내역이 없을 경우 noReview.jsp로 이동
		    if (reservList == null || reservList.isEmpty()) {
		        mav.addObject("ACC", ACC); // 리뷰 목록으로 돌아갈 때 필요
		        mav.addObject("BODY", "noReview.jsp");
		        return mav;
		    }
		    
			mav.addObject(new Review());
			mav.addObject("reservList", reservList);
			mav.addObject("accname", accname);
			mav.addObject("ID", ID);
			mav.addObject("ACC", ACC);
			mav.addObject("BODY", "reviewWrite.jsp");
			return mav;
		}
	}
	
	@RequestMapping(value="/review/list.html")
	public ModelAndView list(String ACC) {
		ModelAndView mav = new ModelAndView("main");
		//별점
		BigDecimal ratingAVG = this.reviewDao.getRatingAVG(ACC);
		
		//숙소 이름
		String accname = this.reviewDao.getACCName(ACC);
		
		//예약 정보
		List<Reservation> reservations = this.reviewDao.getReservByAcc(ACC);
		
		// 각 예약에 대한 리뷰 조회 및 Room 정보 주입
        for (Reservation reservation : reservations) {
        	if(reservation == null) continue; //null 체크
        	
            List<Review> reviews = reviewDao.getReviewByReserv(reservation.getReservation_id());
            reservation.setReview(reviews);
        }
		
        mav.addObject("ACC", ACC);
		mav.addObject("reservations", reservations);
		mav.addObject("rating", ratingAVG);
		mav.addObject("accname", accname);
		mav.addObject("BODY", "reviewList.jsp");
		return mav;
	}
}
