<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${actor.aName} - 인물 상세</title>
  <link rel="stylesheet" href="<c:url value='/CSS/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/CSS/actordetail.css'/>" />
</head>

<%-- ===== DEMO ONLY: 컨트롤러 미연결 시 화면 확인용 더미 데이터 ===== --%>
<c:if test="${empty actor}">
  <%
    String plot =
        "🎂 생년월일\n"
      + "2001년 1월 1일,\t 부산 출생\n\n"
      + "🎤 소속 / 포지션\n"
      + "SM엔터테인먼트 소속\n"
      + "걸그룹 aespa(에스파) 메인보컬·리드댄서\n\n"
      + "🚀 데뷔\n"
      + "2020년 싱글 \"Black Mamba\"\n"
      + "> 청아한 음색 + 뛰어난 무대 장악력으로 데뷔 직후 주목\n\n"
      + "🎧 활동 분야\n"
      + "- 에스파 음악 활동\n"
      + "- 방송·예능·광고\n"
      + "- 드라마 OST·글로벌 프로젝트\n"
      + "- 글로벌 패션 행사\n\n"
      + "💎 대표 활동 이력\n"
      + "- 2025년 \"World of Ralph Lauren\" 패션쇼 한국 대표 초청\n"
      + "- tvN 드라마 《Resident Playbook》 OST 'On Such a Day' 참여\n"
      + "- 에스파 'Whiplash' 영어 버전 & Steve Aoki 리믹스 참여 🌍 글로벌 공개\n\n"
      + "💬 특징 / 성격\n"
      + "- 밝고 유쾌한 성격\n"
      + "- 다채로운 퍼포먼스\n"
      + "- 팬들과의 적극적인 소통\n"
      + "- 성실하고 꾸준한 성장형 아티스트\n\n"
      + "🚩 향후 기대\n"
      + "팬덤과 함께 성장 중인 글로벌 K-POP 대표 아티스트로 앞으로의 무대와 행보가 더욱 기대되는 인물입니다.";

    com.service.popcornreview.vo.Actor demo = new com.service.popcornreview.vo.Actor();
    demo.setaId("a13-1");
    demo.setaName("오해원");
    demo.setaPlot(plot);
    demo.setaUrlImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/221013_Haewon_%28NMIXX%29_Airport_Departure.jpg/500px-221013_Haewon_%28NMIXX%29_Airport_Departure.jpg");
    request.setAttribute("actor", demo);
  %>
</c:if>

<body class="actor-body">
  <div class="actor-container">
    <!-- Back 버튼(가운데 컨테이너 내부) -->
    <a class="back-btn" href="javascript:history.back()"><span>‹</span> Back</a>

    <!-- 좌우 2열 레이아웃 -->
    <div class="actor-grid">

      <!-- 왼쪽: 프로필 이미지 -->
      <figure class="photo-card">
        <c:choose>
          <c:when test="${not empty actor.aUrlImage}">
            <img class="photo" src="${actor.aUrlImage}" alt="${actor.aName}">
          </c:when>
          <c:otherwise>
            <img class="photo" src="<c:url value='/images/placeholders/actor.png'/>" alt="no image">
          </c:otherwise>
        </c:choose>
      </figure>

      <!-- 오른쪽: 정보 카드 (이름 + aPlot 설명만) -->
      <section class="info-card">
        <h1 class="actor-name">${actor.aName}</h1>

        <!-- aPlot만 출력. 줄바꿈 보존을 위해 CSS에서 white-space: pre-line; 사용 -->
        <div class="bio only-plot">
          <c:choose>
            <c:when test="${not empty actor.aPlot}">
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
