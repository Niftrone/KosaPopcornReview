<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${actor.aName} - 인물 상세</title>
  
  <%-- CSS 경로를 c:url 태그로 감싸서 유연하게 만듭니다 --%>
  <link rel="stylesheet" href="<c:url value='/CSS/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/CSS/actordetail.css'/>" />
</head>

<body class="actor-body">
  <div class="actor-container">
    <a class="back-btn" href="javascript:history.back()"><span>‹</span> Back</a>

    <div class="actor-grid">

      <figure class="photo-card">
        <c:choose>
          <c:when test="${not empty actor.aUrlImage}">
            <%-- ★ 2. 이미지 경로를 실제 프로젝트에 맞게 수정합니다. --%>
            <%-- DB의 aUrlImage에 'haewon.jpg'와 같이 파일명만 있다면 아래 경로가 올바릅니다. --%>
            <img class="photo" src="<c:url value='/images/actors/${actor.aUrlImage}'/>" alt="${actor.aName}">
          </c:when>
          <c:otherwise>
            <img class="photo" src="<c:url value='/images/placeholders/actor.png'/>" alt="no image">
          </c:otherwise>
        </c:choose>
      </figure>

      <section class="info-card">
        <h1 class="actor-name">${actor.aName}</h1>

        <div class="bio only-plot">
          <c:choose>
            <c:when test="${not empty actor.aPlot}">
              <%-- ★ 3. 배우 설명(aPlot)은 줄바꿈 처리가 잘 되어 있으므로 그대로 둡니다. --%>
              ${fn:escapeXml(actor.aPlot)}
            </c:when>
            <c:otherwise>
              <span class="muted">등록된 소개가 없습니다.</span>
            </c:otherwise>
          </c:choose>
        </div>
      </section>

    </div>
  </div>
</body>
</html>