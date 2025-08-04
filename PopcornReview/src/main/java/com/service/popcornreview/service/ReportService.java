package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ActorDao;
import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.NoticeDao;
import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.vo.ReportedReview;

@Service
public class ReportService {

	 @Autowired
	    private ReportDao reportDaoImpl;

	    public int insertReported(ReportedReview reportedReview) {
	        return reportDaoImpl.insertReported(reportedReview);
	    }

	    public int deleteReported(int rrId) {
	        return reportDaoImpl.deleteReported(rrId);
	    }


	    public List<ReportedReview> getReported() {
	        return reportDaoImpl.getReported();
	    }
}
