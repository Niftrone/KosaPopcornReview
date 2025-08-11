package com.service.popcornreview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.service.popcornreview.service.CommentService;
import com.service.popcornreview.vo.Comment;
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
	public String addComment(Comment comment, HttpSession session, RedirectAttributes redirectAttributes) {
	    
		// 1. 세션에서 현재 로그인한 사용자 정보 가져오기
	    User loginUser = (User) session.getAttribute("loginUser"); // 세션에 저장된 속성 이름이 'loginUser'라고 가정
	    
	    
	    // 2. 로그인 상태 확인: 비로그인 상태면 댓글 작성을 막고 돌려보냄
	    if (loginUser == null) {
	        // 리다이렉트 페이지에 임시 경고 메시지 전달
	        redirectAttributes.addFlashAttribute("error", "로그인이 필요한 서비스입니다.");
	        // 원래 있던 리뷰 상세 페이지로 리다이렉트
	        return "redirect:/review/" + comment.getrId();
	    }
	    
	    // 3. 서버에서 가져온 안전한 사용자 ID를 comment 객체에 설정
	    // (클라이언트에서 보낸 userId 값은 무시하고 덮어씀)
	    comment.setid(loginUser.getId());
	    System.out.println(comment);
	    // 4. 댓글 추가 서비스 호출
	    commentService.addComment(comment);
	    
	    // 5. 댓글 추가 후, 원래 있던 리뷰 상세 페이지로 리다이렉트
	    return "redirect:/review/" + comment.getReview().getrId();
	}
}
