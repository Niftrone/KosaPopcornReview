<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.service.popcornreview.vo.Movie" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색 결과</title>
    
    <style>
        body { 
            background-color: #18181B; 
            color: #FFFFFF; 
            font-family: 'Malgun Gothic', sans-serif; 
            margin: 0;
        }
        main {
            padding: 40px;
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto;
        }
        .page-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 30px;
        }
        .page-header h1 { 
            font-size: 24px; 
            margin: 0;
        }
        .page-header h1 span { 
            color: #E5E7EB; 
            font-weight: bold;
        }
        .results-grid { 
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .movie-card {
            width: 100%;
            background-color: #1f1f1f;
            border-radius: 8px;
            overflow: hidden; 
            font-family: 'Pretendard', sans-serif;
            text-decoration: none; /* a 태그의 밑줄 제거 */
            color: inherit; /* a 태그의 색상 상속 */
            display: block; /* a 태그를 블록 요소로 만듦 */
            transition: background-color 0.2s; /* 부드러운 색상 변경 효과 */
        }
        
        .movie-card:hover {
            background-color: #2f2f2f; /* 마우스 오버 시 배경색 변경 */
        }
        /* [수정됨] 이미지에 적용된 height: 100% 속성 제거 */
        .movie-card img {
            width: 100%;
            aspect-ratio: 2 / 3;
            object-fit: cover;
            display: block;
        }
        .info-section {
            padding: 12px;
        }
        .info-section .title {
            font-size: 16px;
            font-weight: 600;
            color: #ffffff;
            margin: 0 0 8px 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .metadata {
            font-size: 12px;
            color: #a0a0a0;
            margin: 0;
        }
		.sort-select {
		    -webkit-appearance: none; 
            -moz-appearance: none; 
            appearance: none;
		    border: 1px solid #4B5563;
		    background-color: transparent;
		    color: #D1D5DB;
		    padding: 8px 32px 8px 16px; 
		    border-radius: 6px;
		    font-size: 14px;
		    cursor: pointer;
		    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
		    background-repeat: no-repeat;
		    background-position: right 0.7rem center;
		    background-size: 1.2em 1.2em;
		}
		.sort-select:focus {
		    outline: none;
		    border-color: #9ca3af;
		}
    </style>
</head>
<body>

	<jsp:include page="include/header.jsp" />
	
	<main>
    <div class="container">
        <div class="page-header">
		    <h1>검색 <span>"${query}"</span></h1>
		    
		    <select name="sort" class="sort-select">
		        <option value="latest">최신순</option>
		        <option value="reviews">리뷰많은순</option>
		        <option value="rating">평점높은순</option>
		    </select>
		</div>

        <div class="results-grid">
            <c:forEach var="item" items="${movies}">
               
                 <a href="/movie/detail?mId=${item.mId}" class="movie-card">
                    <img src="${pageContext.request.contextPath}${item.mUrlImage}" alt="${item.mTitle}">
                    <div class="info-section">
                        <h3 class="title">${item.mTitle}</h3>
                        <p class="metadata">
                            <fmt:formatDate value="${item.mRelease}" pattern="yyyy-MM-dd" />
                            <c:if test="${not empty item.mDirector}">
                                · ${item.mDirector}
                            </c:if>
                        </p>
                   </div>
                </a>
            </c:forEach>
        </div>
    </div>
    </main>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function() {
    // 컨트롤러에서 넘겨준 현재 정렬 기준('sort')을 <select> 태그에 반영합니다.
    
    const currentSort = '${sort}'; 
    if (currentSort) {
        $('.sort-select').val(currentSort);
    }

    // 정렬 기준을 변경하면 컨트롤러로 요청을 보냅니다.
    $('.sort-select').on('change', function() {
        const selectedSort = $(this).val();
        const currentQuery = '${query}'; 

        // ✨ [수정됨] 요청 URL을 '/movie/sort'에서 '/movie/search'로 변경합니다.
        location.href = `/movie/search?query=\${encodeURIComponent(currentQuery)}&sort=\${selectedSort}`;
    });
});
</script>
</body>
</html>