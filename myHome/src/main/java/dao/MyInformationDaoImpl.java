package dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceUnit;

import org.springframework.stereotype.Repository;

import model.User_info;
@Repository
public class MyInformationDaoImpl implements MyInformationDao {
	private EntityManagerFactory emf;
	
	@PersistenceUnit
	public void setEmf(EntityManagerFactory emf) {
		this.emf = emf;
	}
	public User_info getUser(String id) {
		EntityManager em = this.emf.createEntityManager();
		return em.find(User_info.class, id);//기본키로 조회
	}
	public void updateMyInfomation(User_info user) {
		EntityManager em = this.emf.createEntityManager();
		EntityTransaction trx = em.getTransaction();
		//ORM 트랙잭션을 생성한다.
		trx.begin();//트랜잭션을 시작
		em.merge(user);//가입자 정보 수정(변경된 항목 수정)
		trx.commit();//커밋으로 트랜잭션 종료
	}

}




