package logic;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ItemDao;
import dao.SaleDao;
import dao.SaleDetailDao;
import model.Cart;
import model.Item;
import model.ItemSet;
import model.Sale;
import model.SaleDetail;
import model.User;

@Service
public class ShopImpl implements Shop {
	@Autowired
	private SaleDao saleDao;
	@Autowired
	private SaleDetailDao saleDetailDao;
	@Autowired
	private ItemDao itemDao;
	@Override
	public Integer calculateTotal(List<ItemSet> itemList) {
		int totalAmount = 0;//총액이 저장될 변수 선언
		for(ItemSet itemSet : itemList) {
			int price = itemSet.getItem().getPrice();//상품의 가격을 추출
			int quantity = itemSet.getQuantity();//상품의 갯수를 추출
			totalAmount = totalAmount + (price * quantity);//총합을 누적한다.
		}
		return totalAmount;
	}

	@Override
	public void checkout(User user, Cart cart) {
		Sale sale = createSale(user, cart);//Sale을 생성하고 Sale안에 SaleDetail을  N개 넣는다.
		entrySale(sale);//Sale과 SaleDetail을 DB에 삽입한다.
	}
	private void entrySale(Sale sale) {
		this.saleDao.create(sale);//Sale을 이용해서 매출정보 테이블에 삽입
		List<SaleDetail> saleDetailList = sale.getSaleDetailList();//Sale에서 SaleDetail을 가져온다.
		for(SaleDetail saleDetail : saleDetailList) {
			this.saleDetailDao.create(saleDetail);//SaleDetail을 이용해서 매출상세정보 테이블에 삽입
		}
	}
	private Sale createSale(User user, Cart cart) {
		Sale sale = new Sale();//매출 객체 생성
		sale.setSaleId(getNewSaleId());//매출번호 설정
		sale.setUser(user);//구매자 설정
		sale.setUserId(user.getUser_id());//구매자 계정 설정
		Timestamp currentTime = getCurrentTime();//구매한 연월일시분초 생성
		sale.setSaleTime(currentTime);//구매 시간을 설정
		
		//List<ItemSet> itemList = cart.getItemList();//장바구니에서 상품목록을 추출
		
		List<String> codeList = cart.getCodeList();//장바구니에서 상품코드 목록을 가져온다.
		List<Integer> numList = cart.getNumList();//장바구니에서 상품갯수 목록을 가져온다.
		for(int i=0 ; i < codeList.size(); i++) {
			String code = codeList.get(i);//i번째 상품번호를 가져온다.
			Item item = this.itemDao.getItem(code);//code에 있는 상품번호로 상품을 찾는다.
			Integer number = numList.get(i);//i번째 상품갯수를 가져온다.
			ItemSet itemSet = new ItemSet(item,number);//상품과 갯수로 ItemSet을 생성
			//ItemSet itemSet = (ItemSet)itemList.get(i);//i번째 상품과 갯수(GuailSet)을 추출
			
			int saleDetailId = i + 1;//매출 상세 번호 생성
			SaleDetail saleDetail = createSaleDetail(sale, saleDetailId, itemSet, currentTime);
			sale.addSaleDetail(saleDetail);//매출(Sale)에 매출상세정보(SaleDetail) 추가
		}//모든 상품이 처리될때까지 반복
		return sale;
	}
	private SaleDetail createSaleDetail(Sale sale, int saleDetailId, ItemSet itemSet,
			Timestamp currentTime) {
		return new SaleDetail(sale, saleDetailId, itemSet, currentTime);
	}
	private Timestamp getCurrentTime() {
		return new Timestamp(Calendar.getInstance().getTimeInMillis());
	}
	private Integer getNewSaleId() {
		Integer id = this.saleDao.findMaxSaleId()+1;//매출번호 생성
		return id;
	}

}


















