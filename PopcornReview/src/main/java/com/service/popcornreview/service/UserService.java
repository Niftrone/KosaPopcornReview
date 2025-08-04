package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.ReportedReview;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

@Service
public class UserService {

	 @Autowired
	    private UserDao userDaoImpl;

	    public int addUser(User user) {
	        return userDaoImpl.addUser(user);
	    }

	    public int updateUser(User user) {
	        return userDaoImpl.updateUser(user);
	    }

	    public int deleteUser(String id) {
	        return userDaoImpl.deleteUser(id);
	    }

	    public User getUser(User user) {
	        return userDaoImpl.getUser(user);
	    }
}
