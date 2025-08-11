package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.vo.ReportedReview;

@Service
public class ReportService {

	@Autowired
	private ReportDao reportDao;
	@Autowired
	private ReviewDao reviewDao;

	public int insertReported(ReportedReview reportedReview) {
		System.out.println("ReportService...insertReported");
		return reportDao.insertReported(reportedReview);
	}

	public int deleteReported(int rrId) {
		System.out.println("ReportService...deleteReported");
		return reportDao.deleteReported(rrId);
	}
	
	@Transactional
	public void deleteReviewAndAssociatedReports(int rrId) {
		System.out.println("ReportService...deleteReviewAndAssociatedReports");

		// 1. 리뷰 ID에 연결된 모든 신고 내역 삭제
		reportDao.deleteReportByReviewId(rrId);

		// 2. 원본 리뷰 삭제 (ReviewDao에 리뷰를 삭제하는 메서드가 있다고 가정)
		reviewDao.deleteReview(rrId);
	}

	public List<ReportedReview> getReported() {
		System.out.println("ReportService...getReported");
		return reportDao.getReported();
	}
}
