package com.service.popcornreview.service;

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

}
