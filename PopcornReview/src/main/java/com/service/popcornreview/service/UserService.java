package com.service.popcornreview.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDaoImpl;

	public int addUser(User user) {
		System.out.println("UserService...addUser");
		return userDaoImpl.addUser(user);
	}

	public int updateUser(User user) {
		System.out.println("UserService...updateUser");
		return userDaoImpl.updateUser(user);
	}

	public int deleteUser(String id) {
		System.out.println("UserService...deleteUser");
		return userDaoImpl.deleteUser(id);
	}

	public User getUser(User user) {
		System.out.println("UserService...getUser");
		return userDaoImpl.getUser(user);
	}
}
