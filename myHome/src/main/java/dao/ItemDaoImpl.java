package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Item;
import model.Nation;
import model.StartEnd;
@Repository
public class ItemDaoImpl implements ItemDao {
	@Autowired
	private SqlSession sqlSession;

	public List<Item> getItemByName(StartEnd name) {
		return this.sqlSession.selectList("itemMapper.getItemByName", name);
	}

	public Integer getItemCountByName(String name) {
		return this.sqlSession.selectOne("itemMapper.getItemCountByName",name);
	}

	public void deleteCart(String id) {
		this.sqlSession.delete("itemMapper.deleteCart", id);
	}

	public void updateItem(Item item) {
		this.sqlSession.update("itemMapper.updateItem", item);
	}

	public void deleteItem(String code) {
		this.sqlSession.delete("itemMapper.deleteItem", code);
	}

	public Item getItem(String code) {
		return this.sqlSession.selectOne("itemMapper.getItem", code);
	}

	public Integer getTotalItems() {
		return this.sqlSession.selectOne("itemMapper.getTotalItems");
	}

	@Override
	public List<Item> getItems(StartEnd se) {
		return this.sqlSession.selectList("itemMapper.getItems",se);
	}

	public List<Nation> getNation() {
		return this.sqlSession.selectList("itemMapper.getNations");
	}

	public Integer getCodeDup(String code) {
		return this.sqlSession.selectOne("itemMapper.getCodeDup",code);
	}

	public void putItem(Item item) {
		this.sqlSession.insert("itemMapper.putItems",item);
	}

}



