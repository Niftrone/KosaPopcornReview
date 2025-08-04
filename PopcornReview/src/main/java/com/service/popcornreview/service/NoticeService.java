package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Notice;

@Service
public class NoticeService {

	   @Autowired
	    private NoticeDao noticeDaoImpl;

	    public int addNotice(Notice notice) {
	        return noticeDaoImpl.addNotice(notice);
	    }

	    public int deleteNotice(int noticeId) {
	        return noticeDaoImpl.deleteNotice(noticeId);
	    }

	    public int updateNotice(Notice notice) {
	        return noticeDaoImpl.updateNotice(notice);
	    }

	    public List<Notice> getNotices(Notice notice) {
	        return noticeDaoImpl.getNotices(notice);
	    }
}
