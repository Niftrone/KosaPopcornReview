package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.ReportedReview;
@Repository
public class ReportDao {
	
	public static final String NS = "ns.sql.ReportMapper.";

    @Autowired
    private SqlSession sqlSession;

 
    public int insertReported(ReportedReview reportedReview) {
        return sqlSession.insert(NS + "insertReported", reportedReview);
    }

    
    public int deleteReported(int rrId) {
        return sqlSession.delete(NS + "deleteReported", rrId);
    }

    public List<ReportedReview> getReported() {
        return sqlSession.selectList(NS + "getReported");
    }
}