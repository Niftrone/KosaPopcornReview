<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${movie.mTitle} - 영화 상세 정보</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
    body {
        background-color: #121212;
        color: #e0e0e0;
        font-family: 'Noto Sans KR', sans-serif;
    }
    .container {
        margin-top: 40px;
        margin-bottom: 100px; /* 맨 아래 리뷰와 푸터 사이 여백 추가 */
    }
    .movie-header h1 {
        font-weight: 700;
        font-size: 3rem;
    }
    .poster-img {
        width: 100%;
        border-radius: 10px;
    }
    .section-title {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 20px;
        border-left: 4px solid #E50914;
        padding-left: 10px;
    }
    .actor-circle {
        text-align: center;
        margin-bottom: 15px;
    }
    .actor-img {
        width: 180px;
        height: 180px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #444;
    }
    .actor-name {
        font-size: 1rem;
        margin-top: 10px;
    }
    /* ★★★ CSS 수정: .stats-bar 의 배경색을 rating-bar와 통일하고,
           .progress-bar의 배경색은 Bootstrap 기본값을 사용하도록 하여 충돌 해결 */
    .stats-bar, .rating-bar {
        background-color: #333; /* 모든 그래프의 배경은 어두운 회색 */
    }
    /* .progress-bar { background-color: #E50914; } 이 줄은 삭제하거나 주석처리 */

    /* 컨트롤러 및 헤더 관련 스타일 */
    .review-controls-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: flex-start; /* 상단 정렬 */
        margin-top: 15px;
        margin-bottom: 20px;
    }
    .review-controls {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .review-count {
        font-weight: bold;
        color: #aaa;
    }

    /* 대화창 스타일 */
    .chat-container {
        padding: 20px 100px;
    }
    .chat-message {
        display: flex;
        flex-direction: column;
        margin-bottom: 25px;
    }
    .bubble-rating {
        font-weight: bold;
        font-size: 1.1rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .bubble-plot {
        line-height: 1.6;
    }
    
     /* ★★★ 이 스타일을 삭제하세요 ★★★ */
    .content-line {
        display: flex;
        align-items: flex-end;
        gap: 8px;
        width: 100%;
    }	
    .chat-author {
        font-size: 0.9rem;
        font-weight: bold;
         margin-bottom: 8px; /* 이 값을 추가하거나 조절해보세요 */
    }
    .chat-date {
        font-size: 0.8rem;
        color: #8a95a3;
        flex-shrink: 0;
        transform: translateY(-2px);
    }
    .chat-bubble {
    /* ▼▼▼ 고정 크기 설정 ▼▼▼ */
    width: 600px;  /* 예시: 가로 너비를 600px로 고정 */
    height: 150px; /* 예시: 세로 높이를 150px로 고정 (아래 line-clamp와 연관됨) */
    overflow: hidden; /* 크기를 벗어나는 모든 내용은 숨김 */

    /* 기존 스타일은 유지 */
    padding: 15px 20px;
    border-radius: 20px;
    position: relative;
    }

   
    

    /* 다른 사람 리뷰 (왼쪽 정렬) */
    .message-left {
        align-items: flex-start; /* 왼쪽 정렬 */
    }
    .message-left .chat-author {
        align-self: flex-start;
    }
    .message-left .chat-bubble {
        background-color: #2c3440; /* 어두운 파란-회색 */
        border-top-left-radius: 5px;
    }
    /* 말꼬리 만들기 (왼쪽) */
    .message-left .chat-bubble::before {
        content: '';
        position: absolute;
        top: 10px;
        left: -8px;
        width: 0;
        height: 0;
        border-top: 10px solid transparent;
        border-bottom: 10px solid transparent;
        border-right: 10px solid #2c3440;
    }
    

    /* 내 리뷰 (오른쪽 정렬) */
    .message-right {
        align-items: flex-end; /* 오른쪽 정렬 */
    }
    .message-right .chat-author {
        align-self: flex-end;
    }
    .message-right .chat-bubble {
        background-color: #0d6efd; /* 파란색 */
        color: white;
        border-top-right-radius: 5px;
    }
    /* 말꼬리 만들기 (오른쪽) */
    .message-right .chat-bubble::before {
        content: '';
        position: absolute;
        top: 10px;
        right: -8px;
        width: 0;
        height: 0;
        border-top: 10px solid transparent;
        border-bottom: 10px solid transparent;
        border-left: 10px solid #0d6efd;
    }

    /* 버블 안의 컨텐츠 스타일 */
    .bubble-rating {
        font-weight: bold;
        font-size: 1.1rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .bubble-plot {
        line-height: 1.6;
	    color: #ced4da;
	
	    /* ▼▼▼ N줄 이상 넘어가면 ...으로 표시 ▼▼▼ */
	    overflow: hidden;
	    display: -webkit-box;
	    -webkit-box-orient: vertical;
	    -webkit-line-clamp: 4; /* ◀ 예시: 4줄로 제한 (위 height 값과 맞춰야 함) */
    }
    .message-right .bubble-plot {
        color: white; /* 내 리뷰 텍스트는 흰색 */
    }
    .star-rating {
        color: #f5c518;
    }
    
    /* 새로운 레이아웃을 위한 컨테이너 스타일 */
    .user-report-container {
        display: flex; /* 내부 요소들을 가로로 배치 */
        align-items: center; /* 세로 중앙 정렬 */
        gap: 40px; /* 좌우 섹션 사이의 간격 */
        margin-bottom: 3rem;
    }
    .average-score-section {
        flex-shrink: 0; /* 평균 평점 섹션이 줄어들지 않도록 함 */
    }
    .rating-graph-section {
        flex-grow: 1; /* 평점 그래프가 남은 공간을 모두 차지하도록 함 */
    }
    /* "5점", "4점" 등 라벨 스타일 */
    .rating-label {
        width: 45px;      /* 라벨의 너비 고정 */
        text-align: right; /* 오른쪽 정렬 */
        color: #aaa;
        font-size: 0.9rem;
        margin-right: 15px; /* 라벨과 막대그래프 사이 간격 */
    }
    

</style>
</head>
<body>
<jsp:include page="include/header.jsp" />
<div class="container">
    <div class="movie-header mb-4">
        <h1>${movie.mTitle}</h1>
        <p class="text-muted">${movie.mSubtitle}</p>
    </div>

    <div class="row">
        <div class="col-md-6">
            <c:choose>
                <c:when test="${not empty movie.mUrlImage}">
                    <img src="${pageContext.request.contextPath}/images/${movie.mUrlImage}" alt="${movie.mTitle} Poster" class="poster-img">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/movie_poster.jpg" alt="기본 포스터" class="poster-img">
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-md-6">
	    <div class="ratio ratio-16x9 h-100">
	        <%-- 항상 기본 예고편(movie.mp4)을 표시하도록 고정 --%>
	        <iframe src="${pageContext.request.contextPath}/videos/movie.mp4" title="기본 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	    </div>
		</div>
    </div>
    
    <hr class="my-5">

    <h2 class="section-title">주요 출연진</h2>
    <div class="row flex-nowrap overflow-x-auto pb-3">
        <c:forEach items="${movie.actors}" var="actor">
            <div class="col-auto actor-circle me-3">
                <c:choose>
                    <c:when test="${not empty actor.aUrlImage}">
                        <img src="${pageContext.request.contextPath}/images/${actor.aUrlImage}" alt="${actor.aName}" class="actor-img">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/actor01.jpg" alt="기본 배우 이미지" class="actor-img">
                    </c:otherwise>
                </c:choose>
                <p class="actor-name">${actor.aName}</p>
            </div>
        </c:forEach>
    </div>
    
    <hr class="my-5">

    <div class="row">

        <div class="col-md-6">
            <h2 class="section-title">작품 정보</h2>
            
            <p>${movie.mPlot}</p>

            <hr class="my-4">

            <div class="row">
                <div class="col-sm-6 mb-3">
                    <strong>감독</strong>
                    <p class="text-muted mb-0">${movie.mDirector}</p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>개봉일</strong>
                    <p class="text-muted mb-0">${movie.mRelease}</p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>장르</strong>
                    <p class="text-muted mb-0">${movie.mCategories}</p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>상영 시간</strong>
                    <p class="text-muted mb-0">${movie.mShowtime}분</p>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <h2 class="section-title">관람객 통계</h2>
            <div>
                <p>성별</p>
                <div class="progress rounded-pill" style="height: 25px; font-size: 0.9rem;">
                  <div class="progress-bar bg-info" role="progressbar" style="width: 45.8%;" aria-valuenow="45.8" aria-valuemin="0" aria-valuemax="100">남성 45.8%</div>
                  <div class="progress-bar bg-danger" role="progressbar" style="width: 54.2%;" aria-valuenow="54.2" aria-valuemin="0" aria-valuemax="100">여성 54.2%</div>
                </div>
                <p class="mt-4">연령</p>
                <div class="progress stats-bar mb-2 rounded-pill" style="height: 18px;"><div class="progress-bar bg-danger" role="progressbar" style="width: 10%;">10대</div></div>
                <div class="progress stats-bar mb-2 rounded-pill" style="height: 18px;"><div class="progress-bar bg-danger" role="progressbar" style="width: 45%;">20대</div></div>
                <div class="progress stats-bar mb-2 rounded-pill" style="height: 18px;"><div class="progress-bar bg-danger" role="progressbar" style="width: 30%;">30대</div></div>
            </div>
        </div>

    </div>

       <hr class="my-5"> 

    <h2 class="section-title">유저 리뷰 리포트</h2>

    <div class="user-report-container">
        
        <div class="average-score-section">
            <div class="d-flex align-items-center">
                <span style="font-size: 3.5rem;">🍿</span>
                <span class="fs-1 fw-bold ps-3">평균: <fmt:formatNumber value="${movie.mAverageScore}" maxFractionDigits="1"/>점</span>
            </div>
        </div>

        <div class="rating-graph-section">
            <div class="rating-distribution">
                <div class="d-flex align-items-center mb-2">
                    <span class="rating-label">5점</span>
                    <div class="progress rating-bar w-100" style="height:12px;">
                        <div class="progress-bar bg-danger" style="width: 70%;">70%</div>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-2">
                    <span class="rating-label">4점</span>
                    <div class="progress rating-bar w-100" style="height:12px;">
                        <div class="progress-bar bg-danger" style="width: 15%;">15%</div>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-2">
                    <span class="rating-label">3점</span>
                    <div class="progress rating-bar w-100" style="height:12px;">
                        <div class="progress-bar bg-danger" style="width: 8%;">8%</div>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-2">
                    <span class="rating-label">2점</span>
                    <div class="progress rating-bar w-100" style="height:12px;">
                        <div class="progress-bar bg-danger" style="width: 4%;">4%</div>
                    </div>
                </div>
                <div class="d-flex align-items-center mb-2">
                    <span class="rating-label">1점</span>
                    <div class="progress rating-bar w-100" style="height:12px;">
                        <div class="progress-bar bg-danger" style="width: 3%;">3%</div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="review-summary">
        <h4 class="fw-bold">&lt;리뷰 요약&gt;</h4>
        <p class="text-muted mt-3">
            이 영화는 강렬한 액션, 성숙한 주제, 그리고 복잡한 도덕적 딜레마를 다루고 있어 시청자들에게 깊은 인상을 남깁니다. 
            정의와 복수, 그리고 트라우마라는 어두운 주제를 탐구하며 캐릭터의 다층적인 면모를 보여줍니다. 
            일부 시청자들은 영화의 전개가 다소 길고 지루하게 느껴질 수 있다고 평가했지만, 
            결함이 있는 인간적인 영웅의 모습은 기존의 히어로물과는 다른 신선한 관점을 제공한다는 긍정적인 평가가 많습니다.
        </p>
    </div>


    <hr class="mt-5 mb-4">

    <h2 class="section-title">네티즌 평점 및 리뷰</h2>

    <div class="review-controls-wrapper">
        <div class="review-count">
            총 리뷰 수 : ${reviews.size()}개
        </div>

        <div class="text-end">
            <%-- ★★★ "리뷰 추가" 버튼 위치 변경 ★★★ --%>
            <div class="mb-2">
                <a href="#" class="btn btn-danger btn-sm">+ 리뷰 추가</a>
            </div>
            <div class="review-controls">
                <div class="dropdown">
                    <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">RATING</button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">🍿 5점</a></li>
                        <li><a class="dropdown-item" href="#">🍿 4점</a></li>
                        <li><a class="dropdown-item" href="#">🍿 3점</a></li>
                        <li><a class="dropdown-item" href="#">🍿 2점</a></li>
                        <li><a class="dropdown-item" href="#">🍿 1점</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">SORT</button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">최신순</a></li>
                        <li><a class="dropdown-item" href="#">별점 높은 순</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <div class="chat-container">
    <c:choose>
        <c:when test="${not empty reviews}">
            <c:forEach items="${reviews}" var="review">
                <c:choose>
                    <%-- 내 리뷰 (오른쪽) --%>
                    <c:when test="${review.user.id == sessionScope.user.id}">
                        <div class="chat-message message-right">
                            <%-- ★★★ 구조 변경: 작성자를 위로 빼냅니다 ★★★ --%>
                            <span class="chat-author">${review.user.id}</span>
                            
                            <%-- ★★★ 구조 변경: 말풍선과 날짜를 content-line으로 묶습니다 ★★★ --%>
                            <div class="content-line">
                                <span class="chat-date">${review.rDate}</span>
                                <div class="chat-bubble">
                                    <div class="bubble-rating"><span>🍿</span> ${review.rRating}점</div>
                                    <p class="bubble-plot">${review.rPlot}</p>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <%-- 다른 사람 리뷰 (왼쪽) --%>
                    <c:otherwise>
                        <div class="chat-message message-left">
                            <%-- ★★★ 구조 변경: 작성자를 위로 빼냅니다 ★★★ --%>
                            <span class="chat-author">${review.user.id}</span>
                            
                            <%-- ★★★ 구조 변경: 말풍선과 날짜를 content-line으로 묶습니다 ★★★ --%>
                            <div class="content-line">
                                <div class="chat-bubble">
                                    <div class="bubble-rating"><span>🍿</span> ${review.rRating}점</div>
                                    <p class="bubble-plot">${review.rPlot}</p>
                                </div>
                                <span class="chat-date">${review.rDate}</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="text-center p-5">
                <p>작성된 리뷰가 없습니다. 첫 번째 리뷰를 작성해보세요!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<div class="modal fade" id="trailerModal" tabindex="-1" aria-labelledby="trailerModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content bg-dark">
      <div class="modal-header">
        <h5 class="modal-title" id="trailerModalLabel">${movie.mTitle} 예고편</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="ratio ratio-16x9">

          <%-- 이 부분이 수정되었습니다. --%>
          <c:choose>
              <%-- movie.mUrlMovie에 파일 이름이 있을 경우 --%>
              <c:when test="${not empty movie.mUrlMovie}">
                <iframe src="${pageContext.request.contextPath}/videos/${movie.mUrlMovie}" title="영화 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
              </c:when>
              <%-- movie.mUrlMovie가 비어있을 경우 --%>
              <c:otherwise>
                <iframe src="${pageContext.request.contextPath}/videos/movie.mp4" title="기본 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
              </c:otherwise>
          </c:choose>

        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
</script>

</body>
</html>