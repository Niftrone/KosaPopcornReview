package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
@Repository
public class NoticeDao {
	
	public static final String NS = "ns.sql.NoticeMapper.";

    @Autowired
    private SqlSession sqlSession;

   
    public int addNotice(Notice notice) {
        return sqlSession.insert(NS + "addNotice", notice);
    }

 
    public int deleteNotice(int noticeId) {
        return sqlSession.delete(NS + "deleteNotice", noticeId);
    }

  
    public int updateNotice(Notice notice) {
        return sqlSession.update(NS + "updateNotice", notice);
    }

   
    public List<Notice> getNotices(Notice notice) {
        return sqlSession.selectList(NS + "getNotices", notice);
    }
}