package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="bb_user_tbl")
public class User {
   @Transient
   @NotEmpty(message="계정중복 검사를 하세요")
   private String idChecked;
   @OneToMany(mappedBy="user")
   private Set<Reservation> reserv;
   @OneToMany(mappedBy="user")
   private Set<Review> review;
   @OneToMany(mappedBy="user")
   private Set<Inquire> inquire;
   @OneToMany(mappedBy="user")
   private Set<Accommodation> acc;
   @OneToMany(mappedBy="user")
   private Set<CartItem> cartitem;
   @OneToMany(mappedBy = "user")
   private List<RoomUpdate> roomUpdates = new ArrayList<>();
   @OneToMany(mappedBy = "user")
   private List<AccUpdate> accUpdates = new ArrayList<>();
   
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
   @NotNull(message="생년월일을 입력하세요")
   private Date birth;
   @NotEmpty(message="성별을 선택하세요")
   private String gender;
   private String enabled;

   
   public List<AccUpdate> getAccUpdates() {
	return accUpdates;
}
public void setAccUpdates(List<AccUpdate> accUpdates) {
	this.accUpdates = accUpdates;
}
public Set<CartItem> getCartitem() {
	return cartitem;
}
public void setCartitem(Set<CartItem> cartitem) {
	this.cartitem = cartitem;
}
public List<RoomUpdate> getRoomUpdates() {
	return roomUpdates;
}
public void setRoomUpdates(List<RoomUpdate> roomUpdates) {
	this.roomUpdates = roomUpdates;
}
public Set<Reservation> getReserv() {
	return reserv;
   }
   public void setReserv(Set<Reservation> reserv) {
	this.reserv = reserv;
   }
   public Set<Review> getReview() {
	return review;
   }
   public void setReview(Set<Review> review) {
	this.review = review;
   }
   public Set<Inquire> getInquire() {
	return inquire;
   }
   public void setInquire(Set<Inquire> inquire) {
	this.inquire = inquire;
   }
   public Set<Accommodation> getAcc() {
      return acc;
   }
   public void setAcc(Set<Accommodation> acc) {
      this.acc = acc;
   }
   public String getIdChecked() {
      return idChecked;
   }
   public void setIdChecked(String idChecked) {
      this.idChecked = idChecked;
   }
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
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
}
