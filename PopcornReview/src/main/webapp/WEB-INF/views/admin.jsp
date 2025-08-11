<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/* 페이징 샘플 (기존 로직 유지) */
int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
int itemsPerPage = 10;
int start = (pageNum - 1) * itemsPerPage + 1;
int end = pageNum * itemsPerPage;
request.setAttribute("start", start);
request.setAttribute("end", end);
request.setAttribute("pageNum", pageNum);
%>
<%-- ========================================================== --%>
<%-- [수정 1] section 파라미터를 읽어 현재 활성화할 메뉴를 결정합니다. --%>
<%-- 파라미터가 없으면 'notice'를 기본값으로 사용합니다.          --%>
<%-- ========================================================== --%>
<c:set var="activeSection" value="${empty param.section ? 'notice' : param.section}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin</title>
<link rel="stylesheet" href="./css/common.css" />
<style>
/* ====== 기존 스타일 유지 ====== */
body {
  background-color: #121619;
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
}
.container { display: flex; height: 100vh; }
.sidebar {
  width: 200px; background-color: #1F2937;
  display: flex; flex-direction: column; align-items: center;
  padding: 30px 10px; flex-shrink: 0;
}
.sidebar h2 { color: #fff; font-size: 24px; margin-bottom: 40px; font-weight: bold; }
.sidebar h2 a {
  color: inherit; text-decoration: none; font-size: inherit;
  background-color: transparent; padding: 0; margin: 0; display: inline; width: auto; border-radius: 0;
}
.sidebar h2 a:hover { background-color: transparent; }

/* a도 버튼처럼 보이도록 */
.sidebar button, .sidebar a {
  background-color: #1F2937; color: #fff; font-size: 15px;
  margin-bottom: 15px; border: none; text-align: left; padding: 12px 20px;
  width: 100%; border-radius: 8px; cursor: pointer; text-decoration: none;
  box-sizing: border-box; display: block;
}
.sidebar button.active, .sidebar button:hover, .sidebar a.active, .sidebar a:hover { background-color: #3B82F6; }

.main { flex: 1; padding: 40px; color: #fff; overflow-y: auto; }
.section { display: none; }
.section.active { display: block; }
.title { font-size: 22px; margin-bottom: 25px; font-weight: bold; }

.btn-top {
  background-color: #3B82F6; color: #fff; padding: 10px 24px; margin-bottom: 20px;
  border-radius: 8px; border: none; font-weight: bold; cursor: pointer;
}

.search-box { display: flex; justify-content: center; margin-bottom: 20px; }
.search-box form { display: flex; align-items: center; width: 60%; max-width: 600px; }
.search-box input[type="text"] {
  flex: 1; padding: 10px 14px; border-radius: 6px; border: none;
  background-color: #4B5563; color: #fff; font-size: 14px;
}
.search-box button {
  padding: 10px 16px; border: none; border-radius: 6px; background-color: #3B82F6; color: #fff; margin-left: 8px; cursor: pointer;
}

.table-box { background-color: #1F2937; border-radius: 10px; padding: 10px; }
.table-box table { width: 100%; border-collapse: collapse; }
.table-box th, .table-box td { padding: 8px; text-align: center; font-size: 14px; }
.table-box tr:nth-child(even) { background-color: #1F2937; }
.table-box button { padding: 6px 10px; background-color: #374151; color: #fff; border: none; border-radius: 4px; cursor: pointer; }

.pagination { margin-top: 20px; text-align: center; }
.pagination a { color: #fff; background-color: #374151; padding: 6px 12px; margin: 0 4px; text-decoration: none; border-radius: 4px; }
.pagination a.active { background-color: #3B82F6; }

/* 모달 */
.modal {
  display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0,0,0,.6); justify-content: center; align-items: center; z-index: 1000;
}
.modal.active { display: flex; }
.modal-box {
  background: #374151; padding: 30px; border-radius: 10px; width: 600px; box-sizing: border-box;
}
.modal-box form { display: flex; flex-direction: column; gap: 15px; }
.modal-box input, .modal-box textarea {
  width: 100%; padding: 10px; border: none !important; border-radius: 6px; background: #4B5563; color: #fff; box-sizing: border-box;
}
.modal-box textarea { resize: vertical; }
.modal-box h3 { font-size: 18px; margin-bottom: 10px; text-align: left; }
.button-group { display: flex; justify-content: flex-end; gap: 10px; }
.button-group button { padding: 10px 20px; border: none; border-radius: 6px; background: #1F2937; color: #fff; cursor: pointer; }

/* 배우 자동완성 UI */
.actor-input-container { position: relative; }
.suggestions-list {
  display: none; position: absolute; background-color: #4B5563; border: 1px solid #6B7280; border-radius: 6px;
  width: 100%; max-height: 150px; overflow-y: auto; z-index: 1001;
}
.suggestion-item { padding: 10px; cursor: pointer; }
.suggestion-item:hover { background-color: #3B82F6; }
.selected-actors-box {
  display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 10px; padding: 5px;
  border: 1px solid #4B5563; border-radius: 6px; min-height: 28px;
}
.actor-tag { background-color: #3B82F6; color: #fff; padding: 5px 10px; border-radius: 15px; display: flex; align-items: center; font-size: 14px; }
.remove-tag { margin-left: 8px; cursor: pointer; font-weight: bold; }
</style>

<script>
/* ---- 모달 열기/닫기 ---- */
function openModal(id){
  const modal = document.getElementById(id);
  if(!modal) return;
  const form = modal.querySelector('form');
  if(form){
    form.setAttribute('data-guard','create');
    if(id==='modal-notice') form.action = '/admin/notice/add';
    if(id==='modal-movie')  form.action = '/admin/movie/add';
    if(id==='modal-actor')  form.action = '/admin/actor/add';
    form.querySelectorAll('input:not([type=hidden]), textarea').forEach(el => { el.value=''; });
    const hid = form.querySelector('input[type="hidden"]'); if(hid) hid.value='';
  }
  modal.classList.add('active');
}
function closeModal(id){ const m = document.getElementById(id); if(m) m.classList.remove('active'); }
function confirmDelete(form){ if(confirm('정말 삭제하시겠습니까?')) form.submit(); }

/* ---- 공지 수정 모달 ---- */
function openNoticeEditModal(noticeId, noticeTitle, noticePlot){
  const modal = document.getElementById('modal-notice');
  const form  = modal.querySelector('form');
  form.action = '/admin/notice/update';
  form.setAttribute('data-guard','update');
  form.querySelector('input[name="noticeId"]').value = noticeId;
  form.querySelector('input[name="notice"]').value   = noticeTitle;
  form.querySelector('textarea[name="noticePlot"]').value = noticePlot;
  form.querySelectorAll('[name]').forEach(el=>{ if(el.type!=='file') el.dataset.initial = (el.value||'').trim(); });
  modal.classList.add('active');
}

/* ---- 영화 수정 모달 ---- */
function openMovieEditModal(mId, mTitle, mSubtitle, mPlot, mRelease, mShowtime, mCategories, mDirector, actors, mScreeningType, mMovieTheater, mUrlImage, mUrlMovie){
  const modal = document.getElementById('modal-movie');
  const form  = modal.querySelector('form');
  form.action = '/admin/movie/update';
  form.setAttribute('data-guard','update');

  form.querySelector('input[name="mId"]').value = mId;
  form.querySelector('input[name="mTitle"]').value = mTitle;
  form.querySelector('input[name="mSubtitle"]').value = mSubtitle;
  form.querySelector('textarea[name="mPlot"]').value = mPlot;
  form.querySelector('input[name="mRelease"]').value = mRelease;
  form.querySelector('input[name="mShowtime"]').value = mShowtime;
  form.querySelector('input[name="mCategories"]').value = mCategories;
  form.querySelector('input[name="mDirector"]').value = mDirector;
  form.querySelector('input[name="actors"]').value = actors;
  form.querySelector('input[name="mScreeningType"]').value = mScreeningType;
  form.querySelector('input[name="mMovieTheater"]').value = mMovieTheater;
  form.querySelector('input[name="mUrlImage"]').value = mUrlImage;
  form.querySelector('input[name="mUrlMovie"]').value = mUrlMovie;

  form.querySelectorAll('[name]').forEach(el=>{ if(el.type!=='file') el.dataset.initial = (el.value||'').trim(); });
  modal.classList.add('active');
}
</script>
</head>
<body>
  <div class="container">
    <div class="sidebar">
      <h2><a href="/">Admin</a></h2>
      <a href="/admin/list?section=notice" id="btn-notice" class="${activeSection == 'notice' ? 'active' : ''}">공지사항 관리</a>
      <a href="/admin/list?section=movie"  id="btn-movie"  class="${activeSection == 'movie'  ? 'active' : ''}">영화 관리</a>
      <a href="/admin/list?section=report" id="btn-report" class="${activeSection == 'report' ? 'active' : ''}">신고 리뷰 관리</a>
    </div>

    <div class="main">
      <!-- 공지 -->
      <div id="notice" class="section ${activeSection == 'notice' ? 'active' : ''}">
        <div class="title">공지사항 관리</div>
        <button class="btn-top" onclick="openModal('modal-notice')">공지 등록</button>
        <div class="search-box">
          <form method="get" action="/admin/notice/search">
            <input type="text" name="keyword" placeholder="제목 검색" />
            <button type="submit">🔍</button>
          </form>
        </div>
        <div class="table-box">
          <table>
            <thead>
              <tr><th>번호</th><th>제목</th><th>등록일</th><th>관리</th></tr>
            </thead>
            <tbody>
              <c:if test="${empty noticeList}">
                <tr><td colspan="4" style="text-align:center;">등록된 공지사항이 없습니다.</td></tr>
              </c:if>
              <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <tr>
                  <td>${status.index + 1}</td>
                  <td><c:out value="${notice.notice}" /></td>
                  <td><c:out value="${notice.noticeDate}" /></td>
                  <td>
                    <button
                      onclick="openNoticeEditModal('<c:out value="${notice.noticeId}"/>','<c:out value="${notice.notice}"/>','<c:out value="${notice.noticePlot}"/>')">수정</button>
                    <form method="post" action="/admin/notice/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);" style="display:inline;">
                      <input type="hidden" name="noticeId" value="<c:out value='${notice.noticeId}'/>">
                      <button type="submit">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 영화 -->
      <div id="movie" class="section ${activeSection == 'movie' ? 'active' : ''}">
        <div class="title">영화 관리</div>
        <button class="btn-top" onclick="openModal('modal-movie')">영화 등록</button>
        <div class="search-box">
          <form method="get" action="/admin/movie/search">
            <input type="text" name="keyword" placeholder="제목 검색" />
            <button type="submit">🔍</button>
          </form>
        </div>
        <div class="table-box">
          <table>
            <thead>
              <tr><th>번호</th><th>제목</th><th>부제목</th><th>개봉일</th><th>관리</th></tr>
            </thead>
            <tbody>
              <c:if test="${empty movieList}">
                <tr><td colspan="5" style="text-align:center;">등록된 영화가 없습니다.</td></tr>
              </c:if>
              <c:forEach var="movie" items="${movieList}" varStatus="status">
                <tr>
                  <td>${status.index + 1}</td>
                  <td><c:out value="${movie.mTitle}" /></td>
                  <td><c:out value="${movie.mSubtitle}" /></td>
                  <td><c:out value="${movie.mRelease}" /></td>
                  <td>
                    <%-- 배우 JSON 문자열 안전 생성 --%>
                    <c:set var="actorJsonString">
                      <c:forEach items="${movie.actors}" var="actor" varStatus="loop">
                        {"aId":"<c:out value='${actor.aId}'/>","aName":"<c:out value='${actor.aName}'/>"}<c:if test="${!loop.last}">,</c:if>
                      </c:forEach>
                    </c:set>
                    <c:set var="actorJson" value="[${actorJsonString}]" />

                    <%-- 데이터 속성에 안전하게 바인딩 --%>
                    <button class="edit-movie-btn"
                      data-mid="<c:out value='${movie.mId}'/>"
                      data-mtitle="<c:out value='${movie.mTitle}'/>"
                      data-msubtitle="<c:out value='${movie.mSubtitle}'/>"
                      data-mplot="<c:out value='${movie.mPlot}'/>"
                      data-mrelease="<c:out value='${movie.mRelease}'/>"
                      data-mshowtime="<c:out value='${movie.mShowtime}'/>"
                      data-mcategories="<c:out value='${movie.mCategory}'/>"
                      data-mdirector="<c:out value='${movie.mDirector}'/>"
                      data-mscreeningtype="<c:out value='${movie.mScreeningType}'/>"
                      data-mmovietheater="<c:out value='${movie.mMovieTheater}'/>"
                      data-murlimage="<c:out value='${movie.mUrlImage}'/>"
                      data-murlmovie="<c:out value='${movie.mUrlMovie}'/>"
                      data-actors='<c:out value="${actorJson}" />'>
                      수정
                    </button>

                    <form method="post" action="/admin/movie/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);" style="display:inline;">
                      <input type="hidden" name="mId" value="<c:out value='${movie.mId}'/>">
                      <button type="submit">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 신고 리뷰 -->
      <div id="report" class="section ${activeSection == 'report' ? 'active' : ''}">
        <div class="title">신고 리뷰 관리</div>
        <div style="height: 42px;"></div>
        <div class="search-box">
          <form method="get" action="/admin/review/search">
            <input type="text" name="keyword" placeholder="내용 검색" />
            <button type="submit">🔍</button>
          </form>
        </div>
        <div class="table-box">
          <table>
            <thead>
              <tr><th>내용</th><th>작성자</th><th>신고자</th><th>신고일</th><th>사유</th><th>관리</th></tr>
            </thead>
            <tbody>
              <c:if test="${empty reportList}">
                <tr><td colspan="6" style="text-align:center;">신고된 리뷰가 없습니다.</td></tr>
              </c:if>
              <c:forEach var="reportedReview" items="${reportList}" varStatus="status">
                <tr>
                  <td><c:out value="${reportedReview.review.rPlot}" /></td>
                  <td><c:out value="${reportedReview.review.user.name}" /></td>
                  <td><c:out value="${reportedReview.user.name}" /></td>
                  <td><c:out value="${reportedReview.rrDate}" /></td>
                  <td><c:out value="${reportedReview.rrPlot}" /></td>
                  <td>
                    <form method="post" action="/admin/review/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);">
                      <input type="hidden" name="rrId" value="<c:out value='${reportedReview.review.rId}'/>">
                      <button type="submit">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 공지 모달 -->
      <div class="modal" id="modal-notice">
        <div class="modal-box">
          <h3>공지사항</h3>
          <form method="post" action="/admin/notice/add" data-guard="create">
            <input type="hidden" name="noticeId" value="">
            <input type="text" name="notice" placeholder="제목" required data-label="제목">
            <textarea name="noticePlot" rows="6" placeholder="내용" required data-label="내용"></textarea>
            <div class="button-group">
              <button type="submit">등록</button>
              <button type="button" onclick="closeModal('modal-notice')">취소</button>
            </div>
          </form>
        </div>
      </div>

      <!-- 영화 모달 -->
      <div class="modal" id="modal-movie">
        <div class="modal-box">
          <h3>영화</h3>
          <form method="post" action="/admin/movie/add" data-guard="create">
            <input type="hidden" name="mId" value="">
            <input type="text" name="mTitle" placeholder="제목" required data-label="제목">
            <input type="text" name="mSubtitle" placeholder="소제목" data-label="소제목">
            <textarea name="mPlot" rows="4" placeholder="내용" data-label="내용"></textarea>
            <input type="date" name="mRelease" required data-label="개봉일">
            <input type="text" name="mShowtime" placeholder="상영시간(분)" data-label="상영시간">
            <input type="text" name="mCategories" placeholder="장르" required data-label="장르">
            <input type="text" name="mDirector" placeholder="감독" required data-label="감독">

            <div class="actor-input-container">
              <label style="text-align:left; font-size:14px; margin-bottom:5px; display:block;">배우</label>
              <div id="selected-actors" class="selected-actors-box"></div>
              <input type="text" id="actor-search-input" placeholder="배우 검색 후 추가">
              <input type="hidden" name="actors" id="actors-hidden-input">
              <div id="actor-suggestions" class="suggestions-list"></div>
            </div>

            <input type="text" name="mScreeningType" placeholder="상영 타입" data-label="상영 타입">
            <input type="text" name="mMovieTheater"  placeholder="영화관" data-label="영화관">
            <input type="text" name="mUrlImage" placeholder="사진 URL" data-label="사진 URL">
            <input type="text" name="mUrlMovie" placeholder="영상 URL" data-label="영상 URL">
            <div class="button-group">
              <button type="submit">등록</button>
              <button type="button" onclick="closeModal('modal-movie')">취소</button>
            </div>
          </form>
        </div>
      </div>

      <!-- 배우 모달 -->
      <div class="modal" id="modal-actor">
        <div class="modal-box">
          <h3>배우 등록</h3>
          <form method="post" action="/admin/actor/add" data-guard="create">
            <input type="text" name="aName" placeholder="이름" required data-label="이름">
            <textarea name="aPlot" rows="4" placeholder="소개" required data-label="소개"></textarea>
            <input type="text" name="aUrlImage" placeholder="사진 URL" required data-label="사진 URL">
            <div class="button-group">
              <button type="submit">등록</button>
              <button type="button" onclick="closeModal('modal-actor')">취소</button>
            </div>
          </form>
        </div>
      </div>

      <script>
      (function(){
        document.querySelectorAll('form[data-guard]').forEach(function(form){
          var mode = (form.getAttribute('data-guard') || 'create').toLowerCase();
          form.querySelectorAll('[name]').forEach(function(el){
            if(el.type !== 'file') el.dataset.initial = (el.value || '').trim();
          });
          function labelOf(el){ return el.getAttribute('data-label') || el.name; }
          form.addEventListener('submit', function(e){
            var empties = [];
            var req = form.querySelectorAll('[name][required]');
            req.forEach(function(el){
              var empty = (el.type === 'file') ? !(el.files && el.files.length > 0) : !((el.value || '').trim());
              if(empty) empties.push(labelOf(el));
            });
            if(empties.length){
              e.preventDefault();
              alert(empties.join(', ') + ' 칸이 비어있어서 ' + (mode==='create' ? '등록' : '수정') + '이(가) 안됩니다.');
              var firstEmpty = Array.from(req).find(function(el){ return (el.type === 'file') ? !(el.files && el.files.length > 0) : !((el.value || '').trim()); });
              if(firstEmpty) firstEmpty.focus();
              return;
            }
            if(!form.checkValidity()) return;
            var msg;
            if(mode === 'create'){
              msg = '정말 등록하시겠습니까?';
            }else{
              var changed = [];
              form.querySelectorAll('[name]').forEach(function(el){
                if(el.type === 'file'){
                  if(el.files && el.files.length > 0) changed.push(labelOf(el));
                }else{
                  var now = (el.value || '').trim();
                  var ini = el.dataset.initial || '';
                  if(now !== ini) changed.push(labelOf(el));
                }
              });
              msg = changed.length ? ('다음 항목이 변경됩니다:\n  - ' + changed.join('\n  - ') + '\n\n정말 수정하시겠습니까?') : '변경된 내용이 없습니다.\n그래도 수정하시겠습니까?';
            }
            if(!confirm(msg)) e.preventDefault();
          });
        });
      })();

      // 수정 버튼 이벤트 위임
      document.addEventListener('DOMContentLoaded', () => {
        const movieTable = document.querySelector('#movie .table-box');
        if (movieTable) {
          movieTable.addEventListener('click', function(e) {
            if (e.target && e.target.classList.contains('edit-movie-btn')) {
              const btn = e.target;
              const d = btn.dataset;
              openMovieEditModal(
                d.mid, d.mtitle, d.msubtitle, d.mplot,
                d.mrelease, d.mshowtime, d.mcategories,
                d.mdirector, d.actors, d.mscreeningtype,
                d.mmovietheater, d.murlimage, d.murlmovie
              );
            }
          });
        }
      });

      // 배우 자동완성
      const actorSearchInput = document.getElementById('actor-search-input');
      const suggestionsBox   = document.getElementById('actor-suggestions');
      let debounceTimer;

      actorSearchInput.addEventListener('input', () => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
          const query = actorSearchInput.value.trim();
          if (query.length < 1) {
            suggestionsBox.innerHTML = '';
            suggestionsBox.style.display = 'none';
            return;
          }
          fetch('/api/actors/search?name=' + encodeURIComponent(query))
            .then(response => response.json())
            .then(actors => {
              suggestionsBox.innerHTML = '';
              if (actors.length > 0) {
                actors.forEach(actor => {
                  const item = document.createElement('div');
                  item.textContent = actor.aName;
                  item.classList.add('suggestion-item');
                  item.addEventListener('click', () => addActor(actor));
                  suggestionsBox.appendChild(item);
                });
                suggestionsBox.style.display = 'block';
              } else {
                suggestionsBox.style.display = 'none';
              }
            });
        }, 300);
      });

      function addActor(actor) {
        const box  = document.getElementById('selected-actors');
        const hid  = document.getElementById('actors-hidden-input');
        const ids  = (hid.value || '').split(',').filter(Boolean);
        if (ids.includes(actor.aId)) {
          alert('이미 추가된 배우입니다.');
          actorSearchInput.value = '';
          suggestionsBox.style.display = 'none';
          return;
        }
        const tag = document.createElement('span');
        tag.classList.add('actor-tag');
        tag.textContent = actor.aName;
        tag.dataset.actorId = actor.aId;

        const x = document.createElement('span');
        x.textContent = 'x';
        x.classList.add('remove-tag');
        x.onclick = () => removeActor(actor.aId);
        tag.appendChild(x);

        box.appendChild(tag);
        ids.push(actor.aId);
        hid.value = ids.join(',');

        actorSearchInput.value = '';
        suggestionsBox.style.display = 'none';
      }

      function removeActor(actorId) {
        const box  = document.getElementById('selected-actors');
        const hid  = document.getElementById('actors-hidden-input');
        const tag  = box.querySelector('[data-actor-id="'+actorId+'"]');
        if(tag) tag.remove();
        const ids = (hid.value || '').split(',').filter(Boolean).filter(id => id !== actorId);
        hid.value = ids.join(',');
      }

      document.addEventListener('click', function(e) {
        if (!e.target.closest('.actor-input-container')) {
          suggestionsBox.style.display = 'none';
        }
      });
      </script>
    </div>
  </div>
</body>
</html>
