package com.service.popcornreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.service.popcornreview.dao.CommentDao;
import com.service.popcornreview.dao.ReportDao;
import com.service.popcornreview.dao.ReviewDao;
import com.service.popcornreview.vo.ReportedReview;

@Service
public class ReportService {

	@Autowired
	private ReportDao reportDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private CommentDao commentDao;
	// [추가] 전체 신고 목록 조회를 위한 서비스 메소드
	public List<ReportedReview> getReported() {
	    System.out.println("ReportService...getReported");
	    return reportDao.getReported();
	}
	

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
	    // 1. rrId로 신고 정보를 가져와서 원본 리뷰 ID를 확보합니다.
	    ReportedReview reportedReview = reportDao.getReportedReviewById(rrId);
	    
	    // 2. 신고 기록 또는 원본 리뷰가 없는 경우에 대한 예외 처리
	    if (reportedReview == null) {
	        throw new IllegalArgumentException("ID " + rrId + "에 해당하는 신고 기록이 없습니다.");
	    }
	    if (reportedReview.getReview() == null) {
	        // 원본 리뷰가 없는 고아 데이터의 경우, 신고 기록만 삭제하고 종료
	        System.out.println("신고 기록(rrId: " + rrId + ")에 연결된 원본 리뷰를 찾을 수 없습니다. 신고 기록만 삭제합니다.");
	        reportDao.deleteReported(rrId);
	        return;
	    }
	    
	    // 3. 원본 리뷰 ID를 가져옵니다.
	    int originalReviewId = reportedReview.getReview().getrId();

	    // 4. ★★★ 원본 리뷰만 삭제합니다. ★★★
	    // ON DELETE CASCADE 설정에 의해 관련된 댓글과 모든 신고 기록은
	    // 데이터베이스가 자동으로 함께 삭제해줍니다.
	    reviewDao.deleteReview(originalReviewId);
	}
}
