package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dao.SearchDao;
import model.Accommodation;
import model.Category;
import model.Reservation;
import model.Room;
import model.StartEnd;

@Controller
public class SearchController {

	@Autowired
	private SearchDao searchDao;
	
	private Date parseDate(String dateStr) { //String -> Date타입 변환 함수
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정
			return formatter.parse(dateStr); // String을 Date로 변환
		}catch (ParseException e) {
			e.printStackTrace();
			System.out.println("날짜 Date타입 변환 실패");
			return null; // 변환 실패 시 null 반환
		}
	}
	
	@RequestMapping(value="/search/result.html", method=RequestMethod.POST)
	public ModelAndView result(@Valid @ModelAttribute("room") Room room, BindingResult brRoom,
	                        @Valid @ModelAttribute("accommodation") Accommodation accommodation, BindingResult brAcc, 
	    @RequestParam(value="KEY") String KEY,
	    @RequestParam("type") String TYPE,
	    String CHECKIN, String CHECKOUT, 
	    @RequestParam(value="capacity", required=false, defaultValue="1") Integer CAPACITY, 
	    @RequestParam(value="pageNo", required=false, defaultValue="1") Integer pageNo) {

	    ModelAndView mav = new ModelAndView("main");

	    // NULL 값 방어 처리
	    if (KEY == null || KEY.trim().isEmpty()) {
	        KEY = "DEFAULT"; // 기본값 설정 (필요에 따라 변경 가능)
	    }
	    
	    // 숙소 유형 리스트 추가
	    List<String> typeList = Arrays.asList("MOT", "HOT", "PEN", "CAM", "GUE", "SPA");
	    mav.addObject("typeList", typeList);
	    mav.addObject("selectedType", TYPE);  // 선택한 TYPE 값 유지

	    // 검색 조건 설정
	    int currentPage = (pageNo != null && pageNo > 0) ? pageNo : 1;
	    int start = (currentPage - 1) * 4;
	    int end = start + 5;

	    StartEnd se = new StartEnd(); se.setStart(start); se.setEnd(end);

	    Accommodation acc = new Accommodation(); acc.setAccname(KEY); acc.setLocation(KEY);

	    Category cate = new Category(); cate.setCategory_id(TYPE);

	    room.setCapacity(CAPACITY);

	    Date check_in = parseDate(CHECKIN); Date check_out = parseDate(CHECKOUT);

	    Reservation re = new Reservation(); re.setCheck_in_date(check_in); re.setCheck_out_date(check_out);

	    List<Accommodation> accList = this.searchDao.getAccListByCon(acc, cate, room, re, se);
	    int totalCount = this.searchDao.getAccCountByCon(acc, cate, room, re);

	    int pageCount = (totalCount / 4) + (totalCount % 4 == 0 ? 0 : 1);

	    // ✅ startPage와 endPage 계산 후 JSP로 전달
	    int startPage = currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1;
	    int endPage = startPage + 9;
	    if (endPage > pageCount) {
	        endPage = pageCount;
	    }
	    mav.addObject("currentPage", currentPage);
	    mav.addObject("PAGES", pageCount);
	    mav.addObject("startPage", startPage);
	    mav.addObject("endPage", endPage);
	    mav.addObject("accList", accList);

	    // 검색 결과에 따라 페이지 이동
	    if (totalCount == 0) {
	        mav.addObject("BODY", "noResult.jsp");
	    } else {
	        mav.addObject("BODY", "searchResult.jsp");
	    }
	    
	    return mav;
	}



	
	@RequestMapping(value="/search/search.html")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("main");
		List<String> typeList = Arrays.asList("MOT", "HOT", "PEN", "CAM", "GUE", "SPA");
		mav.addObject("typeList", typeList);
		mav.addObject("BODY", "search.jsp");
		return mav;
	}
}
