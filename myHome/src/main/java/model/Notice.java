package model;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Notice {
	private Integer num;
	@NotEmpty(message="제목을 작성하세요.")
	@Size(min=0,max=16,message="{max} 이내로 작성하세요.")
	private String title;
	@Size(min=0,max=65,message="{max} 이내로 작성하세요.")
	@NotEmpty(message="내용을 작성하세요.")
	private String content;
	private String write_date;
	private String writer;
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
}
