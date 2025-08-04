package com.service.popcornreview;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.service.popcornreview.vo.Actor;

public class actorUnitTest {

	public static void main(String[] args) throws IOException {
		Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
		SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
		SqlSession session = factory.openSession();
		String NS = "ns.sql.ActorMapper.";
		
		Actor a = session.selectOne(NS + "getActor", "a01");
		System.out.println(a);
		
	}

}
