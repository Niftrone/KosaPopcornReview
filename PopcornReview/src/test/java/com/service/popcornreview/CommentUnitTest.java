package com.service.popcornreview;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

public class CommentUnitTest {

	public static void main(String[] args) throws IOException {
		Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(r);
        SqlSession session = factory.openSession(true); // auto-commit

        String NS = "ns.sql.CommentMapper.";

        User user = new User("user02", "pwd02", "user02@test.com", "이서연", "1992-05-20", "010-2222-2222", false);
        Review review = new Review();
        review.setrId(1);

        // 1. INSERT 테스트
        Comment newComment = new Comment();
        newComment.setcId(100); // 적절한 PK 또는 AUTO_INCREMENT면 null
        newComment.setcPlot("단위 테스트 댓글입니다");
        newComment.setUser(user);
        newComment.setReview(review);
        session.insert(NS + "addComment", newComment);
        System.out.println("댓글 등록 성공");

        // 2. SELECT 테스트
        Comment searchCondition = new Comment();
        searchCondition.setUser(user);
        searchCondition.setReview(review);
        List<Comment> commentList = session.selectList(NS + "getComments", searchCondition);
        for (Comment c : commentList) {
            System.out.println("조회된 댓글: " + c.getcPlot() + " | 작성자: " + c.getUser().getName());
        }

        // 3. UPDATE 테스트
        newComment.setcPlot("댓글 수정 테스트입니다");
        session.update(NS + "updateComment", newComment);
        System.out.println("댓글 수정 완료");

        // 4. DELETE 테스트
        session.delete(NS + "deleteComment", newComment.getcId());
        System.out.println("댓글 삭제 완료");

        session.close();
    }

}
