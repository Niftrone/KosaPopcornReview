package com.service.popcornreview.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	/**
	 * 이름으로 배우를 검색합니다. (역할<role>은 향후 확장을 위해 유지)
	 * @param name 배우 이름
	 * @param role 역할 (e.g., "director", "actor")
	 * @return 검색된 배우 목록
	 */
	public List<Actor> searchActorsByName(String name, String role) {
	    Map<String, String> params = new HashMap<>();
	    params.put("name", name);
	    if (role != null && !role.isEmpty()) {
	        params.put("role", role);
	    }
	    return actorDao.searchActorsByName(params);
	}
	
	/**
	 * 정확한 이름으로 배우 정보를 조회합니다.
	 * @param name 배우 이름
	 * @return 배우 정보
	 */
	public Actor getActorByName(String name) {
	    return actorDao.getActorByName(name);
	}
	
	/**
	 * ID로 배우 정보를 조회합니다.
	 * @param aId 배우 ID
	 * @return 배우 정보
	 */
	public Actor getActorById(String aId) {
	    return actorDao.getActor(aId);
	}
	
	// 삭제된 메소드:
	/*
	public List<Actor> searchByName(String name) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("name", name == null ? "" : name);
	    return actorDao.searchActorsByName(params); // <- 이 부분이 타입 오류를 유발했습니다.
	}
	*/
}