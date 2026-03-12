package dao;

import model.LoginUser;
import model.User;

public interface UserDao {
	User getUserInfo(String id);//계정으로 사용자정보를 검색
	LoginUser getLoginUser(LoginUser user);//로그인에 사용
	void putUser(User user);//가입자 삽입
}
