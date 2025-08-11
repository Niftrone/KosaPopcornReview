package com.service.popcornreview;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.service.popcornreview.vo.Notice;


public class NoticeUnitTest {

    public static void main(String[] args) throws IOException {
        Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession(true); // auto-commit

        String NS = "ns.sql.NoticeMapper.";

        // 1. INSERT 테스트
        Notice n = new Notice();
        n.setNoticeId(100);
        n.setNotice("공지사항 제목입니다.");
        n.setNoticePlot("이것은 공지사항의 내용입니다.");

        int insertResult = session.insert(NS + "addNotice", n);
        System.out.println(" INSERT 결과: " + insertResult);

        // 2. UPDATE 테스트
        n.setNotice("수정된 제목");
        n.setNoticePlot("수정된 내용입니다.");

        int updateResult = session.update(NS + "updateNotice", n);
        System.out.println(" UPDATE 결과: " + updateResult);

        // 3. SELECT 테스트 (전체 조회)
        List<Notice> list = session.selectList(NS + "getNotices", new Notice());
        System.out.println(" SELECT 전체 결과:");
        for (Notice no : list) {
            System.out.println(no);
        }

        // 4. SELECT 테스트 (조건 조회: noticeId로)
        Notice param = new Notice();
        param.setNoticeId(100);
        List<Notice> byId = session.selectList(NS + "getNotices", param);
        System.out.println(" SELECT by ID 결과:");
        for (Notice no : byId) {
            System.out.println(no);
        }

        // 5. DELETE 테스트
        int deleteResult = session.delete(NS + "deleteNotice", 100);
        System.out.println(" DELETE 결과: " + deleteResult);

        session.close();
    }

}
