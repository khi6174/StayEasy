package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
@Entity
@Table(name = "bb_room_tbl")
public class Room {
	

    @EmbeddedId
    private RoomId id;

    @ManyToOne
    @MapsId("accommodationId")
    @JoinColumn(name = "accommodation_id", insertable = false, updatable = false)
    private Accommodation accommodation;

    @NotEmpty(message = "객실 이름을 입력하세요")
    private String name;

    @NotNull(message = "1박당 가격을 입력하세요")
    private Integer price_per_night;

    @NotNull(message = "객실 수용 인원을 입력하세요")
    @Min(value=1, message="최소 인원 수는 1명 이상이어야 합니다.")
    private Integer capacity;

    @NotEmpty(message = "객실 사진을 올려주세요")
    private String room_image;

    private Integer availability;
    
    
    @OneToMany(mappedBy = "room")
    private List<CartItem> cartItem = new ArrayList<>();
    
    @OneToMany(mappedBy = "room")
    private List<RoomUpdate> roomUpdates = new ArrayList<>();


    // 기본 생성자
    public Room() {
    	this.capacity = 1;
    }

    // 생성자
    public Room(RoomId id, Accommodation accommodation, String name, Integer price_per_night, Integer capacity, String room_image, Integer availability) {
        this.id = id;
        this.accommodation = accommodation;
        this.name = name;
        this.price_per_night = price_per_night;
        this.capacity = capacity;
        this.room_image = room_image;
        this.availability = availability;
    }

	

	public List<CartItem> getCartItem() {
		return cartItem;
	}

	public void setCartItem(List<CartItem> cartItem) {
		this.cartItem = cartItem;
	}

	public List<RoomUpdate> getRoomUpdates() {
		return roomUpdates;
	}

	public void setRoomUpdates(List<RoomUpdate> roomUpdates) {
		this.roomUpdates = roomUpdates;
	}

	public RoomId getId() {
		return id;
	}

	public void setId(RoomId id) {
		this.id = id;
	}

	public Accommodation getAccommodation() {
		return accommodation;
	}

	public void setAccommodation(Accommodation accommodation) {
		this.accommodation = accommodation;
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
    
    
}
