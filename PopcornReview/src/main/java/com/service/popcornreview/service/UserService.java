package com.service.popcornreview.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	public int addUser(User user) {
		System.out.println("UserService...addUser");
		return userDao.addUser(user);
	}

	public int updateUser(User user) {
		System.out.println("UserService...updateUser");
		return userDao.updateUser(user);
	}

	public int deleteUser(String id) {
		System.out.println("UserService...deleteUser");
		return userDao.deleteUser(id);
	}

	public User getUser(User user) {
		System.out.println("UserService...getUser");
		return userDao.getUser(user);
	}
}
