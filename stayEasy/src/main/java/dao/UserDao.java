package dao;

import model.LoginUser;
import model.User;
import model.UserId;
import model.UserInfo;
import model.UserPwd;

public interface UserDao {
	LoginUser loginUser(LoginUser user); //로그인에 사용
	LoginUser securityUser(LoginUser user); //보안
	void putUser(User user); //회원가입
	Integer idCheck(String id); //아이디 중복 검사
	String findId(UserId findId); //아이디 찾기
	String findPwd(UserPwd findPwd); //비밀번호 찾기
	User findUserById(String id); //id로 유저찾기
	UserInfo getUserInfo(UserPwd userPwd); //id로 유저 정보 불러오기
	void updateUserPwd(UserInfo userInfo); //회원가입시 암호화된 비밀번호 변경
	void changeUserPwd(LoginUser loginUser); //마이페이지 비밀번호 변경
	String getUserPwd(String user_id); //id로 비밀번호 불러오기
}
