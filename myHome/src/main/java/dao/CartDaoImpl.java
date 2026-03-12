package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.CartItem;
@Repository
public class CartDaoImpl implements CartDao {
	@Autowired
	private SqlSession sqlSession;

	public void insertCart(CartItem ci) {
		this.sqlSession.insert("cartMapper.insertCart",ci);
	}
	public void deleteCart(CartItem ci) {
		this.sqlSession.delete("cartMapper.deleteCart",ci);
	}
	public void updateCart(CartItem ci) {
		this.sqlSession.update("cartMapper.updateCart",ci);
	}
	public List<CartItem> selectCart(String id) {
		return this.sqlSession.selectList("cartMapper.selectCart",id);
	}

}


