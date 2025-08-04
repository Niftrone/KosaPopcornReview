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

public class MyBatisUnitTest {
	private static final String NS = "ns.sql.ReportMapper.";
	private SqlSession getSqlSession() throws Exception {
		Reader reader = Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(reader);
		SqlSession session = factory.openSession();
		return session;
	}
	
	@Test
	public void insertReported() throws Exception {
		
		SqlSession session = getSqlSession();
		ReportedReview reported = new ReportedReview();
		User user = new User();
		user.setId("user04");
		reported.setRrPlot("있잖아 내가 있잖아...");
		reported.setUser(user);
		Review review = new Review();
		review.setrId(5);
		reported.setReview(review);
		int lines = session.insert(NS+"insertReported",reported);
		session.commit();
		System.out.println(lines);
		session.close();
	}
	
	@Test
	public void deleteReported() throws Exception {
		/*
		 * SqlSession session = getSqlSession(); int rrId = 1; int lines =
		 * session.delete(NS+"deleteReported",rrId); session.commit();
		 * System.out.println(lines); session.close();
		 */
		
	}
	
	@Test
	public void getReported() throws Exception {
		SqlSession session = getSqlSession();
		List<ReportedReview> list = session.selectList(NS+"getReported");
		for (ReportedReview r : list) {
            System.out.println("📱 Phone: " + r);
        }
		
		
	}

}
