package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.LoginUser;
import model.User;
import model.UserId;
import model.UserInfo;
import model.UserPwd;

@Repository
public class UserDaoImpl implements UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public LoginUser securityUser(LoginUser user) {
		return this.sqlSession.selectOne("loginMapper.securityUser",user);
	}

	@Override
	public LoginUser loginUser(LoginUser user) {
		return this.sqlSession.selectOne("loginMapper.loginUser", user);
	}

	@Override
	public void putUser(User user) {
		this.sqlSession.insert("loginMapper.putUser", user);
	}

	@Override
	public Integer idCheck(String id) {
		Integer count = this.sqlSession.selectOne("loginMapper.checkId", id);
		return count;
	}

	@Override
	public String findId(UserId findId) {
		return this.sqlSession.selectOne("findMapper.findId", findId);
	}

	@Override
	public String findPwd(UserPwd findPwd) {
		return this.sqlSession.selectOne("findMapper.findPwd", findPwd);
	}

	@Override
	public User findUserById(String id) {
		return this.sqlSession.selectOne("loginMapper.findUserById", id);
	}

	@Override
	public UserInfo getUserInfo(UserPwd userPwd) {
		return this.sqlSession.selectOne("findMapper.getUserInfo", userPwd);
	}

	@Override
	public void updateUserPwd(UserInfo userInfo) {
		this.sqlSession.update("findMapper.updateUserPwd", userInfo);
	}

	@Override
	public void changeUserPwd(LoginUser loginUser) {
		this.sqlSession.update("informationMapper.changeUserPwd", loginUser);
	}

	@Override
	public String getUserPwd(String user_id) {
		return this.sqlSession.selectOne("informationMapper.getUserPwd", user_id);
	}
	
}
