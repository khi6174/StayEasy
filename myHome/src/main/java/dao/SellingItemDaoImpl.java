package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;

import org.springframework.stereotype.Repository;

import model.SellingItem;
@Repository
public class SellingItemDaoImpl implements SellingItemDao {
	private EntityManagerFactory emf;
	@PersistenceUnit
	public void setEmf(EntityManagerFactory emf) {
		this.emf = emf;
	}

	public SellingItem getItem(String code) {
		EntityManager em = this.emf.createEntityManager();
		return em.find(SellingItem.class, code);//기본키로 상품 조회
	}

}





