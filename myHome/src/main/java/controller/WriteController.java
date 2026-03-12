package controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.BoardDao;
import model.Board;
import model.LoginUser;

@Controller
public class WriteController {
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping(value="/write/modify.html")
	public ModelAndView modify(Integer SEQ,String TITLE,String CONTENT,String BTN) {
		if(BTN.equals("수정")) {
			Board bbs = new Board();
			bbs.setSeq(SEQ); bbs.setTitle(TITLE); bbs.setContent(CONTENT);
			this.boardDao.updateBoard(bbs);//글번호의 게시글 변경
		}else if(BTN.equals("삭제")) {
			this.boardDao.deleteBoard(SEQ);//글번호의 게시글 삭제
		}
		//수정 혹은 삭제 작업 후 다시 목록으로 돌아간다.
		ModelAndView mav = new ModelAndView("redirect:/write/read.html");
		return mav;
	}
	
	@RequestMapping(value="/write/detail.html")
	public ModelAndView detail(Integer SEQ) {
		Board bbs = this.boardDao.readDetail(SEQ);//글번호로 게시글 검색
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","boardDetail.jsp");//검색된 게시글을 출력하는 JSP 이름
		mav.addObject("BOARD", bbs);//JSP에서 검색된 게시글 데이터를 가져갈 때 사용하는 이름
		return mav;
	}
	
	@RequestMapping(value="/write/read.html")
	public ModelAndView read(Integer pageNo) {
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		List<Board> bbsList = this.boardDao.readBoard(pageNo);
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("BODY","boardList.jsp");
		mav.addObject("BOARD", bbsList);
		mav.addObject("currentPage",currentPage);
		int totalCount = this.boardDao.totalCount();//전체 게시글의 갯수 검색
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		mav.addObject("PAGES",pageCount);
		return mav;
	}
	
	@RequestMapping(value="/write/entryBoard.html")
	public ModelAndView entryBoard(@Valid Board board, BindingResult br,
			HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		if(br.hasErrors()) {
			mav.addObject("BODY","write_board.jsp");
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		//글번호(자동증가), 작성자(HttpSession에서 가져온다)를 설정한다.
		LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
		board.setId(loginUser.getId());//계정 설정
		this.boardDao.putBoard(board);
		mav.addObject("BODY","writeBoardResult.jsp");
		return mav;
	}
	
	@RequestMapping(value="/write/write.html")
	public ModelAndView input() {
		ModelAndView mav = new ModelAndView("index");
		mav.addObject(new Board());
		mav.addObject("BODY","write_board.jsp");
		return mav;
	}
}










