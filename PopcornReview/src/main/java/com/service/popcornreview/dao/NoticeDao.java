package com.service.popcornreview.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.popcornreview.vo.Notice;

@Repository
public class NoticeDao {

	public static final String NS = "ns.sql.NoticeMapper.";

	@Autowired
	private SqlSession sqlSession;

	public int addNotice(Notice notice) {
		System.out.println("NoticeDao...addNotice");
		return sqlSession.insert(NS + "addNotice", notice);
	}

	public int deleteNotice(int noticeId) {
		System.out.println("NoticeDao...deleteNotice");
		return sqlSession.delete(NS + "deleteNotice", noticeId);
	}

	public int updateNotice(Notice notice) {
		System.out.println("NoticeDao...updateNotice");
		return sqlSession.update(NS + "updateNotice", notice);
	}

	public List<Notice> getNotices(Notice notice) {
		System.out.println("NoticeDao...getNotices");
		return sqlSession.selectList(NS + "getNotices", notice);
//		List<Notice> noticeList = sqlSession.selectList(NS + "getNotices", notice); 
//	    System.out.println("조회된 공지사항 목록: " + noticeList); 
//	    return noticeList; // 리턴
	}
}