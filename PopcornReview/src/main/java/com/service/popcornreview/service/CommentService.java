package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.vo.Comment;

@Service
public class CommentService {

	@Autowired
	private CommentDao commentDaoImpl;

	public int addComment(Comment comment) {
		System.out.println("CommentService...addComment");
		return commentDaoImpl.addComment(comment);
	}

	public int deleteComment(int cId) {
		System.out.println("CommentService...deleteComment");
		return commentDaoImpl.deleteComment(cId);
	}

	public int updateComment(Comment comment) {
		System.out.println("CommentService...updateComment");
		return commentDaoImpl.updateComment(comment);
	}

	public List<Comment> getComments(Comment comment) {
		System.out.println("CommentService...getComments");
		return commentDaoImpl.getComments(comment);
	}

}
