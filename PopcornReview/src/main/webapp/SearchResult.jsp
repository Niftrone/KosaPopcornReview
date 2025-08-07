<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.service.popcornreview.vo.Movie" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 실제로는 Controller에서 DB를 통해 Movie 리스트를 조회합니다.
    List<Movie> results = new ArrayList<>();

    // --- [수정됨] ---
    // 예시 데이터에 mRelease와 mDirector 값을 추가했습니다.
    Movie movie1 = new Movie();
    movie1.setmTitle("슈퍼 블레이드");
    movie1.setmUrlImage("/images/poster01.jpg");
    movie1.setmRelease("2023");
    movie1.setmDirector("김감독");
    results.add(movie1);

    Movie movie2 = new Movie();
    movie2.setmTitle("피터 그릴과 현자의 시간");
    movie2.setmUrlImage("/images/poster02.jpg");
    movie2.setmRelease("2020");
    movie2.setmDirector("이감독");
    results.add(movie2);

    Movie movie3 = new Movie();
    movie3.setmTitle("Free!");
    movie3.setmUrlImage("/images/poster03.jpg");
    movie3.setmRelease("2013");
    movie3.setmDirector("박감독");
    results.add(movie3);

    Movie movie4 = new Movie();
    movie4.setmTitle("스윗 프랑세즈");
    movie4.setmUrlImage("/images/poster01.jpg");
    movie4.setmRelease("2015");
    movie4.setmDirector("최감독");
    results.add(movie4);

    Movie movie5 = new Movie();
    movie5.setmTitle("샤크 피버");
    movie5.setmUrlImage("/images/poster03.jpg");
    movie5.setmRelease("2024");
    movie5.setmDirector("정감독");
    results.add(movie5);

    Movie movie6 = new Movie();
    movie6.setmTitle("수라");
    movie6.setmUrlImage("/images/poster02.jpg");
    movie6.setmRelease("2022");
    movie6.setmDirector("황감독");
    results.add(movie6);

    Movie movie7 = new Movie();
    movie7.setmTitle("써든리: 피묻은 습격");
    movie7.setmUrlImage("/images/poster01.jpg");
    movie7.setmRelease("2021");
    movie7.setmDirector("윤감독");
    results.add(movie7);


    Movie movie8 = new Movie();
    movie8.setmTitle("슈퍼 베어");
    movie8.setmUrlImage("/images/poster02.jpg");
    movie8.setmRelease("2019");
    movie8.setmDirector("송감독");
    results.add(movie8);

    Movie movie9 = new Movie();
    movie9.setmTitle("써니데이");
    movie9.setmUrlImage("/images/poster03.jpg");
    movie9.setmRelease("2018");
    movie9.setmDirector("한감독");
    results.add(movie9);

    pageContext.setAttribute("results", results);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색 결과</title>
    <style>
        body { background-color: #18181B; color: #FFFFFF; font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 40px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .page-header h1 { font-size: 24px; margin: 0; }
        .page-header h1 span { color: #E5E7EB; font-weight: bold; }
        
        /* --- [수정됨] --- */
        /* 깨진 CSS 문법을 올바르게 수정했습니다. */
        .sort-button { border: 1px solid #4B5563; 
        background-color: transparent; 
        color: #D1D5DB; padding: 8px 16px; border-radius: 6px; 
       font-size: 14px; cursor: pointer; }
        
        .results-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        .movie-card {
            width: 100%;
            background-color: #1f1f1f; 
            border-radius: 8px;
            overflow: hidden; 
            font-family: 'Pretendard', sans-serif;
        }
        
        .movie-card img {
            width: 100%;
            aspect-ratio: 3 / 4;
            object-fit: cover;
            display: block;
        }
        
        .info-section {
            padding: 16px;
        }
        .title {
            font-size: 18px;
            font-weight: 600;
            color: #ffffff;
            margin: 0 0 8px 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .metadata {
            font-size: 14px;
            color: #a0a0a0;
            margin: 0;
        }
        /* 기존 .sort-button 스타일을 대체할 .sort-select 스타일 */
		.sort-select {
		    /* 기본 디자인 초기화 */
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    appearance: none;
		
		    /* 기존 버튼과 유사한 디자인 적용 */
		    border: 1px solid #4B5563;
		    background-color: transparent;
		    color: #D1D5DB;
		    padding: 8px 32px 8px 16px; /* 오른쪽 여백을 늘려 화살표 공간 확보 */
		    border-radius: 6px;
		    font-size: 14px;
		    cursor: pointer;
		
		    /* 커스텀 화살표 아이콘 추가 (SVG) */
		    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
		    background-repeat: no-repeat;
		    background-position: right 0.7rem center;
		    background-size: 1.2em 1.2em;
		}
		
		/* 포커스될 때 테두리 색상 변경 (선택 사항) */
		.sort-select:focus {
		    outline: none;
		    border-color: #9ca3af;
		}
    </style>
</head>
<body>

<%-- --- [수정됨] --- --%>
<%-- 이 부분의 경로가 올바르지 않으면 404 에러가 발생할 수 있습니다. --%>
<%-- 테스트를 위해 잠시 주석 처리하거나, 실제 header.jsp 파일 위치에 맞게 경로를 수정하세요. --%>
	<jsp:include page="/include/header.jsp" />

    <div class="container">
        <div class="page-header">
		    <h1>검색 <span>"su"</span></h1>
		    
		    <select name="sort" class="sort-select">
		        <option value="latest">최신순</option>
		        <option value="reviews">리뷰많은순</option>
		        <option value="rating">평점높은순</option>
		    </select>
		</div>


        <div class="results-grid">
            <c:forEach var="item" items="${results}">
                <div class="movie-card"> 
                    <img src="${pageContext.request.contextPath}${item.mUrlImage}" alt="${item.mTitle}">
                    <div class="info-section">
                        <h3 class="title">${item.mTitle}</h3>
                        <p class="metadata">${item.mRelease} · ${item.mDirector}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>