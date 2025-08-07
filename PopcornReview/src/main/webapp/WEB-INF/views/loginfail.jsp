<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #121619;
            color: #E5E7EB;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .error-container {
            background-color: #1F2937;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }
        h1 {
            color: #F87171;
            font-size: 24px;
            margin-bottom: 15px;
        }
        p {
            font-size: 16px;
            margin-bottom: 25px;
        }
        .error-details {
            background-color: #374151;
            padding: 15px;
            border-radius: 8px;
            font-family: monospace;
            font-size: 13px;
            text-align: left;
            white-space: pre-wrap; /* 줄 바꿈을 위해 추가 */
            word-wrap: break-word; /* 긴 단어 줄 바꿈 */
            color: #D1D5DB;
            margin-bottom: 25px;
        }
        a.button {
            display: inline-block;
            background-color: #3B82F6;
            color: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.2s;
        }
        a.button:hover {
            background-color: #2563EB;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>로그인 실패</h1>
        <p>로그인에 실패하셨습니다 ID와 비번을 다시 입력해주세요.</p>
        
        <!-- 컨트롤러에서 전달한 에러 메시지 표시 -->
        <c:if test="${not empty errorMessage}">
	        <div class="error-details">
	            <strong>오류 내용:</strong> ${errorMessage}
	        </div>
        </c:if>

        <a href="javascript:history.back()" class="button">확인</a>
    </div>
</body>
</html>
