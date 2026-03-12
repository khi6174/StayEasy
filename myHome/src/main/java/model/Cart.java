package model;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import dao.CartDao;

@Service
@Scope("session")
public class Cart {
	@Autowired
	private CartDao cartDao;
	private String id;//장바구니의 주인 즉, 계정
	private String code;//상품 번호
	private Integer num;//상품 갯수
	
	private ArrayList<String> codeList = new ArrayList<String>();//상품번호 목록
	private ArrayList<Integer> numList = new ArrayList<Integer>();//상품갯수 목록
	
	public void clearAll() {
		this.codeList = new ArrayList<String>();//상품번호 목록
		this.numList = new ArrayList<Integer>();//상품갯수 목록
	}//장바구니를 비우는 메서드
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public ArrayList<String> getCodeList() {
		return codeList;
	}
	public void setCodeList(int index, String code) {
		this.codeList.add(index, code);
	}//codeList에 상품번호를 넣는 메서드
	public ArrayList<Integer> getNumList() {
		return numList;
	}
	public void setNumList(int index, Integer num) {
		this.numList.add(index, num);
	}
	public void modifyItem(String code, String id, Integer num) {
		for(int i=0; i < codeList.size(); i++) {
			if(codeList.get(i).equals(code)) {
				numList.set(i, num);//i번째 상품의 갯수를 num으로 수정
				//DB연동 시작//
				CartItem ci = new CartItem();
				ci.setId(id); ci.setItem_code(code); ci.setNum(num);
				this.cartDao.updateCart(ci);
				//DB연동 끝
				return;//메서드 종료
			}
		}
	}//장바구니의 상품 갯수를 수정하는 메서드
	public void deleteItem(String code, String id) {
		for(int i=0; i < codeList.size(); i++) {
			if(codeList.get(i).equals(code)) {//입력된 상품코드와 i번째 상품의 상품코드가 같은 경우
				codeList.remove(i);//i번째 상품코드를 삭제한다.
				numList.remove(i);//i번째 상품의 갯수를 삭제한다.
				//DB연동 시작//
				CartItem ci = new CartItem();
				ci.setId(id); ci.setItem_code(code);
				this.cartDao.deleteCart(ci);
				//DB연동 끝//
				return;//메서드 종료
			}
		}
	}//장바구니에서 상품을 삭제하는 메서드
	
	public void addCart(String code, Integer num) {
		for(int  i=0; i < codeList.size(); i++) {
			if(codeList.get(i).equals(code)) {//i번째 상품번호와 입력한 상품번호가 일치하는 경우
				int number = numList.get(i);//i번째 상품의 갯수를 찾는다.
				number = number + num;
				numList.set(i, number);//i번째 상품의 갯수를 number로 변경한다.
				//DB 연동 시작//
				CartItem ci = new CartItem();
				ci.setId(id); ci.setItem_code(code); ci.setNum(number);
				this.cartDao.updateCart(ci);
				//DB 연동 끝//
				return;//메서드 종료
			}
		}//code가 이미  codeList에 존재하는지를 반복으로 찾는다.
		codeList.add(code); numList.add(num);
		///DB연동 시작///
		CartItem ci = new CartItem();
		ci.setId(id); ci.setItem_code(code); ci.setNum(num);
		this.cartDao.insertCart(ci);//DB에 insert
		///DB연동 끝///
	}//상품번호와 갯수를 codeList와 numList에 저장하는 메서드
}












