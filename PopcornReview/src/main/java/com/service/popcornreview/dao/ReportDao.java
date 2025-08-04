package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.ReportedReview;

@Repository
public class ReportDao {

	public static final String NS = "ns.sql.ReportMapper.";

	@Autowired
	private SqlSession sqlSession;

	public int insertReported(ReportedReview reportedReview) {
		System.out.println("ReportDao...insertReported");
		return sqlSession.insert(NS + "insertReported", reportedReview);
	}

	public int deleteReported(int rrId) {
		System.out.println("ReportDao...deleteReported");
		return sqlSession.delete(NS + "deleteReported", rrId);
	}

	public List<ReportedReview> getReported() {
		System.out.println("ReportDao...getReported");
		return sqlSession.selectList(NS + "getReported");
	}
}