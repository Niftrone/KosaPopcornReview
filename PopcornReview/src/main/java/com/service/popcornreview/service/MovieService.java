package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;

@Service
public class MovieService {

	@Autowired
    private CommentDao commentDaoImpl;

    public int addComment(Comment comment) {
        return commentDaoImpl.addComment(comment);
    }

    public int deleteComment(int cId) {
        return commentDaoImpl.deleteComment(cId);
    }

    public int updateComment(Comment comment) {
        return commentDaoImpl.updateComment(comment);
    }

    public List<Comment> getComments(Comment comment) {
        return commentDaoImpl.getComments(comment);
    }
}
