package model;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Sales_tbl {
	@Id
	private Integer sale_id;
	private String user_id;
	private String sale_time;

	@OneToMany(mappedBy="sale")
	private Set<Sales_detail_tbl> details;

	public Integer getSale_id() {
		return sale_id;
	}

	public void setSale_id(Integer sale_id) {
		this.sale_id = sale_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getSale_time() {
		return sale_time;
	}

	public void setSale_time(String sale_time) {
		this.sale_time = sale_time;
	}

	public Set<Sales_detail_tbl> getDetails() {
		return details;
	}

	public void setDetails(Set<Sales_detail_tbl> details) {
		this.details = details;
	}
	

}









