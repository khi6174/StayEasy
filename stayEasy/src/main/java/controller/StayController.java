	package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.StayDao;
import model.Event;
import model.Notice;

@Controller
public class StayController {

	@Autowired
	private StayDao stayDao;
	
	@RequestMapping(value="/stay/main.html")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("main");
		int count = 1; // main인지 아닌지 확인하는 변수
		List<Notice> noticeList = this.stayDao.getNoticeList();
		List<Event> eventList = this.stayDao.getEventList();
		mav.addObject("count", count);
		mav.addObject("NOTICES", noticeList);
		mav.addObject("EVENTS", eventList);
		count = 0;
		return mav;
	}
}
