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

    /* 기존 .review-card, .review-rating 등 관련 스타일은 이 코드로 교체합니다. */
     /* 기존 .review-section-header 관련 스타일은 삭제하거나 이 코드로 덮어쓰세요. */
    .review-section-header {
        margin-bottom: 25px;
    }
    .review-header-top, .review-header-controls {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .review-header-controls {
        justify-content: flex-end; /* 컨트롤 버튼들을 오른쪽으로 정렬 */
        gap: 10px; /* 버튼 사이 간격 */
        margin-top: 10px;
    }
    .header-tag {
        background-color: #2c3440;
        color: #e0e0e0;
        padding: 6px 15px;
        border-radius: 20px; /* 타원형 모양 */
        font-size: 0.9rem;
        font-weight: bold;
    }
    .btn-add-review {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    /* 드롭다운 메뉴 스타일 */
    .dropdown-menu {
        background-color: #343a40; /* 어두운 배경 */
    }
    .dropdown-menu a.dropdown-item {
        color: #e0e0e0; /* 밝은 글자색 */
    }
    .dropdown-menu a.dropdown-item:hover {
        background-color: #495057; /* 호버 시 배경색 */
    }
    .review-controls {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .review-card {
        background-color: #2c3440; /* 프로토타입의 어두운 파란-회색 배경 */
        border-radius: 12px; /* 좀 더 둥근 모서리 */
        padding: 25px;
        margin-bottom: 20px;
    }
    .review-score { /* 별점 스타일 */
        font-weight: bold;
        font-size: 1.1rem;
        margin-bottom: 15px;
    }
    .review-card-footer {
        border-top: 1px solid #4a5462; /* 푸터를 구분하는 선 */
        padding-top: 15px;         /* 구분선과 작성자 정보 사이의 여백 */
        margin-top: 20px;          /* 리뷰 내용과 구분선 사이의 여백 */
    }
    .star-rating { /* 별 아이콘 색상 */
        color: #f5c518;
    }
    .review-plot {
        color: #ced4da;
        line-height: 1.7;
        margin-bottom: 25px;
    }
    .review-meta { /* 작성자 정보 스타일 */
        display: flex;
        gap: 15px;
        font-size: 0.9rem;
        color: #8a95a3;
        font-weight: bold;
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
<jsp:include page="/include/header.jsp" />
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
                <c:choose>
                    <c:when test="${not empty movie.mUrlMovie}">
                      <iframe src="${pageContext.request.contextPath}/videos/${movie.mUrlMovie}" title="영화 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </c:when>
                    <c:otherwise>
                      <iframe src="${pageContext.request.contextPath}/videos/movie.mp4" title="기본 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </c:otherwise>
                </c:choose>
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
            <h2 class="section-title">줄거리</h2>
            <p>${movie.mPlot}</p>
            <p><strong>감독:</strong> ${movie.mDirector}</p>
            <p><strong>개봉일:</strong> ${movie.mRelease}</p>
            <p><strong>상영 시간:</strong> ${movie.mShowtime}분</p>
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

    <div class="review-section-header">
        <div class="review-header-top">
            <div class="header-tag">
                총 리뷰 수 : ${reviews.size()}개
            </div>
            <a href="#" class="btn btn-dark rounded-pill btn-add-review">
                <span style="font-size: 1.2rem;">+</span> 리뷰 추가
            </a>
        </div>
        
        <div class="review-header-controls">
            <div class="dropdown">
                <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    RATING
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">🍿 5점</a></li>
                    <li><a class="dropdown-item" href="#">🍿 4점</a></li>
                    <li><a class="dropdown-item" href="#">🍿 3점</a></li>
                    <li><a class="dropdown-item" href="#">🍿 2점</a></li>
                    <li><a class="dropdown-item" href="#">🍿 1점</a></li>
                </ul>
            </div>
            <div class="dropdown">
                <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    SORT
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">최신순</a></li>
                    <li><a class="dropdown-item" href="#">별점 높은 순</a></li>
                </ul>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty reviews}">
            <c:forEach items="${reviews}" var="review">
                <div class="review-card">
                    
                    <div class="review-card-body">
                        <div class="review-score">
                            <span class="star-rating" style="font-size: 1.5rem;">🍿</span> ${review.rRating}점
                        </div>
                        <p class="review-plot">${review.rPlot}</p>
                    </div>

                    <div class="review-card-footer">
                        <div class="review-meta">
                            <span class="review-author">${review.user.id}</span>
                            <span class="review-date">${review.rDate}</span>
                        </div>
                    </div>

                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="review-card text-center">
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
</body>
</html>