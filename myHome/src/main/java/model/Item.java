package model;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

public class Item {
	@NotEmpty(message="상품코드 중복검사를 해야합니다.")
	private String codeChecked;
	
	@NotEmpty(message="상품코드를 입력하세요.")
	private String item_code;
	@NotEmpty(message="상품이름 입력하세요.")
	private String item_title;
	@NotNull(message="가격을 입력하세요.")
	@Range(min=0,max=1000000,message="{min}과 {max} 사이로 입력하세요.")
	private Integer price;
	@NotEmpty(message="상품설명 입력하세요.")
	private String item_spec;
	private String reg_date;
	private String madein;
	public String getCodeChecked() {
		return codeChecked;
	}
	public void setCodeChecked(String codeChecked) {
		this.codeChecked = codeChecked;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getItem_title() {
		return item_title;
	}
	public void setItem_title(String item_title) {
		this.item_title = item_title;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getItem_spec() {
		return item_spec;
	}
	public void setItem_spec(String item_spec) {
		this.item_spec = item_spec;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getMadein() {
		return madein;
	}
	public void setMadein(String madein) {
		this.madein = madein;
	}
}
