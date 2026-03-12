package mail;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;

import model.UserInfo;

public class MailUtil {
	
	public void sendEmail(UserInfo userInfo) throws Exception{
		
		//Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "dudcks2001@gmail.com"; //관리자 이메일 아이디
		String hostSMTPpw = "ccqp upyx tsae edxn"; //관리자 이메일 비밀번호
		
		//보내는 사람 
		String fromEmail = "dudcks2001@gmail.com"; //보내는 사람 이메일 
		String fromName = "StayEasy"; //보내는 사람 이름
		
		String subject="StayEasy 임시 비밀번호 입니다."; //메일 제목
		String msg = "안녕하세요. 임시 비밀번호 안내 메일입니다. "
		          + "\n" + "회원님의 임시 비밀번호는 아래와 같습니다. 로그인 후 반드시 비밀번호를 변경해주세요." + "\n";
		
		msg +="<div align='lift'";
		msg +="<h3>";
		msg +=userInfo.getUser_id() + "님의 임시 비밀번호입니다. <br>로그인 후 비밀번호를 변경해 주세요</h3>";
		msg +="<p>임시 비밀번호 : ";
		msg +=userInfo.getUser_pwd() + "</p></div>";
		
		//email전송
		String mailRecipient = userInfo.getEmail();//받는 사람 이메일 주소
		try {
			//객체 선언
			HtmlEmail mail = new HtmlEmail();
			mail.setDebug(true);
			mail.setCharset(charSet);
			mail.setSSLOnConnect(true);
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(587); 
			mail.setAuthentication(hostSMTPid, hostSMTPpw);
			mail.setStartTLSEnabled(true);
			mail.addTo(mailRecipient,userInfo.getUsername());
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void findPw(HttpServletResponse response,UserInfo userInfo) {
		response.setContentType("text/html;charset=utf-8");
	}
}
