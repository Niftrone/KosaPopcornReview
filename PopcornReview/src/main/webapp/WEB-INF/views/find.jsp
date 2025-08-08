<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ID/PWD</title>
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
        .find-container {
            background-color: #1F2937;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }
        h1 {
            color: #007AFF;
            font-size: 24px;
            margin-bottom: 15px;
        }
        p {
            font-size: 16px;
            margin-bottom: 25px;
        }
        .find-details {
        		font-family: 'Noto Sans KR', sans-serif;
     		width: 250px;
     		height: 50px;
            border-radius: 8px;
            font-size: 25px;
            text-align: center;
            color: #D1D5DB;
            margin: 25px 0px;
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
    <div class="find-container">
    
    		<h1>${findIdOrPw}</h1>

        <div class="find-details">
             ${findText}
        </div>

        <a href="javascript:history.back()" class="button">이전 페이지로 돌아가기</a>
    </div>
</body>
</html>
