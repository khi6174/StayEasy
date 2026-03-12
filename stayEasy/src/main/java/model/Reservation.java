package model;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="bb_reserv_tbl")
public class Reservation {
	
	@Id
	private String reservation_id;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
    
    @ManyToOne
    @JoinColumns({
        @JoinColumn(name = "room_id", referencedColumnName = "room_id"),
        @JoinColumn(name = "accommodation_id", referencedColumnName = "accommodation_id")
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
	
	private Integer total_price;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date r_date;
	
	@NotNull(message="예약 인원을 선택하세요.")
	@Min(value=1, message="최소 1명 이상 선택하세요.")
	private Integer count;
	
	
	@OneToMany(mappedBy = "reservation")
	private List<Review> review;
	@OneToMany(mappedBy = "reservation")
	private Set<Inquire> inquire;	
	
	@Transient  // DB 테이블과 매핑하지 않음
	private long nights; //숙박일
	
	
	public long getNights() {
		return nights;
	}
	public void setNights(long nights) {
		this.nights = nights;
	}
	public List<Review> getReview() {
		return review;
	}
	public void setReview(List<Review> review) {
		this.review = review;
	}
	public Set<Inquire> getInquire() {
		return inquire;
	}
	public void setInquire(Set<Inquire> inquire) {
		this.inquire = inquire;
	}
	public String getReservation_id() {
		return reservation_id;
	}
	public void setReservation_id(String reservation_id) {
		this.reservation_id = reservation_id;
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
	public Integer getTotal_price() {
		return total_price;
	}
	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
	public Date getR_date() {
		return r_date;
	}
	public void setR_date(Date r_date) {
		this.r_date = r_date;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	

	
}
