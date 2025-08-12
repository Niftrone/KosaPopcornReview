package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Review;
import com.service.popcornreview.vo.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	/**
	 * 댓글 추가 로직
	 * @param comment 폼에서 전송된 데이터 (rId, cPlot)
	 * @param session 현재 로그인한 사용자 정보를 가져오기 위함
	 * @param redirectAttributes 리다이렉트 시 간단한 메시지를 전달하기 위함
	 * @return 리뷰 상세 페이지로 리다이렉트
	 */
	@PostMapping("/add")
	public String addComment(Comment comment,HttpSession session, RedirectAttributes redirectAttributes) {
	    User loginUser = (User) session.getAttribute("loginUser"); // 세션에 저장된 속성 이름이 'loginUser'라고 가정
	    
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("error", "로그인이 필요한 서비스입니다.");
	        return "redirect:/review/" + comment.getrId();
	    }
	    System.out.println(comment);
	    commentService.addComment(comment);
	    
	    return "redirect:/review/" + comment.getReview().getrId();
	}
	
    @PostMapping("/{cId}/update")
    public String updateComment(Comment comment, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/review/" + comment.getReview().getrId();
        }
        commentService.updateComment(comment);
        return "redirect:/review/" + comment.getReview().getrId();
    }
    
    @PostMapping("/{cId}/delete")
    public String deleteComment(Comment comment, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
        		return "redirect:/review/" + comment.getReview().getrId();
        }
        commentService.deleteComment(comment.getcId());
        return "redirect:/review/" + comment.getReview().getrId();
    }
	
}
