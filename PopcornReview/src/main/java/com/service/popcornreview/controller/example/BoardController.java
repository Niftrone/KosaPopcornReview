package com.service.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.service.spring.domain.Board;
import com.service.spring.domain.Member;
import com.service.spring.service.BoardService;
import com.service.spring.service.MemberService;
import jakarta.servlet.http.HttpSession;

//Presentation Layer Component
//결과로 데이타를 담고 있는 jsp page를 리턴한다
@Controller 
public class BoardController {

    private final MemberService memberService;
	
	@Autowired
	private BoardService boardService;

    BoardController(MemberService memberService) {
        this.memberService = memberService;
    }
	
	@PostMapping("/write")
	public String write(Board pvo, Model model, HttpSession session) {
		Member rvo = (Member)session.getAttribute("mvo");
		if(rvo==null) return "redirect:index.jsp";
		try {
			pvo.setMember(rvo); //board + member
			model.addAttribute("bvo", pvo);
			boardService.write(pvo);//인자값으로 들어온 pvo는 위에 있는 pvo와는 다르다!!
			
			return "board/show_content";
		}catch(Exception e) {
			model.addAttribute("message", "SpringBoard 기시글 작성 - 에러발생");
			return "Error";
		}
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		
		try {
			System.out.println("왔어?");
			List<Board> list=boardService.getBoardList();
			System.out.println("왔어?");
			model.addAttribute("list", list);
			return "board/list";
		}catch(Exception e) {
			model.addAttribute("message", "Spring Board - 게시글 검색중 에러발생");
			return "Error";
		}
	}
	
	@GetMapping("/delete")
	public String doDelete(int no, Model model) {
		try {
			boardService.deleteBoard(no);
			return "redirect:/list";
		}catch(Exception e) {
			model.addAttribute("message", "Spring Board - 게시판 삭제중 에러발생");
			return "Error";
		}
	}
	@GetMapping("/updateFrom")
	public String updateVeiw(int no,Model model) {
		try {
			Board rvo=boardService.showContent(no);
			model.addAttribute("bvo", rvo);
			
			return "board/update";
		}catch(Exception e) {
			model.addAttribute("message", "Spring Board -게시판 수정폼 작성중 에러발생" );
			return "Error";
		}
	}	
	@PostMapping("/updateBoard")
	public String doUpdate(Board pvo, Model model) {
		try {
			boardService.updateBoard(pvo);
			
			Board rvo=boardService.showContent(pvo.getNo());
			model.addAttribute("bvo", rvo);
			return "board/show_content";
		}catch(Exception e) {
			model.addAttribute("message", "Spring Board -게시판 수정중 에러발생" );
			return "Error";
		}
	}
	
	@GetMapping("/showContent")
	public String showDetail(int no, Model model, HttpSession session) {
		Member rvo = (Member)session.getAttribute("mvo");
		if(rvo==null) return "redirect:index.jsp";
		try {
			//
			boardService.updateCount(no);
			
			Board bvo=boardService.showContent(no);
			model.addAttribute("bvo", bvo);
			
			return "board/show_content";
		}catch(Exception e) {
			model.addAttribute("message", "Spring Board -게시판 상세보기중 에러발생" );
			return "Error";
		}
	}
}

















