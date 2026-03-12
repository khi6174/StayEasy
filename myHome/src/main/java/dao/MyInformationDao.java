package dao;

import model.User_info;

public interface MyInformationDao {
	User_info getUser(String id);//계정으로 정보 조회
	void updateMyInfomation(User_info user);//정보 수정
}
