package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;
@Repository
public class UserDao {
	

    public static final String NS = "ns.sql.UserMapper.";

    @Autowired
    private SqlSession sqlSession;

    
    public int addUser(User user) {
        return sqlSession.insert(NS + "addUser", user);
    }

    
    public int updateUser(User user) {
        return sqlSession.update(NS + "updateUser", user);
    }

   
    public int deleteUser(String id) {
        return sqlSession.delete(NS + "deleteUser", id);
    }

 
    public User getUser(User user) {
        return sqlSession.selectOne(NS + "getUser", user);
    }
}