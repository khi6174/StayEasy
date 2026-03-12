package model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="bb_cartitem_tbl")
public class CartItem {
	@Id
	private String cartitem_id;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	 @JoinColumns({
		 @JoinColumn(name = "accommodation_id", referencedColumnName = "accommodation_id"),
		 @JoinColumn(name = "room_id", referencedColumnName = "room_id")
	 })
	private Room room;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@NotNull(message="체크인 날짜를 선택해주세요.")
	private Date check_in_date;
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@NotNull(message="체크아웃 날짜를 선택해주세요.")
	private Date check_out_date;
	
	@NotNull(message="인원 수를 입력하세요")
	private Integer count;
	private Integer total_price;
	
	@Transient  // DB 테이블과 매핑하지 않음
	private long nights; //숙박일
	
	
	public long getNights() {
		return nights;
	}
	public void setNights(long nights) {
		this.nights = nights;
	}
	public Date getCheck_in_date() {
		return check_in_date;
	}
	public void setCheck_in_date(Date check_in_date) {
		this.check_in_date = check_in_date;
	}
	public Date getCheck_out_date() {
		return check_out_date;
	}
	public void setCheck_out_date(Date check_out_date) {
		this.check_out_date = check_out_date;
	}
	public String getCartitem_id() {
		return cartitem_id;
	}
	public void setCartitem_id(String cartitem_id) {
		this.cartitem_id = cartitem_id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getTotal_price() {
		return total_price;
	}
	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
	
	
}
