package model;

import org.hibernate.validator.constraints.NotEmpty;

public class UserPwd {
	@NotEmpty(message="이메일을 입력하세요")
	   private String email;
	@NotEmpty(message="이름을 입력해주세요")
	   private String username;
	@NotEmpty(message="아이디를 입력해주세요")
	   private String user_id;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
}
