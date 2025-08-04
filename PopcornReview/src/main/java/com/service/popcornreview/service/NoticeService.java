package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.vo.Notice;

@Service
public class NoticeService {

	   @Autowired
	    private NoticeDao noticeDaoImpl;

	    public int addNotice(Notice notice) {
	    		System.out.println("NoticeService...addNotice");
	        return noticeDaoImpl.addNotice(notice);
	    }

	    public int deleteNotice(int noticeId) {
	    		System.out.println("NoticeService...deleteNotice");
	        return noticeDaoImpl.deleteNotice(noticeId);
	    }

	    public int updateNotice(Notice notice) {
	    		System.out.println("NoticeService...updateNotice");
	        return noticeDaoImpl.updateNotice(notice);
	    }

		public List<Notice> getNotices(Notice notice) {
			System.out.println("NoticeService...getNotices");
	        return noticeDaoImpl.getNotices(notice);
	    }
}
