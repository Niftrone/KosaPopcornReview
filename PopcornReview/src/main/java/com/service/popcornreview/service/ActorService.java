package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.vo.Actor;

@Service
public class ActorService {

	@Autowired
	private ActorDao actorDao;

	public Actor getActor(String aId) {
		System.out.println("ActorService...getActor");


		return actorDao.getActor(aId);
	}

	// [추가] 이름으로 배우 검색
	public List<Actor> searchActorsByName(String name) {
	    return actorDao.searchActorsByName(name);
	}
	
	// [추가] 이름으로 배우 정보를 조회하는 메서드
	public Actor getActorByName(String name) {
	    return actorDao.getActorByName(name);
	}
	
	public Actor getActorById(String aId) {
	    return actorDao.getActor(aId);
	}
	
}
