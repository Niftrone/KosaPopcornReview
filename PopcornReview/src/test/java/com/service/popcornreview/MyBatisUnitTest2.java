package com.service.popcornreview;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import com.service.popcornreview.vo.ReportedReview;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

public class MyBatisUnitTest2 {
	private static final String NS = "ns.sql.ReviewrMapper.";
	private SqlSession getSqlSession() throws Exception {
		Reader reader = Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(reader);
		SqlSession session = factory.openSession();
		return session;
	}
	
	@Test
	public void getAllReviews() throws Exception {
		
		SqlSession session = getSqlSession();
		List<Review> list = session.selectList(NS+"getAllReviews");
		for (Review r : list) {
            System.out.println("신고된 리뷰 : " + r);
        }
		
		
	}

}
