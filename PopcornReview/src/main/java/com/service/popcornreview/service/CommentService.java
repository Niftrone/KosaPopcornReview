package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.dao.UserDao;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

@Service
public class CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ReviewDao reviewDao;

	public int addComment(Comment comment) {
	    System.out.println("CommentService...addComment");

	    if (comment.getUser() == null || comment.getUser().getId() == null) {
	        throw new IllegalArgumentException("User ID는 null일 수 없습니다.");
	    }

	    if (comment.getReview() == null || comment.getReview().getrId() == 0) {
	        throw new IllegalArgumentException("Review ID는 null일 수 없습니다.");
	    }

	    return commentDao.addComment(comment);
	}
	
	public int deleteComment(int cId) {
		System.out.println("CommentService...deleteComment");
		return commentDao.deleteComment(cId);
	}

	public int updateComment(Comment comment) {
		System.out.println("CommentService...updateComment");
		return commentDao.updateComment(comment);
	}

	public List<Comment> getComments(Comment comment) {
	    System.out.println("CommentService...getComments");
	    List<Comment> list = commentDao.getComments(comment);

	    for (Comment c : list) {
	        // 1. User 정보 채우기
	        User partialUser = c.getUser();
	        if (partialUser != null && partialUser.getId() != null) {
	            User fullUser = userDao.getUser(partialUser);
	            if (fullUser != null) {
	                c.setUser(fullUser);
	            }
	        }

	        // 2. Review 정보 채우기
	        Review partialReview = c.getReview();
	        if (partialReview != null && partialReview.getrId() != 0) {
	            Review fullReview = reviewDao.getReview(partialReview);
	            if (fullReview != null) {
	                c.setReview(fullReview);
	            }
	        }
	    }

	    return list;
	}

}
