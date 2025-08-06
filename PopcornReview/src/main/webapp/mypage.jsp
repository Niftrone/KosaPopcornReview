<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>마이페이지</title>

  <!-- 공통/페이지 CSS -->
  <<link rel="stylesheet" href="<c:url value='/CSS/common.css'/>" /> 
  <link rel="stylesheet" href="<c:url value='/CSS/mypage.css'/>" />

  <!-- 🔒 Bootstrap .modal 충돌 방지용 모달 전용 스타일(네임스페이스: mp-) -->
  <style>
    :root{
      --border:#232A33;
    }
    /* 기본: 보이기. (Bootstrap의 .modal {display:none} 덮어쓰기) */
    .mypage-body .mp-modal{
      position:fixed; inset:0; background:rgba(0,0,0,.45);
      display:flex !important; align-items:center; justify-content:center;
      z-index:1000;
    }
    /* 닫힘 상태 */
    .mypage-body .mp-modal[aria-hidden="true"]{ display:none !important; }
    .mypage-body .mp-modal-dialog{
      width:420px; background:#151B23; border:1px solid var(--border);
      border-radius:12px; overflow:hidden;
    }
    .mypage-body .mp-modal-header{
      display:flex; align-items:center; justify-content:space-between;
      padding:14px 16px; border-bottom:1px solid var(--border);
    }
    .mypage-body .mp-modal-header h3{ margin:0; font-size:16px; color:#EDEFF3; }
    .mypage-body .mp-modal-close{
      background:transparent; border:none; color:#fff; font-size:22px; cursor:pointer;
    }
    .mypage-body .mp-modal-body{ padding:16px; display:flex; flex-direction:column; align-items:center; }
    .mypage-body .mp-modal-footer{ width:336px; margin-top:12px; display:flex; gap:8px; justify-content:flex-end; }
  </style>
</head>
<body class="mypage-body">
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 헤더 -->
<jsp:include page="include/header.jsp" />

<div class="container"><!-- .mypage-body .container로 스코프 제한됨 -->

  <!-- ===== 프로필 영역 ===== -->
  <section class="profile-wrap">
    <div class="profile-card">
      <div class="profile-left">
        <div class="avatar-block">
          <div class="avatar">
            <c:url var="defAvatar" value="/image/avatar_default.png"/>
            <img src="${empty user.profileImage ? defAvatar : user.profileImage}" alt="프로필"/>
          </div>
          <button class="btn-primary btn-edit-under" id="btnEditProfile" type="button">프로필 수정</button>
        </div>

        <div class="profile-meta">
          <div class="nickname">
            <c:out value="${empty user.nickname ? '운짱' : user.nickname}"/>
          </div>
          <div class="joined">
            가입일 :
            <c:out value="${empty user.joinedAt ? '2025-07-22' : user.joinedAt}"/>
          </div>
        </div>
      </div>

      <div class="profile-right">
        <div class="stat-box">
          <div class="stat-title">내가 쓴 리뷰</div>
          <div class="stat-value">
            <c:choose>
              <c:when test="${not empty reviewList}">${fn:length(reviewList)}</c:when>
              <c:otherwise>6</c:otherwise>
            </c:choose>
          </div>
        </div>
        <div class="stat-box">
          <div class="stat-title">내가 쓴 댓글</div>
          <div class="stat-value">
            <c:choose>
              <c:when test="${not empty commentList}">${fn:length(commentList)}</c:when>
              <c:otherwise>3</c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== 내가 쓴 리뷰 (슬라이드) ===== -->
  <section class="section">
    <h2 class="section-title">내가 쓴 리뷰</h2>

    <div class="mp-carousel" data-carousel="reviews">
      <button class="mp-btn mp-prev" type="button" aria-label="이전">‹</button>
      <div class="mp-viewport">
        <div class="mp-track">

          <!-- [컨트롤러] 리뷰 상세 보기
               - 추천 매핑: GET /review/{id}
                 @GetMapping("/review/{id}")  // PathVariable 사용
               - 현 JSP 링크는 쿼리스트링 버전도 지원: GET /reviewdetailview?id=...
                 @GetMapping("/reviewdetailview") // @RequestParam("id") Long id
          -->
          <c:if test="${not empty reviewList}">
            <c:forEach var="r" items="${reviewList}">
              <div class="mp-item">
                <a class="review-card" href="${ctx}/reviewdetailview?id=${r.id}">
                  <div class="rating-badge">🎉 <span><c:out value="${r.score}"/></span></div>
                  <div class="review-title"><c:out value="${r.movieTitle}"/></div>
                  <div class="review-snippet"><c:out value="${r.snippet}"/></div>
                </a>
              </div>
            </c:forEach>
          </c:if>

          <!-- 더미 -->
          <c:if test="${empty reviewList}">
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=201">
                <div class="rating-badge">🎉 <span>2.1</span></div>
                <div class="review-title">넌 이대로야</div>
                <div class="review-snippet">나는 이영화를 1점 이 줄래도, 널 닮지 않아서, 널 위함...</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=202">
                <div class="rating-badge">🎉 <span>4.5</span></div>
                <div class="review-title">나는 여름이 싫다</div>
                <div class="review-snippet">날씨 얘기를 덧붙이며 단평 남김. 더워서 영화관으로...</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=203">
                <div class="rating-badge">🎉 <span>4.5</span></div>
                <div class="review-title">변호사 같은 프로의식</div>
                <div class="review-snippet">설득력 있는 흐름과 자료 제시, 불필요한 감정 배제...</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=204">
                <div class="rating-badge">🎉 <span>2.9</span></div>
                <div class="review-title">너는 나중에, 우주를 지배하지</div>
                <div class="review-snippet">전개는 지루, 시간배치 아쉽지만 전체 여운이...</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=205">
                <div class="rating-badge">🎉 <span>4.5</span></div>
                <div class="review-title">내일 아침도, 오렌지맛이길</div>
                <div class="review-snippet">비유적 묘사와 장면 언급, 짧고 굵은 표현이 인상적...</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="review-card" href="${ctx}/reviewdetailview?id=206">
                <div class="rating-badge">🎉 <span>4.5</span></div>
                <div class="review-title">변호사 같은, 유영의 글쓰기</div>
                <div class="review-snippet">정제된 문장, 핵심만 남기는 문체. 영화에서 가져온...</div>
              </a>
            </div>
          </c:if>

        </div>
      </div>
      <button class="mp-btn mp-next" type="button" aria-label="다음">›</button>
    </div>
  </section>

  <!-- ===== 내가 쓴 댓글 (슬라이드) ===== -->
  <section class="section" id="my-comments">
    <h2 class="section-title">내가 쓴 댓글</h2>

    <div class="mp-carousel" data-carousel="comments">
      <button class="mp-btn mp-prev" type="button" aria-label="이전">‹</button>

      <div class="mp-viewport">
        <div class="mp-track">

          <!-- [컨트롤러] 댓글 카드 클릭 시 이동: 리뷰 상세
               - 추천 매핑: GET /review/{id}
               - 현 JSP 링크: GET ${ctx}/reviewdetailview?id=${cmt.reviewId}
          -->
          <c:if test="${not empty commentList}">
            <c:forEach var="cmt" items="${commentList}">
              <div class="mp-item">
                <div class="comment-item clickable"
                     data-href="${ctx}/reviewdetailview?id=${cmt.reviewId}">
                  <div class="comment-body">
                    <div class="comment-title">
                      <a href="${ctx}/reviewdetailview?id=${cmt.reviewId}">
                        <c:out value="${cmt.reviewTitle}"/>
                      </a>
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

          <!-- 더미 -->
          <c:if test="${empty commentList}">
            <div class="mp-item">
              <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=101">
                <div class="comment-body">
                  <div class="comment-title">나는 여름이 싫다</div>
                  <div class="comment-text">역동성은 좋지만 과한 디테일은 좀 빼면 낫겠어요…</div>
                </div>
                <div class="comment-reply">↳ 감독의 브리핑과 느낌은 노린 것 같아요. 균형맞추면 더 좋을 듯!</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=102">
                <div class="comment-body">
                  <div class="comment-title">영화에서 유려하게 숨 쉬는 느낌을 주는 장면과 시퀀스…</div>
                  <div class="comment-text">디졸브 비율만 고치면 느낌이 훨씬 좋아질 듯요.</div>
                </div>
                <div class="comment-reply">↳ 연출에서 과도한 중첩을 조금만 줄여도 충분해 보여요.</div>
              </a>
            </div>
            <div class="mp-item">
              <a class="comment-item clickable" href="${ctx}/reviewdetailview?id=103">
                <div class="comment-body">
                  <div class="comment-title">불협화음 같은 사운드디자인, 결국 이것들이 감정에 미치는…</div>
                  <div class="comment-text">결말 직전 리듬이 급해져서 집중이 깨졌습니다.</div>
                </div>
                <div class="comment-reply">↳ 마지막 전환부 템포를 5초만 늦추면 완급이 훨씬 자연스러울 듯!</div>
              </a>
            </div>
          </c:if>

        </div>
      </div>

      <button class="mp-btn mp-next" type="button" aria-label="다음">›</button>
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

    <!-- [컨트롤러] 회원 정보 수정
         - 매핑: POST /user/update
           @PostMapping("/user/update")
           파라미터: loginId, email, name, birth, phone, nickname, MultipartFile profileImage
         - 반환: redirect:/mypage (권장)
    -->
    <form id="profileEditForm" method="post" action="${ctx}/user/update"
          enctype="multipart/form-data" class="mp-modal-body">

      <!-- 아이디(읽기전용) -->
      <label class="form-row">
        <span>아이디</span>
        <input type="text" name="loginId" value="<c:out value='${user.loginId}'/>" readonly />
      </label>

      <!-- 이메일 -->
      <label class="form-row">
        <span>이메일</span>
        <input type="email" name="email" value="<c:out value='${user.email}'/>" placeholder="이메일" />
      </label>

      <!-- 이름 -->
      <label class="form-row">
        <span>이름</span>
        <input type="text" name="name" value="<c:out value='${user.name}'/>" placeholder="이름을 입력해주세요." />
      </label>

      <!-- 생년월일 -->
      <label class="form-row">
        <span>생년월일</span>
        <input type="date" name="birth" value="<c:out value='${user.birth}'/>" />
      </label>

      <!-- 휴대폰 -->
      <label class="form-row">
        <span>핸드폰 번호</span>
        <input type="tel" name="phone" value="<c:out value='${user.phone}'/>" placeholder="핸드폰 번호를 입력하세요" />
      </label>

      <!-- 닉네임 -->
      <label class="form-row">
        <span>닉네임</span>
        <input type="text" name="nickname" value="<c:out value='${empty user.nickname ? "운짱" : user.nickname}'/>" required />
      </label>

      <!-- 프로필 이미지 -->
      <label class="form-row">
        <span>프로필 이미지</span>
        <input type="file" name="profileImage" accept="image/*"/>
      </label>

      <div class="mp-modal-footer">
        <!-- [컨트롤러] 회원 탈퇴
             - 매핑: POST /user/delete  (로그인 사용자의 본인 확인 필수)
               @PostMapping("/user/delete")
               파라미터: loginId  (또는 서버에서 인증정보로 식별)
             - 반환: redirect:/  (로그아웃 및 홈)
        -->
        <button type="button" class="btn-danger" id="btnDeleteAccount">회원탈퇴</button>
        <button type="submit" class="btn-primary">저장</button>
        <button type="button" class="btn-ghost" id="btnCancel">취소</button>
      </div>
    </form>
  </div>
</div>

<!-- 회원탈퇴 전송용 숨김 폼 -->
<form id="deleteForm" method="post" action="${ctx}/user/delete" style="display:none;">
  <input type="hidden" name="loginId" value="<c:out value='${user.loginId}'/>" />
  <%-- Spring Security 사용 시 CSRF 토큰 추가 --%>
</form>

<!-- ===== 스크립트 ===== -->

<!-- 변경 확인(이메일/이름/생년월일/핸드폰/닉네임/프로필 이미지) -->
<script>
(function(){
  var form = document.getElementById('profileEditForm');
  if (!form) return;

  function v(el){ return el && el.value ? el.value.trim() : ''; }

  var initial = {
    email:    v(form.email),
    name:     v(form.name),
    birth:    v(form.birth),
    phone:    v(form.phone),
    nickname: v(form.nickname)
  };

  form.addEventListener('submit', function(e){
    var changed = [];
    if (v(form.email)    !== initial.email)    changed.push('이메일');
    if (v(form.name)     !== initial.name)     changed.push('이름');
    if (v(form.birth)    !== initial.birth)    changed.push('생년월일');
    if (v(form.phone)    !== initial.phone)    changed.push('핸드폰 번호');
    if (v(form.nickname) !== initial.nickname) changed.push('닉네임');
    if (form.profileImage && form.profileImage.files && form.profileImage.files.length > 0) {
      changed.push('프로필 이미지');
    }

    var listText = changed.map(function(s){ return '• ' + s; }).join('\n');
    var unit = (changed.length === 1 ? '항목이' : '항목들이');
    var msg = changed.length
      ? '다음 ' + changed.length + '개 ' + unit + ' 변경됩니다:\n\n' + listText + '\n\n정말 저장하시겠습니까?'
      : '변경된 내용이 없습니다. 그대로 저장하시겠습니까?';

    if (!confirm(msg)) e.preventDefault();
  });
})();
</script>

<!-- 모달 열고 닫기 -->
<script>
(function(){
  var $ = function(s){ return document.querySelector(s); };
  var modal = $('#editProfileModal');
  if (!modal) return;

  function open(){  modal.setAttribute('aria-hidden','false'); document.body.classList.add('noscroll'); }
  function close(){ modal.setAttribute('aria-hidden','true');  document.body.classList.remove('noscroll'); }

  var btnEdit  = $('#btnEditProfile');
  var btnClose = $('#btnCloseModal');
  var btnCancel= $('#btnCancel');

  if (btnEdit)  btnEdit.addEventListener('click', open);
  if (btnClose) btnClose.addEventListener('click', close);
  if (btnCancel)btnCancel.addEventListener('click', close);

  modal.addEventListener('click', function(e){ if (e.target === modal) close(); });
})();
</script>

<!-- 댓글 카드 전체 클릭 처리 -->
<script>
(function(){
  document.querySelectorAll('.comment-item.clickable').forEach(function(el){
    el.addEventListener('click', function(e){
      if (e.target.closest('a, button')) return; // 내부 링크/버튼은 기본동작
      var url = el.getAttribute('data-href');
      if (!url) {
        var a = el.querySelector('a');
        url = a ? a.getAttribute('href') : null;
      }
      if (url) location.href = url;
    });
  });
})();
</script>

<!-- 회원탈퇴 확인 후 전송 -->
<script>
(function(){
  var btn = document.getElementById('btnDeleteAccount');
  var form = document.getElementById('deleteForm');
  if (!btn || !form) return;

  btn.addEventListener('click', function(){
    var msg = '정말 회원탈퇴 하시겠습니까?\n탈퇴 시 계정과 데이터가 삭제될 수 있습니다.';
    if (confirm(msg)) form.submit();
  });
})();
</script>

<!-- 캐러셀(리뷰/댓글 공용) -->
<script>
(function(){
  document.querySelectorAll('.mp-carousel').forEach(initCarousel);

  function initCarousel(root){
    var vp   = root.querySelector('.mp-viewport');  // 스크롤 컨테이너
    var track= root.querySelector('.mp-track');      // 아이템 트랙
    var prev = root.querySelector('.mp-prev');
    var next = root.querySelector('.mp-next');
    if (!vp || !track || !prev || !next) return;

    function step(){
      var item = track.querySelector('.mp-item');
      if (!item) return vp.clientWidth;
      var gap = parseFloat(getComputedStyle(track).gap || 14);
      return item.getBoundingClientRect().width + gap;
    }
    function updateBtns(){
      var max = vp.scrollWidth - vp.clientWidth - 1;
      prev.disabled = vp.scrollLeft <= 0;
      next.disabled = vp.scrollLeft >= max;
    }
    prev.addEventListener('click', function(){
      vp.scrollBy({ left: -step(), behavior: 'smooth' });
      setTimeout(updateBtns, 200);
    });
    next.addEventListener('click', function(){
      vp.scrollBy({ left:  step(), behavior: 'smooth' });
      setTimeout(updateBtns, 200);
    });
    vp.addEventListener('scroll', updateBtns);
    window.addEventListener('resize', updateBtns);
    updateBtns();
  }
})();
</script>
</body>
</html>
