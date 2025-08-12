package com.service.popcornreview.dao;

import java.util.List;
import java.util.Map;

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
	
	// [추가] 이름으로 배우 검색 영화추가 할때 검색 리스트
	public List<Actor> searchActorsByName(Map<String, String> params) {
	    return sqlSession.selectList(NS + "searchActorsByName", params);
	}
	
	// [추가] 이름으로 배우 정보를 조회하는 메서드
	public Actor getActorByName(String name) {
	    System.out.println("ActorDao...getActorByName");
	    return sqlSession.selectOne(NS + "getActorByName", name);
	}
}
