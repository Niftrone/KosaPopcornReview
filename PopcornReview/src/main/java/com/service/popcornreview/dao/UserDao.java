package com.service.popcornreview.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.User;

@Repository
public class UserDao {

	public static final String NS = "ns.sql.UserMapper.";

	@Autowired
	private SqlSession sqlSession;

	public int addUser(User user) {
		System.out.println("UserDao...addUser");
		return sqlSession.insert(NS + "addUser", user);
	}

	public int updateUser(User user) {
		System.out.println("UserDao...updateUser");
		return sqlSession.update(NS + "updateUser", user);
	}

	public int deleteUser(String id) {
		System.out.println("UserDao...deleteUser");
		return sqlSession.delete(NS + "deleteUser", id);
	}

	public User getUser(User user) {
		System.out.println("UserDao...getUser");
		return sqlSession.selectOne(NS + "getUser", user);
	}
}