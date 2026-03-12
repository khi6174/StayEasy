package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NationController {

	@RequestMapping(value="/nation/inputNation.html")
	public ModelAndView input() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","inputNation.jsp");
		return mav;
	}
}
