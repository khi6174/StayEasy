package model;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginUser {
	@NotEmpty(message="계정을 입력하세요.")
	private String id;
	@NotEmpty(message="암호를 입력하세요.")
	private String password;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
