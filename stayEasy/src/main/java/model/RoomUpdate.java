package model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
@Entity
@Table(name = "bb_room_update_tbl")
public class RoomUpdate {
	
	@Id
	private Integer room_request_id;
	
	@ManyToOne
	@JoinColumn(name = "acc_request_id")
	private AccUpdate accUpdate;
	
	@ManyToOne
	@JoinColumns({
	    @JoinColumn(name = "accommodation_id", referencedColumnName = "accommodation_id"),
	    @JoinColumn(name = "room_id", referencedColumnName = "room_id")
	})
	private Room room;
	
	@ManyToOne
    @JoinColumn(name = "user_id")
	private User user;
	
	@NotEmpty(message = "객실 이름을 입력하세요")
	private String name;
	@NotNull(message="1박당 가격을 입력해주세요")
	private Integer price_per_night;
	@NotNull(message="최대 숙박 가능 인원을 입력해주세요")
	private Integer capacity;
	@NotEmpty(message = "사진을 삽입해주세요")
	private String room_image;
	private Integer availability;
	
	@Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private Date room_request_date;
	
	private String room_approval_status;
	private String room_rejection_reason;
	
	public AccUpdate getAccUpdate() {
		return accUpdate;
	}
	public void setAccUpdate(AccUpdate accUpdate) {
		this.accUpdate = accUpdate;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Integer getRoom_request_id() {
		return room_request_id;
	}
	public void setRoom_request_id(Integer room_request_id) {
		this.room_request_id = room_request_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPrice_per_night() {
		return price_per_night;
	}
	public void setPrice_per_night(Integer price_per_night) {
		this.price_per_night = price_per_night;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getRoom_image() {
		return room_image;
	}
	public void setRoom_image(String room_image) {
		this.room_image = room_image;
	}
	public Integer getAvailability() {
		return availability;
	}
	public void setAvailability(Integer availability) {
		this.availability = availability;
	}
	public Date getRoom_request_date() {
		return room_request_date;
	}
	public void setRoom_request_date(Date room_request_date) {
		this.room_request_date = room_request_date;
	}
	public String getRoom_approval_status() {
		return room_approval_status;
	}
	public void setRoom_approval_status(String room_approval_status) {
		this.room_approval_status = room_approval_status;
	}
	public String getRoom_rejection_reason() {
		return room_rejection_reason;
	}
	public void setRoom_rejection_reason(String room_rejection_reason) {
		this.room_rejection_reason = room_rejection_reason;
	}
	
}
