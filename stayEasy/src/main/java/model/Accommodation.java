package model;

import java.util.ArrayList;
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
@Table(name="bb_acc_tbl")
public class Accommodation {

    @Id
    private String accommodation_id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @NotEmpty(message="숙소 이름을 입력해주세요")
    private String accname;

    @ManyToOne
    @JoinColumn(name = "category_id")  
    private Category category;
   
    @NotEmpty(message="위치를 입력해주세요")
    private String location;
    
    private Integer price_per_night;
    @NotEmpty(message="설명을 써주세요")
    private String description;
    
    private String acc_image;
   @Temporal(TemporalType.DATE)
   @DateTimeFormat(pattern="yyyy-MM-dd")
   private Date a_date;
   @NotNull
   private int app_status;
   
   @Transient  // DB 테이블과 매핑하지 않음
   private String cateName;
   
   @OneToMany(mappedBy = "accommodation")
   private List<Room> rooms = new ArrayList<>();
   @OneToMany(mappedBy = "accommodation")
   private List<AccUpdate> accUpdates = new ArrayList<>();


//   @OneToMany(mappedBy = "accommodation")
//   private Set<Cart> cart;
//   @OneToMany(mappedBy = "accommodation")
//   private Set<Reservation> reserv;
//   
//   
//
//    public Set<Reservation> getReserv() {
//	return reserv;
//    }
//
//    public void setReserv(Set<Reservation> reserv) {
//	this.reserv = reserv;
//    }

   
	public List<Room> getRooms() {
      return rooms;
   }

   public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

public List<AccUpdate> getAccUpdates() {
		return accUpdates;
	}

	public void setAccUpdates(List<AccUpdate> accUpdates) {
		this.accUpdates = accUpdates;
	}

public void setRooms(List<Room> rooms) {
      this.rooms = rooms;
   }

//   public Set<Cart> getCart() {
//      return cart;
//   }
//
//   public void setCart(Set<Cart> cart) {
//      this.cart = cart;
//   }

   // Getter & Setter
    public String getAccommodation_id() {
        return accommodation_id;
    }
   
    public void setAccommodation_id(String accommodation_id) {
        this.accommodation_id = accommodation_id;
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

   public Date getA_date() {
      return a_date;
   }

   public void setA_date(Date a_date) {
      this.a_date = a_date;
   }

   public int getApp_status() {
      return app_status;
   }

   public void setApp_status(int app_status) {
      this.app_status = app_status;
   }

}