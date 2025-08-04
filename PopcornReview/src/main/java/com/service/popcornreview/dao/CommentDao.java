package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
@Repository
public class CommentDao {
	
	  public static final String NS = "ns.sql.CommentMapper.";

	    @Autowired
	    private SqlSession sqlSession;

	   
	    public int addComment(Comment comment) {
	        return sqlSession.insert(NS + "addComment", comment);
	    }

	   
	    public int deleteComment(int cId) {
	        return sqlSession.delete(NS + "deleteComment", cId);
	    }

	    
	    public int updateComment(Comment comment) {
	        return sqlSession.update(NS + "updateComment", comment);
	    }

	    
	    public List<Comment> getComments(Comment comment) {
	        return sqlSession.selectList(NS + "getComments", comment);

}
}