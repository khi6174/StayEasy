package utils;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class JavaScriptUtils {
	public static void init(HttpServletResponse response) {
		response.setContentType("text/html; charset=EUC-KR");
		response.setCharacterEncoding("EUC-KR");
	}//HttpServletResponse 초기화 메서드
	
	public static void alert(HttpServletResponse response, String text) throws IOException{
		init(response);//HttpServletResponse를 초기화 한다.
		PrintWriter out = response.getWriter();
		out.print("<script>alert('"+text+"');location.href='../cart/show.html';</script>");
		out.flush();
	}
}










