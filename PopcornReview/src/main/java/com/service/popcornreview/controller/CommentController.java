package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.vo.Comment;
import com.service.popcornreview.vo.Review;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	@PostMapping("/add")
	public String addComment(Comment comment,HttpSession session ,RedirectAttributes redirectAttributes) {
	    // userId, reviewId null 체크
	    if (comment.getId() == null || comment.getId().isEmpty()
	        || comment.getrId() == 0) {
	        redirectAttributes.addFlashAttribute("error", "auth_required");
	        return "redirect:/review/" + comment.getrId(); // 리뷰 ID도 없을 수 있음 주의
	    }
	    comment.setReview((Review) session.getAttribute("reviewDetail"));
	    
	    commentService.addComment(comment);
	    return "redirect:/review/" + comment.getrId();
	}
}
