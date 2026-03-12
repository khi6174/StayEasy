package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.SaleDetail;

@Repository
public class SaleDetailDaoImpl implements SaleDetailDao {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public void create(SaleDetail detail) {
		detail.setSaleId(detail.getSale().getSaleId());//매출 번호 설정
		detail.setItemId(detail.getItemId());//상품번호 설정
		this.sqlSession.insert("salesMapper.putSaleDetail", detail);
	}

}












