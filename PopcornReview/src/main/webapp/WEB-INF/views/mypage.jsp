<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>마이페이지</title>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


  <!-- 공통/페이지 CSS -->
  <link rel="stylesheet" href="../../CSS/common.css" /> 
  <link rel="stylesheet" href="../../CSS/mypage.css" />

  <!-- Slick CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>

  
</head>

<body class="mypage-body">
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<jsp:include page="include/header.jsp" />

<div class="container">
  <!-- 프로필 -->
  <section class="profile-wrap">
    <div class="profile-card profile-card--compact">
      <div class="profile-left">
        <div class="ph-meta">
          <h1 class="ph-name"><c:out value="${empty user.nickname ? '운짱' : user.nickname}"/></h1>
          <div class="ph-joined">가입일 : <c:out value="${empty user.joinedAt ? '2025-07-22' : user.joinedAt}"/></div>
          <button class="ph-edit" id="btnEditProfile" type="button">프로필 수정</button>
        </div>
      </div>
    </div>
  </section>

  <!-- 내가 쓴 리뷰 (슬라이더) -->
  <section class="section">
    <h2 class="section-title">내가 쓴 리뷰</h2>
    <div class="review-card-list">
      <c:if test="${not empty reviewList}">
        <c:forEach var="r" items="${reviewList}">
          <div>
            <a class="review-card" href="${ctx}/reviewdetailview?id=${r.id}">
              <div class="rating-badge">🎉 <span><c:out value="${r.score}"/></span></div>
              <div class="review-title"><c:out value="${r.movieTitle}"/></div>
              <div class="review-snippet"><c:out value="${r.snippet}"/></div>
            </a>
          </div>
        </c:forEach>
      </c:if>

      <c:if test="${empty reviewList}">
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=201">
          <div class="rating-badge">🎉 <span>2.1</span></div>
          <div class="review-title">넌 이대로야</div>
          <div class="review-snippet">나는 이영화를 1점 이 줄래도, 널 닮지 않아서, 널 위함...</div>
        </a></div>
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=202">
          <div class="rating-badge">🎉 <span>4.5</span></div>
          <div class="review-title">나는 여름이 싫다</div>
          <div class="review-snippet">날씨 얘기를 덧붙이며 단평 남김. 더워서 영화관으로...</div>
        </a></div>
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=203">
          <div class="rating-badge">🎉 <span>4.5</span></div>
          <div class="review-title">변호사 같은 프로의식</div>
          <div class="review-snippet">설득력 있는 흐름과 자료 제시, 불필요한 감정 배제...</div>
        </a></div>
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=204">
          <div class="rating-badge">🎉 <span>2.9</span></div>
          <div class="review-title">너는 나중에, 우주를 지배하지</div>
          <div class="review-snippet">전개는 지루, 시간배치 아쉽지만 전체 여운이...</div>
        </a></div>
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=205">
          <div class="rating-badge">🎉 <span>4.5</span></div>
          <div class="review-title">내일 아침도, 오렌지맛이길</div>
          <div class="review-snippet">짧고 굵은 표현이 인상적...</div>
        </a></div>
        <div><a class="review-card" href="${ctx}/reviewdetailview?id=206">
          <div class="rating-badge">🎉 <span>4.5</span></div>
          <div class="review-title">변호사 같은, 유영의 글쓰기</div>
          <div class="review-snippet">핵심만 남기는 문체...</div>
        </a></div>
      </c:if>
    </div>
  </section>

  <!-- 내가 쓴 댓글 (슬라이더, 독립 컨테이너) -->
  <section class="section" id="my-comments">
    <h2 class="section-title">내가 쓴 댓글</h2>
    <div class="mypage-comment-list">
      <c:if test="${not empty commentList}">
        <c:forEach var="cmt" items="${commentList}">
          <div>
            <div class="comment-item clickable" data-href="${ctx}/reviewdetailview?id=${cmt.reviewId}">
              <div class="comment-body">
                <div class="comment-title">
                  <a href="${ctx}/reviewdetailview?id=${cmt.reviewId}"><c:out value="${cmt.reviewTitle}"/></a>
                </div>
                <div class="comment-text"><c:out value="${cmt.content}"/></div>
              </div>
              <c:if test="${not empty cmt.reply}">
                <div class="comment-reply">↳ <c:out value="${cmt.reply}"/></div>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </c:if>

      <c:if test="${empty commentList}">
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=101">
            <div class="comment-body">
              <div class="comment-title">나는 여름이 싫다</div>
              <div class="comment-text">역동성은 좋지만 과한 디테일은 좀 빼면 낫겠어요…</div>
            </div>
            <div class="comment-reply">↳ 균형 맞추면 훨씬 좋을 듯!</div>
          </a>
        </div>
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=102">
            <div class="comment-body">
              <div class="comment-title">영화에서 숨 쉬는 장면과 시퀀스…</div>
              <div class="comment-text">디졸브 비율만 고치면 느낌이 좋아질 듯요.</div>
            </div>
            <div class="comment-reply">↳ 중첩을 조금만 줄여도 충분!</div>
          </a>
        </div>
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=103">
            <div class="comment-body">
              <div class="comment-title">사운드디자인이 감정에 미치는…</div>
              <div class="comment-text">결말 직전 리듬이 급해져 집중이 깨졌어요.</div>
            </div>
            <div class="comment-reply">↳ 마지막 전환 5초만 늦추면 자연스러워짐.</div>
          </a>
        </div>

        <!-- 요청: 이윤열 밈 톤으로 더미 3개 추가(가벼운 드립, 과도한 욕설 없음) -->
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=104">
            <div class="comment-body">
              <div class="comment-title">이윤열 또 잠자나요…?</div>
              <div class="comment-text">클라이맥스 직전에 꾸벅— 리듬이 같이 늘어졌습니다 😂</div>
            </div>
            <div class="comment-reply">↳ 알람 맞추고 다시 보면 명장면 인증.</div>
          </a>
        </div>
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=105}">
            <div class="comment-body">
              <div class="comment-title">리뷰는 언제? 이윤열 타이밍 미스</div>
              <div class="comment-text">편집 타이밍 놓치는 장면, 딱 1초만 당기면 딱 좋을 듯.</div>
            </div>
            <div class="comment-reply">↳ 밤샘 편집 말고 낮에 보자 우리…</div>
          </a>
        </div>
        <div>
          <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=106">
            <div class="comment-body">
              <div class="comment-title">이윤열 깨어있을 때 보세요</div>
              <div class="comment-text">중반부는 호흡이 길어 졸릴 수 있어요. 컷을 몇 개만 줄이면 신나요.</div>
            </div>
            <div class="comment-reply">↳ 템포 업! 리듬 타면 명불허전.</div>
          </a>
        </div>
      </c:if>
    </div>
  </section>
</div>

<!-- ===== [모달] 프로필 수정 ===== -->
<div class="mp-modal" id="editProfileModal" aria-hidden="true">
  <div class="mp-modal-dialog profile-edit">
    <div class="mp-modal-header">
      <h3>프로필 수정</h3>
      <button class="mp-modal-close" id="btnCloseModal" type="button">×</button>
    </div>

    <form id="profileEditForm" method="post" action="${ctx}/user/update"
          enctype="multipart/form-data" class="mp-modal-body">
      <label class="form-row"><span>아이디</span>
        <input type="text" name="loginId" value="<c:out value='${user.loginId}'/>" readonly /></label>
      <label class="form-row"><span>이메일</span>
        <input type="email" name="email" value="<c:out value='${user.email}'/>" placeholder="이메일" /></label>
      <label class="form-row"><span>이름</span>
        <input type="text" name="name" value="<c:out value='${user.name}'/>" placeholder="이름을 입력해주세요." /></label>
      <label class="form-row"><span>생년월일</span>
        <input type="date" name="birth" value="<c:out value='${user.birth}'/>" /></label>
      <label class="form-row"><span>핸드폰 번호</span>
        <input type="tel" name="phone" value="<c:out value='${user.phone}'/>" placeholder="핸드폰 번호를 입력하세요" /></label>
      <label class="form-row"><span>닉네임</span>
        <input type="text" name="nickname" value="<c:out value='${empty user.nickname ? "운짱" : user.nickname}'/>" required /></label>
     <!--  <label class="form-row"><span>프로필 이미지</span>
        <input type="file" name="profileImage" accept="image/*"/></label>
 -->
      <div class="mp-modal-footer">
        <button type="button" class="ph-edit" id="btnDeleteAccount">회원탈퇴</button>
        <button type="submit" class="ph-edit">저장</button>
        
      </div>
    </form>
  </div>
</div>

<form id="deleteForm" method="post" action="${ctx}/user/delete" style="display:none;">
  <input type="hidden" name="loginId" value="<c:out value='${user.loginId}'/>" />
</form>

<!-- ===== Scripts (정적 로드로 확실히) ===== -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js" defer></script>

<script defer>
  window.addEventListener('DOMContentLoaded', function(){
    // 프로필 수정 모달
    (function(){
      var modal = document.getElementById('editProfileModal');
      var btnEdit = document.getElementById('btnEditProfile');
      var btnClose = document.getElementById('btnCloseModal');
      var btnCancel= document.getElementById('btnCancel');
      function open(){ modal.setAttribute('aria-hidden','false'); document.body.classList.add('noscroll'); }
      function close(){ modal.setAttribute('aria-hidden','true');  document.body.classList.remove('noscroll'); }
      if (btnEdit)  btnEdit.addEventListener('click', open);
      if (btnClose) btnClose.addEventListener('click', close);
      if (btnCancel)btnCancel.addEventListener('click', close);
      modal.addEventListener('click', function(e){ if (e.target === modal) close(); });
    })();

    // 댓글 카드 전체 클릭
    (function(){
      document.querySelectorAll('.comment-item.clickable').forEach(function(el){
        el.addEventListener('click', function(e){
          if (e.target.closest('a, button')) return;
          var url = el.getAttribute('data-href') || (el.querySelector('a') && el.querySelector('a').getAttribute('href'));
          if (url) location.href = url;
        });
      });
    })();
  });

  // jQuery / Slick 의존: load 이후 보장 초기화
  window.addEventListener('load', function(){
    var $r = jQuery('.review-card-list');
    var $c = jQuery('.mypage-comment-list');

    if ($r.length && !$r.hasClass('slick-initialized')) {
      $r.slick({
        slidesToShow: 3, slidesToScroll: 1, arrows: true, dots: false, infinite: false,
        adaptiveHeight: false, variableWidth: false,
        responsive: [
          { breakpoint: 1024, settings: { slidesToShow: 2, slidesToScroll: 1 } },
          { breakpoint: 768,  settings: { slidesToShow: 1, slidesToScroll: 1 } }
        ]
      });
    }
    if ($c.length && !$c.hasClass('slick-initialized')) {
      $c.slick({
        slidesToShow: 3, slidesToScroll: 1, arrows: true, dots: false, infinite: false,
        adaptiveHeight: false, variableWidth: false,
        responsive: [
          { breakpoint: 1024, settings: { slidesToShow: 2, slidesToScroll: 1 } },
          { breakpoint: 768,  settings: { slidesToShow: 1, slidesToScroll: 1 } }
        ]
      });
    }
    if (window.console) console.log('[mypage] slick init:', !!(jQuery.fn && jQuery.fn.slick));
  });
</script>
<script src="../../JS/common.js"></script>
</body>
</html>
