package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.vo.Notice;

@Service
public class NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	public int addNotice(Notice notice) {
		System.out.println("NoticeService...addNotice");
		return noticeDao.addNotice(notice);
	}

	public int deleteNotice(int noticeId) {
		System.out.println("NoticeService...deleteNotice");
		return noticeDao.deleteNotice(noticeId);
	}

	public int updateNotice(Notice notice) {
		System.out.println("NoticeService...updateNotice");
		return noticeDao.updateNotice(notice);
	}

	public List<Notice> getNotices(Notice notice) {
		System.out.println("NoticeService...getNotices");
		return noticeDao.getNotices(notice);
	}
}
