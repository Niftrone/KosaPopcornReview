<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.service.popcornreview.vo.Movie" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<jsp:include page="include/header.jsp" />

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