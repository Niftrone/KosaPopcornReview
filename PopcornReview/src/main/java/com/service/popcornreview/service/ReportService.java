package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.vo.ReportedReview;

@Service
public class ReportService {

	@Autowired
	private ReportDao reportDao;

	public int insertReported(ReportedReview reportedReview) {
		System.out.println("ReportService...insertReported");
		return reportDao.insertReported(reportedReview);
	}

	public int deleteReported(int rrId) {
		System.out.println("ReportService...deleteReported");
		return reportDao.deleteReported(rrId);
	}

	public List<ReportedReview> getReported() {
		System.out.println("ReportService...getReported");
		return reportDao.getReported();
	}
}
