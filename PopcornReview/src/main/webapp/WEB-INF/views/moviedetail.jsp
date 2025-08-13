<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- 현재 날짜를 Date 객체로 준비 --%>
<c:set var="now" value="<%=new java.util.Date()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${movie.mTitle} - 영화 상세 정보</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> 
<style>
    body {
        background-color: #121212;
        color: var(--primary-30);
        font-family: 'Noto Sans KR', sans-serif;
    }
    .container {
        margin-top: 40px;
        margin-bottom: 100px; /* 맨 아래 리뷰와 푸터 사이 여백 추가 */
    }
    .text-mute{
    		color: #A6CBFF;
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
    background-color: #333 !important; /* 모든 그래프의 배경은 어두운 회색 */
}
    /* .progress-bar { background-color: #E50914; } 이 줄은 삭제하거나 주석처리 */
	
	/* ▼▼▼ [추가] 리뷰 없음 안내 문구 스타일 ▼▼▼ */
    .placeholder-text {
        color: #e0e0e0;
        text-align: center;
        padding: 3rem;
        border-radius: 8px;
        margin-top: 10px;
        
        /* ▼▼▼ [수정] 텍스트 위치를 아래로 내리기 위해 padding 값 조정 ▼▼▼ */
    padding-top: 80px;    /* 위쪽 여백을 늘려 텍스트를 아래로 내립니다. */
    padding-bottom: 80px; /* 전체적인 상자의 높이를 유지하기 위해 아래쪽 여백도 설정합니다. */
    }3
    .placeholder-text p {
        margin-bottom: 0;
    }
	
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
         margin-left: -20px; /* 아이콘과 평점을 왼쪽으로 당깁니다. */
        /*  gap: 5px; */
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
    padding-bottom: 40px; /* 이 줄을 추가하세요 */
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
    

	/* 내가 쓴 리뷰의 말풍선과 날짜를 오른쪽으로 보내기 위한 스타일 추가 */
	.message-right .content-line {
	    justify-content: flex-end;
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
        /* gap: 5px; */
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
    
/* ================================================ */
/* 👇 리뷰 모달 관련 CSS (전체 교체) 👇         */
/* ================================================ */

/* 리뷰 모달창 관련 스타일 */
#reviewModal .modal-review {
    background-color: #1B232F;
    color: #e0e0e0;
    border: 1px solid #444;
} {
    background-color: #1B232F; /* 요청하신 배경색 */
    color: #e0e0e0;
    border: 1px solid #444;
}
.modal-review .modal-header,
.modal-review .modal-footer {
    border-color: #444; /* 헤더와 푸터의 구분선 색상 */
}
.modal-review .modal-body {
    display: flex;
    flex-direction: column;
}

/* 모달 푸터(버튼) 정렬 */
.modal-review .modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}

/* 영화 정보 (포스터 + 제목) */
.modal-movie-info {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 25px;
}
.modal-poster-img {
    width: 80px;
    border-radius: 5px;
}
.modal-movie-details h4 {
    font-weight: 700;
    margin-bottom: 5px;
}
.modal-movie-details p,
.modal-movie-details span {
    font-size: 0.9rem;
    color: #aaa;
    margin: 0;
}

/* 👇 [최종 교체] 기존의 rating-section 관련 모든 CSS를 이 코드로 대체해주세요. */

/* 별점 시스템 전체 컨테이너 */
#reviewModal .rating-section {
    display: flex;
    align-items: center;
    width: 100%;
    margin-bottom: 20px;
}

/* 'Your Rating' 텍스트 */
#reviewModal .rating-section > span:first-child {
    font-weight: 700;
    color: #aaa;
    margin-right: 15px;
}

/* 팝콘 아이콘 그룹 */
#reviewModal .popcorn-rating {
    display: flex;
    align-items: center;
}

/* 팝콘 아이콘 크기 및 간격 */
#reviewModal .popcorn-rating img {
    height: 50px;        /* ★★★ 팝콘 아이콘 크기를 50px로 키움 ★★★ */
    width: auto;
    margin-right: 10px;  /* ★★★ 아이콘 사이 간격을 10px로 조정 ★★★ */
    transition: transform 0.1s ease;
}
#reviewModal .popcorn-rating img:hover {
    transform: scale(1.1);
}
#reviewModal .popcorn-rating img:last-child {
    margin-right: 0;
}

/* '0/5' 점수 텍스트 */
#reviewModal #scoreDisplay {
    margin-left: auto;
    font-size: 1.8rem; /* ★★★ 점수 텍스트 크기도 키움 ★★★ */
    font-weight: 700;
    color: #f5c518;
}

/* 리뷰 텍스트 입력창 */
.review-textarea {
    width: 100%;
    background-color: #252F48; /* 요청하신 입력칸 배경색 */
    border: 1px solid #444;
    border-radius: 5px;
    padding: 10px;
    color: #e0e0e0;
}
.review-textarea::placeholder {
    color: #8a95a3;
}
.review-textarea:focus {
    background-color: #252F48;
    color: #e0e0e0;
    outline: none;
    box-shadow: 0 0 0 2px rgba(245, 197, 24, 0.5); /* 포커스 시 테두리 효과 */
}

/* 등록 버튼 */
#reviewModal .btn-submit-review {
    background-color: #f5c518;
    color: #121212;
    font-weight: 700;
    border: none;
}
#reviewModal .btn-submit-review:hover {
    background-color: #e0b400;
    color: #121212;
}
	
.popcorn-icon {
    height: 1.6rem; /* 팝콘 크기를 키웠습니다. */
    width: auto;
    vertical-align: middle; /* 텍스트와 세로 중앙 정렬 */
    /* margin-right: -7px; */ /* 텍스트와의 간격을 줄였습니다. */
}  

.review-link-wrapper, .review-link-wrapper:hover {
    color: inherit; /* 부모 요소의 글자색을 그대로 사용 */
    text-decoration: none; /* 밑줄 제거 */
    display: block; /* 링크가 div 전체를 감쌀 수 있도록 블록 요소로 만듦 */
}

/* ▼▼▼ [추가] 수정/삭제/신고 버튼 관련 스타일 ▼▼▼ */
.review-actions {
    position: absolute;
    bottom: 10px;
    right: 20px;
    display: flex;
    gap: 15px;
}
.btn-text-link {
    background: none;
    border: none;
    padding: 0;
    font-size: 0.85rem;
    cursor: pointer;
    text-decoration: none;
}
/* ▼▼▼ "나"를 오른쪽으로 보내기 위해 이 부분을 추가하세요 ▼▼▼ */
.message-right {
    align-items: flex-end;
}
.message-right .btn-text-link { /* 내 리뷰 (파란 말풍선) 안의 링크 */
    color: rgba(255, 255, 255, 0.7);
}
.message-right .btn-text-link:hover {
    color: rgba(255, 255, 255, 1);
}
.message-left .btn-text-link { /* 남의 리뷰 (회색 말풍선) 안의 링크 */
    color: #8a95a3;
}
.message-left .btn-text-link:hover {
    color: #ced4da;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div class="container">
    <div class="movie-header mb-4">
        <h1>${movie.mTitle}</h1>
        <p class="text-mute">${movie.mSubtitle}</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <c:choose>
                <c:when test="${not empty movie.mUrlImage}">
                    <img src="${movie.mUrlImage}" alt="${movie.mTitle} Poster" class="poster-img">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/movie_poster.jpg" alt="기본 포스터" class="poster-img">
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-md-8">
	        <%-- 1. "youtu.be/" 뒤의 영상 ID 추출 --%>
				<%-- 예: https://youtu.be/nJmXYoKC5C0 -> nJmXYoKC5C0 추출 --%>
				<c:set var="videoId" value="${fn:substringAfter(movie.mUrlMovie, 'youtu.be/')}" />
				
				<%-- 2. 추출한 ID로 최종 embed URL 생성 + 파라미터 추가 --%>
				<c:set var="finalUrl" value="https://www.youtube.com/embed/${videoId}" />
				
				
				<%-- 3. 완성된 URL을 iframe의 src로 사용 --%>
				<div class="ratio ratio-16x9 h-100">
				    <iframe src="${finalUrl}" title="기본 예고편" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				</div>
      </div>
    </div>
    
    <hr class="my-5">

    <h2 class="section-title">주요 출연진</h2>
    <div class="row flex-nowrap overflow-x-auto pb-3">
        <c:forEach items="${movie.actors}" var="actor">
            <div class="col-auto actor-circle me-3">
				<a href="/movie/actordetail?aId=${actor.aId}">            
	                <c:choose>
	                    <c:when test="${not empty actor.aUrlImage}">
	                        <img src="${actor.aUrlImage}" alt="${actor.aName}" class="actor-img">
	                    </c:when>
	                    <c:otherwise>
	                        <img src="${pageContext.request.contextPath}/images/actor01.jpg" alt="기본 배우 이미지" class="actor-img">
	                    </c:otherwise>
	                </c:choose>
	            </a>
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
                    <p class="text-mute mb-0">${movie.mDirector}</p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>개봉일</strong>
                    <p class="text-mute mb-0"><fmt:formatDate value="${movie.mRelease}" pattern="yyyy-MM-dd" /></p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>장르</strong>
                    <p class="text-mute mb-0">${movie.mCategory}</p>
                </div>
                <div class="col-sm-6 mb-3">
                    <strong>상영 시간</strong>
                    <p class="text-mute mb-0">${movie.mShowtime}</p>
                </div>
            </div>
        </div>
        
        
<%-- ▼▼▼ [수정] .time 속성을 사용하여 숫자(밀리초)로 비교합니다 ▼▼▼ --%>
<c:if test="${movie.mRelease.time <= now.time}">
        <%-- ========================================================= --%>
    <%-- ▼▼▼ [수정 시작] 관람객 통계 ▼▼▼                         --%>
    <%-- ========================================================= --%>
     <div class="col-md-6">
        <h2 class="section-title">관람객 통계</h2>
        
        <c:choose>
            <c:when test="${not empty reviews}">
                <div>
                    <c:if test="${not empty audienceStats.genderDistribution and (audienceStats.genderDistribution['남성'] > 0 or audienceStats.genderDistribution['여성'] > 0)}">
                        <p>성별</p>
                        <div class="progress rounded-pill" style="height: 25px; font-size: 0.9rem;">
                            <div class="progress-bar bg-info" role="progressbar" style="width: ${audienceStats.genderDistribution['남성']}%;" aria-valuenow="${audienceStats.genderDistribution['남성']}">
                                남성 <fmt:formatNumber value="${audienceStats.genderDistribution['남성']}" maxFractionDigits="1"/>%
                            </div>
                            <div class="progress-bar bg-danger" role="progressbar" style="width: ${audienceStats.genderDistribution['여성']}%;" aria-valuenow="${audienceStats.genderDistribution['여성']}">
                                여성 <fmt:formatNumber value="${audienceStats.genderDistribution['여성']}" maxFractionDigits="1"/>%
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty audienceStats.ageDistribution}">
                        <p class="mt-4">연령</p>
                        <c:forEach items="${audienceStats.ageDistribution}" var="ageStat">
                            <div class="progress stats-bar mb-2 rounded-pill" style="height: 18px;">
                                <div class="progress-bar bg-danger" role="progressbar" style="width: ${ageStat.value}%;">${ageStat.key}</div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="placeholder-text">
		                    <p>첫 번째 리뷰를 작성하고 관람객 통계를 확인해보세요!</p>
		        </div>
            </c:otherwise>
        </c:choose>
    </div>
    

    </div>

       <hr class="my-5"> 

    <%-- ========================================================= --%>
    <%-- ▼▼▼ [수정] 유저 리뷰 리포트 및 요약 ▼▼▼          --%>
    <%-- ========================================================= --%>
    <c:choose>
        <c:when test="${not empty reviews}">
            <h2 class="section-title">유저 리뷰 리포트</h2>
            <div class="user-report-container">
                <div class="average-score-section">
                    <div class="d-flex align-items-center">
                         <img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn Icon" style="height: 3.5rem; width: auto;">
                        <span class="fs-1 fw-bold ms-n2">평균: ${reviewStats.averageScore}점</span>
                    </div>
                </div>
        
                <div class="rating-graph-section">
                    <div class="rating-distribution">
                        <c:forEach items="${reviewStats.scoreDistribution}" var="dist">
                            <div class="d-flex align-items-center mb-2">
                                <span class="rating-label">${dist.key}점</span>
                                <div class="progress rating-bar w-100" style="height:12px;">
                                     <div class="progress-bar bg-danger" style="width: ${dist.value}%;">
                                        <fmt:formatNumber value="${dist.value}" maxFractionDigits="0"/>%
                                    </div>
                                 </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        
            <div class="review-summary">
                <h4 class="fw-bold">&lt;리뷰 요약&gt;</h4>
                <p class="text-mute mt-3">${summary}</p>
            </div>
        </c:when>
        <c:otherwise>
            <h2 class="section-title">유저 리뷰 리포트</h2>
             <div class="placeholder-text">
                <p>이 영화의 평균 평점이 궁금하신가요? 첫 리뷰의 주인공이 되어보세요.</p>
            </div>
        </c:otherwise>
    </c:choose>



    <hr class="mt-5 mb-4">

    <h2 class="section-title">네티즌 평점 및 리뷰</h2>

    <div class="review-controls-wrapper">
        <div class="review-count">
            총 리뷰 수 : ${reviews.size()}개
        </div>

        <div class="text-end">
            <%-- ★★★ "리뷰 추가" 버튼 위치 변경 ★★★ --%>
            <div class="mb-2">
                <a href="#" class="btn btn-danger btn-sm" id="addReviewBtn">+ 리뷰 추가</a>
            </div>
            
            
            
            <div class="review-controls">
			    <div class="dropdown">
			        <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">RATING</button>
			        <ul class="dropdown-menu" id="review-rating-options">
					    <li><a class="dropdown-item" href="#" data-rating="0">All Ratings</a></li>
					    <li><a class="dropdown-item d-flex align-items-center" href="#" data-rating="5"><img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> 5점</a></li>
					    <li><a class="dropdown-item d-flex align-items-center" href="#" data-rating="4"><img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> 4점</a></li>
					    <li><a class="dropdown-item d-flex align-items-center" href="#" data-rating="3"><img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> 3점</a></li>
					    <li><a class="dropdown-item d-flex align-items-center" href="#" data-rating="2"><img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> 2점</a></li>
					    <li><a class="dropdown-item d-flex align-items-center" href="#" data-rating="1"><img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> 1점</a></li>
					</ul>
			    </div>
			    <div class="dropdown">
			        <button class="btn btn-dark btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">SORT</button>
			        <ul class="dropdown-menu" id="review-sort-options"> <li><a class="dropdown-item" href="#" data-sort="latest">최신순</a></li>
			            <li><a class="dropdown-item" href="#" data-sort="rating">별점 높은 순</a></li>
			        </ul>
			    </div>
			</div>
        </div>
    </div>


<div class="chat-container" id="review-container">
	<%-- ▼▼▼ 이 부분을 추가하세요 ▼▼▼ --%>
    <div id="no-filter-results" class="text-center p-5 text-muted" style="display: none;">
        <p>해당 조건에 맞는 리뷰가 없습니다.</p>
    </div>

    <%-- ▼▼▼ 기존 코드는 그대로 둡니다 ▼▼▼ --%>
    <c:choose>
        <c:when test="${not empty reviews}">
            <c:forEach items="${reviews}" var="review">
            	<a href="/review/${review.rId}" class="review-link-wrapper">
                <c:choose>
                    <%-- 내 리뷰 (오른쪽) --%>
                    <c:when test="${review.user.id == sessionScope.loginUser.id}">
                        <div class="chat-message message-right">
                            <%-- ★★★ 구조 변경: 작성자를 위로 빼냅니다 ★★★ --%>
                            <span class="chat-author">나</span>
                            
                            <%-- ★★★ 구조 변경: 말풍선과 날짜를 content-line으로 묶습니다 ★★★ --%>
                            <div class="content-line">
                                <%-- [수정 후] --%>
					<%-- 이전에 수정했던 두 곳의 날짜 부분을 모두 아래와 같이 원래 코드로 복원합니다. --%>
								<span class="chat-date" data-date="<fmt:formatDate value='${review.rDate}' pattern='yyyy-MM-dd HH:mm:ss'/>">
								    <fmt:formatDate value="${review.rDate}" pattern="yyyy-MM-dd"/>
								</span>
                                <div class="chat-bubble">
                                    <div class="bubble-rating">
									    <img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> ${review.rRating}점
									</div>
									<p class="bubble-plot">${review.rPlot}</p>
									<div class="review-actions">
									    <a href="#" class="btn-text-link btn-edit-review">수정</a>
									    <a href="#" class="btn-text-link btn-delete-review">삭제</a>
									</div>
                                </div>
                            </div>
                        </div>
                        
                    </c:when>

                    <%-- 다른 사람 리뷰 (왼쪽) --%>
                    <c:otherwise>
	                        <div class="chat-message message-left">
	                            <%-- ★★★ 구조 변경: 작성자를 위로 빼냅니다 ★★★ --%>
	                            <span class="chat-author">${review.user.name}</span>
	                            
	                            <%-- ★★★ 구조 변경: 말풍선과 날짜를 content-line으로 묶습니다 ★★★ --%>
	                            <div class="content-line">
	                                <div class="chat-bubble">
	                                    <div class="bubble-rating">
										    <img src="${pageContext.request.contextPath}/image/popcorn.png" alt="Popcorn" class="popcorn-icon"> ${review.rRating}점
										</div>
	                                    <p class="bubble-plot">${review.rPlot}</p>
	                                    <div class="review-actions">
										    <a href="#" class="btn-text-link btn-report-review">신고하기</a>
										</div>
	                                </div>
	                                <span class="chat-date" data-date="<fmt:formatDate value='${review.rDate}' pattern='yyyy-MM-dd HH:mm:ss'/>">
									    <fmt:formatDate value="${review.rDate}" pattern="yyyy-MM-dd"/>
									</span>
	                            </div>
	                        </div>
                    </c:otherwise>
                </c:choose>
                </a>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="text-center p-5">
                <p>작성된 리뷰가 없습니다. 첫 번째 리뷰를 작성해보세요!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</c:if>
</div>
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content modal-review">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">User Review</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="modal-movie-info">
                    <img src="${movie.mUrlImage}" alt="${movie.mTitle}" class="modal-poster-img">
                    <div class="modal-movie-details">
                        <h4>${movie.mTitle}</h4>
                        <p>${movie.mSubtitle}</p>
                        <span>${movie.mCategory}</span>
                    </div>
                </div>

                <form id="reviewForm" action="/review/add" method="post">
                    <input type="hidden" name="movie.mId" value="${movie.mId}">
                    <input type="hidden" name="rRating" id="ratingValue" value="0">
                    
                    <div class="rating-section">
                        <span>Your Rating</span>
                        <div class="popcorn-rating">
						    <img src="${pageContext.request.contextPath}/image/nopopcorn.png" alt="1점" data-value="1">
					        <img src="${pageContext.request.contextPath}/image/nopopcorn.png" alt="2점" data-value="2">
					        <img src="${pageContext.request.contextPath}/image/nopopcorn.png" alt="3점" data-value="3">
					        <img src="${pageContext.request.contextPath}/image/nopopcorn.png" alt="4점" data-value="4">
					        <img src="${pageContext.request.contextPath}/image/nopopcorn.png" alt="5점" data-value="5">
						</div>
                        <span id="scoreDisplay">0/5</span>
                    </div>

                    <textarea name="rPlot" class="review-textarea" rows="5" placeholder="이 영화에 대한 감상을 남겨주세요..."></textarea>
                </form>
            </div>
            <div class="modal-footer">
	            <button type="submit" form="reviewForm" class="btn btn-submit-review">등록</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>            
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<script>
$(document).ready(function() {
    // 1. 페이지 로드 시 스크롤 위치 복원
    const scrollPosition = sessionStorage.getItem('scrollPosition');
    if (scrollPosition) {
        window.scrollTo(0, parseInt(scrollPosition));
        sessionStorage.removeItem('scrollPosition');
    }

    // 2. 리뷰 필터링 (RATING)
    $('#review-rating-options').on('click', 'a', function(e) {
        e.preventDefault();
        
        
        // 1. 안내 메시지를 일단 숨깁니다.
        $('#no-filter-results').hide();
        
        
        const selectedRating = parseInt($(this).data('rating'));

        if (selectedRating === 0) {
            $('#review-container .chat-message').show();
        } else {
            // .hide()와 .each()를 연결(chaining)하여 코드를 간결하게 만듭니다.
            $('#review-container .chat-message').hide().each(function() {
                const reviewRatingText = $(this).find('.bubble-rating').text();
                const match = reviewRatingText.match(/(\d+)점/);
                if (match && parseInt(match[1]) === selectedRating) {
                    $(this).show();
                }
            });
            
         // 3. 필터링 후, 화면에 보이는 리뷰가 0개인지 확인합니다.
            const visibleReviews = $('#review-container .chat-message:visible').length;
            if (visibleReviews === 0) {
                // 4. 보이는 리뷰가 없으면 안내 메시지를 보여줍니다.
                $('#no-filter-results').show();
            }
        }
    });

    // 3. 리뷰 정렬 (SORT)
    $('#review-sort-options').on('click', 'a', function(e) {
        e.preventDefault();

        
        const sortBy = $(this).data('sort');
        let reviews = $('#review-container .chat-message').get();

        reviews.sort(function(a, b) {
            if (sortBy === 'rating') {
                const textA = $(a).find('.bubble-rating').text();
                const matchA = textA.match(/(\d+)점/);
                const ratingA = matchA ? parseInt(matchA[1]) : 0;

                const textB = $(b).find('.bubble-rating').text();
                const matchB = textB.match(/(\d+)점/);
                const ratingB = matchB ? parseInt(matchB[1]) : 0;
                
                return ratingB - ratingA;
            } else { // 'latest'
                const dateA = new Date($(a).find('.chat-date').data('date'));
                const dateB = new Date($(b).find('.chat-date').data('date'));
                return dateB - dateA;
            }
        });
        $('#review-container').append(reviews);
    });

    // 4. 리뷰 추가 버튼 (+ 리뷰 추가)
    const loginUser = '${sessionScope.loginUser}';
    $('#addReviewBtn').on('click', function(e) {
        e.preventDefault();
        if (loginUser) {
            $('#reviewModal').modal('show');
        } else {
            alert('로그인이 필요한 서비스입니다.');
            // 헤더의 로그인 버튼이 .btn-login 클래스를 가지고 있다고 가정
            $('.btn-login').trigger('click');
        }
    });

    // 5. 리뷰 작성 모달 내부 기능 (jQuery 스타일로 통일)
    const nopopcornPath = "${pageContext.request.contextPath}/image/nopopcorn.png";
    const popcornPath = "${pageContext.request.contextPath}/image/popcorn.png";
    let currentRating = 0;

    const updatePopcorns = (rating) => {
        $('.popcorn-rating img').each(function() {
            const popcornValue = $(this).data('value');
            $(this).attr('src', popcornValue <= rating ? popcornPath : nopopcornPath);
        });
    };

    // 팝콘 아이콘 이벤트 핸들러
    $('.popcorn-rating img').on({
        'mouseover': function() { updatePopcorns($(this).data('value')); },
        'mouseout': function() { updatePopcorns(currentRating); },
        'click': function() {
            currentRating = $(this).data('value');
            $('#ratingValue').val(currentRating);
            $('#scoreDisplay').text(currentRating + '/5');
            updatePopcorns(currentRating);
        }
    });

    // 리뷰 폼 제출 이벤트
    $('#reviewForm').on('submit', function(e) {
        if ($('#ratingValue').val() === '0') {
            alert('평점을 선택해주세요.');
            e.preventDefault();
            return;
        }
        if ($('textarea[name="rPlot"]', this).val().trim() === '') {
            alert('리뷰 내용을 입력해주세요.');
            e.preventDefault();
            return;
        }
        sessionStorage.setItem('scrollPosition', window.scrollY);
        alert('리뷰가 등록되었습니다.');
    });

    // 모달이 닫힐 때 폼 초기화
    $('#reviewModal').on('hidden.bs.modal', function () {
        $('#reviewForm')[0].reset(); // jQuery 객체에서 DOM 요소의 reset() 메소드를 호출
        currentRating = 0;
        $('#ratingValue').val('0');
        $('#scoreDisplay').text('0/5');
        updatePopcorns(0);
    });
});
</script>

</body>
</html>