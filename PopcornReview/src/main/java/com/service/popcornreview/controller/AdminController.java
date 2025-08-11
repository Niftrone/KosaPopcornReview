package com.service.popcornreview.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.service.popcornreview.vo.Notice;
import com.service.popcornreview.service.ActorService;
import com.service.popcornreview.service.MovieService;
import com.service.popcornreview.service.NoticeService;
import com.service.popcornreview.service.ReportService;
import com.service.popcornreview.vo.Actor;
import com.service.popcornreview.vo.Movie;
import com.service.popcornreview.vo.ReportedReview;

@Controller
public class AdminController {
	
	@Autowired private MovieService  movieService;
    @Autowired private NoticeService noticeService;
    @Autowired private ReportService reportService;
    @Autowired private ActorService  actorService;

    /* ---------- 커스텀 바인더 (변경 없음) ---------- */
    @InitBinder
    public void bindActors(WebDataBinder binder) {
        binder.registerCustomEditor(List.class, "actors",
            new CustomCollectionEditor(List.class) {
                @Override
                protected Object convertElement(Object element) {
                    if (element == null) return null;

                    String actorId = element.toString().trim();
                    if (actorId.isEmpty()) return null;

                    // 문자열 ID로 배우 조회
                    return actorService.getActorById(actorId);
                }
            });
    }
	// [수정] /admin과 /admin/list 요청을 하나의 메서드에서 처리하도록 통합
    @GetMapping({"/admin", "/admin/list"})
    public String adminHome(Model model) {
	    System.out.println("✔ adminHome 진입");
	  	
        List<Movie> movieList = movieService.getAllMovies(new Movie());
        List<Notice> noticeList = noticeService.getNotices(new Notice());
        List<ReportedReview> reportList = reportService.getReported();

        model.addAttribute("movieList", movieList);
        model.addAttribute("noticeList",noticeList);
        model.addAttribute("reportList",reportList);
        
        return "admin";
    }
	  
	  //공지사항 검색 (변경 없음)
	  @GetMapping("/admin/notice/search")
	  public String doNoticeSerch(String keyword, Model model) {
		  try {
		      
			  	Notice serarch = new Notice();
			  	serarch.setNotice(keyword);
			  
		        List<Notice> noticeList = noticeService.getNotices(serarch);
		        
		        model.addAttribute("noticeList", noticeList);
		        model.addAttribute("activeSection", "notice");
		        
		        model.addAttribute("movieList", movieService.getAllMovies(new Movie()));
		        model.addAttribute("reportList", reportService.getReported());
		        
		        return "admin";
		    } catch (Exception e) {
		        model.addAttribute("errorMessage", "검색 중 오류가 발생했습니다.");
		        return "error";
		    }
	  }
	  
	  //영화 검색
	  @GetMapping("/admin/movie/search")
	  public String doMovieSerch(String keyword, Model model) {
		  try {
			  	Movie serarch = new Movie();
			  	serarch.setmTitle(keyword);
			  
		        List<Movie> movieList = movieService.getAllMovies(serarch);
		        model.addAttribute("movieList", movieList);
		        
		        
		        model.addAttribute("noticeList", noticeService.getNotices(new Notice()));
		        model.addAttribute("reportList", reportService.getReported());
		        
		        // 활성화될 섹션을 모델에 담아 전달
		        model.addAttribute("activeSection", "movie");

		        return "admin"; // redirect 대신 admin 뷰를 직접 반환
		        
		    } catch (Exception e) {
		        model.addAttribute("errorMessage", "검색 중 오류가 발생했습니다.");
		        return "error";
		    }
	  }
	 
	// ADMIN-01: 영화 정보 등록 (POST)
	@PostMapping("admin/movie/add")
	public String addMovie(Movie movie,Model model, RedirectAttributes ra) {
		System.out.println("왔니?");
        try {
            movieService.addMovie(movie);
            ra.addFlashAttribute("message", "영화 등록 완료.");
            
		    return "redirect:/admin/list?section=movie";
        } catch (Exception e) {
        
        	model.addAttribute("errorMessage", "영화 등록 실패. 오류: " + e.getMessage());
            return "error";
        }
	}
	
	// ADMIN-02: 영화 정보 수정 
	@PostMapping("/admin/movie/update")
	public String doUpdateMovie(Movie movie,Model model, RedirectAttributes ra) {
		try {
			System.out.println("movie 업데이트 진입");
			movieService.updateMovie(movie);
			ra.addFlashAttribute("message","영화정보가 수정되었습니다.");
			
	        return "redirect:/admin/list?section=movie";
		} catch (Exception e) {
			model.addAttribute("errorMessage","영화 수정 실패 했습니다");
			return "error";
		}
	}
	
	// ADMIN-03: 영화 정보 삭제 (POST)
	@PostMapping("/admin/movie/delete")
	public String doDeleteMovie( int mId, Model model, RedirectAttributes ra) {
		try {
			System.out.println("삭제 진입");
			movieService.deleteMovie(mId);
			ra.addFlashAttribute("message","영화가 삭제되었습니다.");
			
	        return "redirect:/admin/list?section=movie";
		} catch (Exception e) {
			model.addAttribute("errorMessage","영화 삭제 실패 했습니다"+e.getMessage());
			return "error"; 
		}
	}

	// ADMIN-05: 리뷰 삭제 (POST) (변경 없음)
	@PostMapping("/admin/review/delete")
	public String doDeleteReviewAdmin(Integer rrId, Model model, RedirectAttributes ra) {
	    try {
	        System.out.println("신고리뷰 및 원본리뷰 삭제 진입");
	        
	        // [수정] 새로 만든 서비스 메서드를 호출합니다.
	        reportService.deleteReviewAndAssociatedReports(rrId);
	        
	        ra.addFlashAttribute("message", "리뷰가 성공적으로 삭제되었습니다.");
	        return "redirect:/admin/list?section=report";
	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "리뷰 삭제 중 오류가 발생했습니다: " + e.getMessage());
	        return "error";
	    }
	}

	// ADMIN-07: 공지사항 등록 (POST) (변경 없음)
	@PostMapping("/admin/notice/add")
	public String doAddNotice(Notice notice,Model model, RedirectAttributes ra) {
		try {
			System.out.println("공지사항 등록 진입");
			noticeService.addNotice(notice);
			ra.addFlashAttribute("message","공지사항 등록 되었습니다.");
			return "redirect:/admin/list?section=notice"; // [수정] 일관성을 위해 /admin/list 로 경로 변경
		} catch (Exception e) {
			model.addAttribute("errormessage","공지사항 등록을 실패했습니다.");
			return "error";
		}
	}

	// ADMIN-08: 공지사항 수정 (POST) (변경 없음)
	@PostMapping("/admin/notice/update")
	public String doUpdateNotice(Notice notice,Model model, RedirectAttributes ra) {
		 try {
			System.out.println("공지사항 수정 진입 완료 ");
			noticeService.updateNotice(notice);
			ra.addFlashAttribute("message","공지사항 수정 완료 되었습니다.");
			return "redirect:/admin/list?section=notice"; // [수정] 일관성을 위해 /admin/list 로 경로 변경
		} catch (Exception e) {
			model.addAttribute("errorMessage","공지사항 수정을 실패 했습니다.");
			return "error";
		}
	}

	// ADMIN-09: 공지사항 삭제 (POST) (변경 없음)
	@PostMapping("/admin/notice/delete")
	public String doDeleteNotice(int noticeId , Model model, RedirectAttributes ra ) {
		 try {
				System.out.println("공지사항 삭제 진입 완료 ");
				noticeService.deleteNotice(noticeId);
				ra.addFlashAttribute("message","공지사항 삭제 완료 되었습니다.");
				return "redirect:/admin/list?section=notice"; // [수정] 일관성을 위해 /admin/list 로 경로 변경
			} catch (Exception e) {
				model.addAttribute("errormessage","공지사항 삭제 실패 했습니다.");
				return "error";
			}
    }
	
	 // [추가] 배우 검색 API 메서드
    @GetMapping("/api/actors/search")
    @ResponseBody // 3. 이 메서드의 반환값은 뷰가 아닌 데이터(JSON)임을 명시
    public List<Actor> searchActors(@RequestParam("name") String name) {
        return actorService.searchActorsByName(name);
    }
}