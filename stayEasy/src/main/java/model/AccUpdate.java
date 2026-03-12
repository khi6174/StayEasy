package model;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="bb_acc_update_tbl")
public class AccUpdate {
	
	@Id
	private Integer acc_request_id;
	
	@ManyToOne
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;
	
	@NotEmpty(message="숙소이름을 입력해주세요")
	private String accname;
	@NotEmpty(message="위치를 입력해주세요")
	private String location;
	@NotNull(message="1박당 가격을 입력해주세요")
	private Integer price_per_night;
	@NotEmpty(message="숙소 설명을 입력해주세요")
	private String description;
	@NotEmpty(message="사진을 삽입해주세요")
	private String acc_image;
	
	@Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern="yyyy-MM-dd")
	private Date acc_request_date;
	
	private String acc_approval_status;
	private String acc_rejection_reason;
	
	@OneToMany(mappedBy = "accUpdate")
	private List<RoomUpdate> roomUpdates;
	
	
	public List<RoomUpdate> getRoomUpdates() {
		return roomUpdates;
	}

	public void setRoomUpdates(List<RoomUpdate> roomUpdates) {
		this.roomUpdates = roomUpdates;
	}

	public Integer getAcc_request_id() {
		return acc_request_id;
	}

	public void setAcc_request_id(Integer acc_request_id) {
		this.acc_request_id = acc_request_id;
	}

	public Accommodation getAccommodation() {
		return accommodation;
	}

	public void setAccommodation(Accommodation accommodation) {
		this.accommodation = accommodation;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getAccname() {
		return accname;
	}

	public void setAccname(String accname) {
		this.accname = accname;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Integer getPrice_per_night() {
		return price_per_night;
	}

	public void setPrice_per_night(Integer price_per_night) {
		this.price_per_night = price_per_night;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAcc_image() {
		return acc_image;
	}

	public void setAcc_image(String acc_image) {
		this.acc_image = acc_image;
	}

	public Date getAcc_request_date() {
		return acc_request_date;
	}

	public void setAcc_request_date(Date acc_request_date) {
		this.acc_request_date = acc_request_date;
	}

	public String getAcc_approval_status() {
		return acc_approval_status;
	}

	public void setAcc_approval_status(String acc_approval_status) {
		this.acc_approval_status = acc_approval_status;
	}

	public String getAcc_rejection_reason() {
		return acc_rejection_reason;
	}

	public void setAcc_rejection_reason(String acc_rejection_reason) {
		this.acc_rejection_reason = acc_rejection_reason;
	}
	
	
}
