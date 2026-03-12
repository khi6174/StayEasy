package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Sale;
@Repository
public class SaleDaoImpl implements SaleDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public Integer findMaxSaleId() {
		Integer max = this.sqlSession.selectOne("salesMapper.getMaxSaleId");
		if(max == null) return 0;
		else return max;
	}
	@Override
	public void create(Sale sale) {
		this.sqlSession.insert("salesMapper.putSale", sale);
	}

}





