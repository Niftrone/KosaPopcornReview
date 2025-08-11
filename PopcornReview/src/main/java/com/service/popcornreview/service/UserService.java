package com.service.popcornreview.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	@Autowired
    private CommentDao commentDao; // Add CommentDao

    @Autowired
    private ReviewDao reviewDao; // Add ReviewDa
	
	
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
		// Step 1: Delete all comments written by the user.
        commentDao.deleteCommentsByUserId(id);

        // Step 2: Delete all reviews written by the user.
        reviewDao.deleteReviewsByUserId(id);

        // Step 3: Now it's safe to delete the user.
        return userDao.deleteUser(id);
	
	}

	public User getUser(User user) {
		System.out.println("UserService...getUser");
		return userDao.getUser(user);
	}
}
