package com.service.popcornreview.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Actor;

@Repository
public class ActorDao {

	public static final String NS = "ns.sql.ActorMapper.";

	@Autowired
	private SqlSession sqlSession;

	public Actor getActor(String aId) {
		System.out.println("ActorDao...getActor");
		return sqlSession.selectOne(NS + "getActor", aId);
	}

}
