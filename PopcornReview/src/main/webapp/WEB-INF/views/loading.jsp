네, 물론입니다. 요청하신 대로 이미지와 텍스트를 중앙에 배치하여 인상적인 에러 페이지를 만들어 드릴게요.

CSS의 Flexbox를 사용하면 이미지와 텍스트를 화면 정중앙에 쉽고 깔끔하게 배치할 수 있습니다.

## error.jsp 전체 코드
아래 코드를 복사하여 error.jsp 파일에 붙여넣으면 바로 사용할 수 있습니다.

Java

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러가 발생했습니다</title>
<style>
    /* 전체 페이지 스타일 */
    html, body {
        height: 100%;
        margin: 0;
        background-color: #18181B; /* 배경색을 어둡게 */
        color: #E5E7EB; /* 기본 글자색 */
        font-family: 'Pretendard', 'Malgun Gothic', sans-serif; /* 깔끔한 폰트 적용 */
    }

    /* 컨테이너를 화면 정중앙에 배치 (Flexbox 사용) */
    .error-container {
        display: flex;
        flex-direction: column; /* 아이템을 세로로 정렬 */
        justify-content: center; /* 세로 중앙 정렬 */
        align-items: center; /* 가로 중앙 정렬 */
        height: 100%;
        text-align: center;
    }

    /* 에러 이미지 스타일 */
    .error-image {
        width: 100%;
        max-width: 600px; /* 이미지 최대 너비 제한 */
        height: auto;
        border-radius: 16px; /* 모서리를 부드럽게 */
        margin-bottom: 32px; /* 텍스트와의 간격 */
    }

    /* 에러 메시지 텍스트 스타일 */
    .error-message {
        font-size: 4.5rem; /* 큼직한 글자 크기 (40px) */
        font-weight: 600; /* 살짝 굵게 */
        margin: 0;
    }
</style>
</head>
<body>

    <div class="error-container">
        <!-- 이미지 경로를 실제 프로젝트 경로에 맞게 수정하세요. -->
        <img src="${pageContext.request.contextPath}/image/error.jpg" alt="에러 이미지" class="error-image">
        
        <h1 class="error-message">해원이는 생각 중...</h1>
    </div>

</body>
</html>