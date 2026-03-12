package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;

import org.springframework.stereotype.Repository;
@Repository
public class SalesDaoImpl implements SalesDao {
	private EntityManagerFactory emf;
	@PersistenceUnit
	public void setEmf(EntityManagerFactory emf) {
		this.emf = emf;
	}
	public List<Object[]> getSales(String id) {
		EntityManager em = this.emf.createEntityManager();
		List<Object[]> list = 
			em.createQuery(
				"FROM Sales_tbl AS sales INNER JOIN sales.details "
				+ "where sales.user_id = :id ",Object[].class)
			.setParameter("id", id).getResultList();
		return list;
	}

}














