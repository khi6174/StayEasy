package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="bb_cate_tbl")
public class Category {
   @Id
   private String category_id;
   
   @NotEmpty(message="숙소를 입력하세요")
   private String name;
   
   @OneToMany(mappedBy="category")
   private Set<Accommodation> Accommodation;
   
   @OneToMany(mappedBy = "category")
   private List<AccUpdate> accUpdates = new ArrayList<>();
   
   
   public Set<Accommodation> getAccommodation() {
	return Accommodation;
   }
   public void setAccommodation(Set<Accommodation> accommodation) {
	Accommodation = accommodation;
   }
   
   public List<AccUpdate> getAccUpdates() {
	return accUpdates;
}
public void setAccUpdates(List<AccUpdate> accUpdates) {
	this.accUpdates = accUpdates;
}
public String getCategory_id() {
      return category_id;
   }
   public void setCategory_id(String category_id) {
      this.category_id = category_id;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   
   
}
