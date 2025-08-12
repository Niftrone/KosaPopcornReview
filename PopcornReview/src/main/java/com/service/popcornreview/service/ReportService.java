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
	
	// [추가] 전체 신고 목록 조회를 위한 서비스 메소드
	public List<ReportedReview> getReported() {
	    System.out.println("ReportService...getReported");
	    return reportDao.getReported();
	}
	

	public int insertReported(ReportedReview reportedReview) {
		System.out.println("ReportService...insertReported");
		System.out.println(reportedReview);
		return reportDao.insertReported(reportedReview);
	}

	public int deleteReported(int rrId) {
		System.out.println("ReportService...deleteReported");
		return reportDao.deleteReported(rrId);
	}
	
	@Transactional
	public void deleteReviewAndAssociatedReports(int rrId) {
        // 1. 전달받은 rrId로 신고 정보를 가져와서 원본 리뷰의 ID(rId)를 확보합니다.
        ReportedReview reportedReview = reportDao.getReportedReviewById(rrId); // 이 메소드가 없다면 만들어야 합니다.
        if (reportedReview == null) {
            // 이미 삭제되었거나 없는 경우, 여기서 로직을 중단합니다.
            System.out.println("삭제할 신고 리뷰를 찾을 수 없습니다. rrId: " + rrId);
            return;
        }
        int originalReviewId = reportedReview.getReview().getrId();

        // 2. 원본 리뷰 ID에 연결된 '모든' 신고 기록을 먼저 삭제합니다. (외래 키 제약 해결)
        reportDao.deleteAllReportsByReviewId(originalReviewId);

        // 3. 이제 안전하게 원본 리뷰를 삭제합니다.
        reviewDao.deleteReview(originalReviewId); // Review를 삭제하는 기존 DAO 메소드 호출
    }
}
