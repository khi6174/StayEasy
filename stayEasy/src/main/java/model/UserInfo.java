package model;

import java.util.Date;

import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class UserInfo {
	 @Id 
	   private String user_id;
	   @NotEmpty(message="암호를 입력하세요")
	   private String user_pwd;
	   @NotEmpty(message="이름을 입력해주세요")
	   private String username;
	   @NotEmpty(message="이메일을 입력하세요")
	   private String email;
	   @NotEmpty(message="휴대전화 번호를 입력하세요")
	   private String phone;
	   @NotEmpty(message="주소를 입력하세요")
	   private String addr;
	   @Temporal(TemporalType.DATE)
	   @DateTimeFormat(pattern="yyyy-MM-dd")
	   private Date birth;
	   @NotEmpty(message="성별을 선택하세요")
	   private String gender;
	   
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	   
}
