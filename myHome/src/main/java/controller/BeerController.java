package controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

class BeerExpert {
	public ArrayList<String> getBrands(String color){
		ArrayList<String> result = new ArrayList<String>();
		switch(color) {
		case "red": result.add("Red Wind"); result.add("Red Sun"); break;
		case "dark": result.add("Dark Night"); result.add("Night Shark");
						result.add("Real Darkness"); break;
		case "brown": result.add("Kirin"); result.add("TshingTao"); break;
		case "black": result.add("Black Jack"); result.add("Black Smith");
						result.add("Black One"); break;
		}
		return result;
	}
}

@Controller
public class BeerController {
	@RequestMapping(value="/beer/result.html")
	public ModelAndView makeResult(String COLOR) {
		ModelAndView mav = new ModelAndView();
		BeerExpert be = new BeerExpert();
		ArrayList<String> result = be.getBrands(COLOR);
		mav.addObject("BRANDS", result);
		return mav;
	}
	
	@RequestMapping(value="/beer/beer.html")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}




