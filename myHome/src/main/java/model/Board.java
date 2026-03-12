package model;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Board {
	private Integer seq;
	private String id;
	@NotEmpty(message="제목을 입력하세요.")
	@Size(min=0,max=10,message="{min}보다 크고 {max}보다 적어야 합니다.")
	private String title;
	@NotEmpty(message="내용을 입력하세요.")
	@Size(min=0,max=30,message="{min}보다 크고 {max}보다 적어야 합니다.")
	private String content;
	private String write_date;
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
}
