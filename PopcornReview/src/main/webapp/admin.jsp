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
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin</title>
<link rel="stylesheet" href="css/common.css" />
<style>
/* ====== 기존 스타일 유지 ====== */
body { background-color:#121619; font-family:'Noto Sans KR',sans-serif; margin:0; }
.container { display:flex; height:100vh; }
.sidebar { width:200px; background-color:#1F2937; display:flex; flex-direction:column; align-items:center; padding:30px 10px; flex-shrink:0; }
.sidebar h2 { color:#fff; font-size:24px; margin-bottom:40px; font-weight:bold; }
.sidebar button { background-color:#1F2937; color:#fff; font-size:15px; margin-bottom:15px; border:none; text-align:left; padding:12px 20px; width:100%; border-radius:8px; cursor:pointer; }
.sidebar button.active,.sidebar button:hover { background-color:#3B82F6; }
.main { flex:1; padding:40px; color:#fff; overflow-y:auto; }
.section { display:none; }
.section.active { display:block; }
.title { font-size:22px; margin-bottom:25px; font-weight:bold; }
.btn-top { background-color:#3B82F6; color:#fff; padding:10px 24px; margin-bottom:20px; border-radius:8px; border:none; font-weight:bold; cursor:pointer; }
.search-box { display:flex; justify-content:center; margin-bottom:20px; }
.search-box form { display:flex; align-items:center; width:60%; max-width:600px; }
.search-box input[type="text"] { flex:1; padding:10px 14px; border-radius:6px; border:none; background-color:#4B5563; color:#fff; font-size:14px; }
.search-box button { padding:10px 16px; border:none; border-radius:6px; background-color:#3B82F6; color:#fff; margin-left:8px; cursor:pointer; }
.table-box { background-color:#1F2937; border-radius:10px; padding:10px; }
.table-box table { width:100%; border-collapse:collapse; }
.table-box th,.table-box td { padding:8px; text-align:center; font-size:14px; }
.table-box tr:nth-child(even) { background-color:#1F2937; }
.table-box button { padding:6px 10px; background-color:#374151; color:#fff; border:none; border-radius:4px; cursor:pointer; }
.pagination { margin-top:20px; text-align:center; }
.pagination a { color:#fff; background-color:#374151; padding:6px 12px; margin:0 4px; text-decoration:none; border-radius:4px; }
.pagination a.active { background-color:#3B82F6; }

/* 모달 */
.modal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,.6); justify-content:center; align-items:center; z-index:1000; }
.modal.active { display:flex; }
.modal-box { background:#374151; padding:30px; border-radius:10px; width:600px; box-sizing:border-box; }
.modal-box form { display:flex; flex-direction:column; gap:15px; }
.modal-box input,.modal-box textarea { width:100%; padding:10px; border:none; border-radius:6px; background:#4B5563; color:#fff; box-sizing:border-box; }
.modal-box textarea { resize:vertical; }
.modal-box h3 { font-size:18px; margin-bottom:10px; text-align:left; }
.button-group { display:flex; justify-content:flex-end; gap:10px; }
.button-group button { padding:10px 20px; border:none; border-radius:6px; background:#1F2937; color:#fff; cursor:pointer; }

/* 인물 자동완성 */
.autocomplete-list { display:block!important; position:absolute; top:100%; left:0; width:100%; background:#374151; border:1px solid #ccc; z-index:10; list-style:none; padding:0; margin:2px 0 0 0; max-height:120px; overflow-y:auto; }
.autocomplete-list li { padding:8px; cursor:pointer; }
.autocomplete-list li:hover { background-color:#eee; }
.info-text { font-size:13px; color:#f87171; margin-top:5px; }
.modal-box input,.modal-box textarea { border:none!important; }
.actor-tag { display:inline-block; background:#4b5563; color:#fff; padding:5px 10px; margin:3px; border-radius:4px; font-size:14px; }
.input-with-button { display:flex; align-items:center; }
.input-with-button input[type="text"] { flex:1; border:none!important; }
.input-with-button button { margin-left:5px; padding:6px 10px; font-size:13px; }
</style>

<!--
[컨트롤러 매핑 가이드 — Spring MVC 예시]

공지사항
- 목록 진입:        GET /admin/notice
- 검색:           GET /admin/notice/search?keyword=...
- 등록(아래 create 모달):   POST /admin/notice/add
- 수정(아래 update 모드):   POST /admin/notice/update   (파라미터: nid, title, content)
- 삭제:           POST /admin/notice/delete          (파라미터: nid)

영화
- 목록 진입:        GET /admin/movie
- 검색:           GET /admin/movie/search?keyword=...
- 등록:           POST /admin/movie/add
  파라미터(name): title, subtitle, description, release(yyyy-MM-dd),
                 duration, genre, director, actors, type, cinema, posterUrl, videoUrl
- 수정:           POST /admin/movie/update           (파라미터: mid + 위와 동일)
- 삭제:           POST /admin/movie/delete           (파라미터: mid)

배우
- 등록:           POST /admin/actor/add              (파라미터: a_name, a_plot, a_url_image)

※ 아래 스크립트의 "폼 가드"는 data-guard="create|update" 로 모드를 구분합니다.
   - create: required 비어있으면 "~~ 칸이 비어있어서 등록이 안됩니다." → 제출 전 "정말 등록하시겠습니까?"
   - update: 빈칸 검사 + 변경 항목 나열 → "정말 수정하시겠습니까?"
-->

<script>
/* ---- 데이터 (데모용) ---- */
const directors = ["봉준호", "박찬욱", "임권택", "김지운"];
const actors    = ["송강호", "이병헌", "전도연", "김혜수", "최민식"];

/* ---- 섹션/모달 토글 ---- */
function showSection(id){
  document.querySelectorAll('.section').forEach(s=>s.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  document.querySelectorAll('.sidebar button').forEach(btn=>btn.classList.remove('active'));
  document.getElementById('btn-' + id).classList.add('active');
}

function openModal(id){
  const modal = document.getElementById(id);
  if(!modal) return;

  // 기본은 "등록(create)" 모드로 세팅
  const form = modal.querySelector('form');
  if(form){
    form.setAttribute('data-guard','create'); // create
    // 모달별 기본 action 보정
    if(id==='modal-notice') form.action = '/admin/notice/add';
    if(id==='modal-movie')  form.action = '/admin/movie/add';
    // create 시 입력값 초기화
    form.querySelectorAll('input[type="text"], input[type="date"], textarea, input[type="number"]').forEach(el=>{ el.value=''; });
    const hid = form.querySelector('input[type="hidden"]'); if(hid) hid.value='';
  }

  modal.classList.add('active');
}

function closeModal(id){
  const m = document.getElementById(id);
  if(m) m.classList.remove('active');
}

function confirmDelete(form){
  if(confirm('정말 삭제하시겠습니까?')) form.submit();
}

/* ---- 수정 모달 오픈(데이터 바인딩 + update 모드 전환) ---- */
function openNoticeEditModal(nid, title, content){
  const modal = document.getElementById('modal-notice');
  const form  = modal.querySelector('form');
  form.action = '/admin/notice/update';
  form.setAttribute('data-guard','update');

  form.querySelector('input[name="nid"]').value = nid;
  form.querySelector('input[name="title"]').value = title;
  form.querySelector('textarea[name="content"]').value = content;

  // update 비교용 초기값 저장
  form.querySelectorAll('[name]').forEach(el=>{
    if(el.type!=='file') el.dataset.initial = (el.value||'').trim();
  });

  modal.classList.add('active');
}

function openMovieEditModal(mid, title, subtitle){
  const modal = document.getElementById('modal-movie');
  const form  = modal.querySelector('form');
  form.action = '/admin/movie/update';
  form.setAttribute('data-guard','update');

  form.querySelector('input[name="mid"]').value = mid;
  form.querySelector('input[name="title"]').value = title;
  form.querySelector('input[name="subtitle"]').value = subtitle;

  // update 비교용 초기값 저장
  form.querySelectorAll('[name]').forEach(el=>{
    if(el.type!=='file') el.dataset.initial = (el.value||'').trim();
  });

  modal.classList.add('active');
}

/* ---- 자동완성 ---- */
function setupAutocomplete(inputId, listId, data, infoId){
  const input = document.getElementById(inputId);
  const list  = document.getElementById(listId);
  const info  = document.getElementById(infoId);
  if(!input) return;

  input.addEventListener("input", ()=>{
    const values = input.value.split(',').map(s=>s.trim());
    const last   = values[values.length-1].toLowerCase();
    list.innerHTML=""; info.textContent="";
    if(last.length===0) return;

    const filtered = data.filter(n=>n.toLowerCase().includes(last));
    if(filtered.length===0) info.textContent="⚠ 존재하지 않는 인물: " + last;

    filtered.forEach(name=>{
      const li=document.createElement("li");
      li.textContent=name;
      li.onclick=()=>{
        values[values.length-1]=name;
        input.value = values.join(', ') + ', ';
        list.innerHTML=""; info.textContent="";
      };
      list.appendChild(li);
    });
  });
  input.addEventListener("blur", ()=> setTimeout(()=> list.innerHTML="",150));
}

/* ---- 페이지 로드시 ---- */
window.onload = ()=>{
  setupAutocomplete("directorInput","directorSuggestions",directors,"directorInput-info");
  setupAutocomplete("actorInput","actorSuggestions",actors,"actorInput-info");
};
</script>
</head>
<body>
  <div class="container">
    <div class="sidebar">
      <h2>Admin</h2>
      <button id="btn-notice" class="active" onclick="showSection('notice')">공지사항 관리</button>
      <button id="btn-movie" onclick="showSection('movie')">영화 관리</button>
      <button id="btn-report" onclick="showSection('report')">신고 리뷰 관리</button>
    </div>

    <div class="main">
      <!-- 공지사항 -->
      <div id="notice" class="section active">
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
              <c:forEach var="i" begin="1" end="10">
                <tr>
                  <td>${i}</td>
                  <td>공지 제목 ${i}</td>
                  <td>2025-08-05</td>
                  <td>
                    <!-- 수정: id를 함께 전달 -->
                    <button onclick="openNoticeEditModal(${i}, '공지 제목 ${i}', '내용 ${i}')">수정</button>
                    <form method="post" action="/admin/notice/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);" style="display:inline;">
                      <input type="hidden" name="nid" value="${i}">
                      <button type="submit">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

      <!-- 영화 관리 -->
      <div id="movie" class="section">
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
              <tr><th>번호</th><th>제목</th><th>감독</th><th>등록일</th><th>관리</th></tr>
            </thead>
            <tbody>
              <c:forEach var="i" begin="1" end="10">
                <tr>
                  <td>${i}</td>
                  <td>영화 제목 ${i}</td>
                  <td>감독 ${i}</td>
                  <td>2025-08-05</td>
                  <td>
                    <!-- 수정: id와 대표 필드 함께 전달 -->
                    <button onclick="openMovieEditModal(${i}, '영화 제목 ${i}', '소제목 ${i}')">수정</button>
                    <form method="post" action="/admin/movie/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);" style="display:inline;">
                      <input type="hidden" name="mid" value="${i}">
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
      <div id="report" class="section">
        <div class="title">신고 리뷰 관리</div>
        <div style="height:42px;"></div>
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
              <c:forEach var="i" begin="1" end="10">
                <tr>
                  <td>리뷰 내용 ${i}</td>
                  <td>작성자 ${i}</td>
                  <td>신고자 ${i}</td>
                  <td>2025-08-05</td>
                  <td>욕설</td>
                  <td>
                    <form method="post" action="/admin/review/delete"
                          onsubmit="event.preventDefault(); confirmDelete(this);">
                      <input type="hidden" name="rid" value="${i}">
                      <button type="submit">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- 공지사항 모달 (등록/수정 겸용) -->
  <div class="modal" id="modal-notice">
    <div class="modal-box">
      <form method="post" action="/admin/notice/add" data-guard="create">
        <h3>공지사항</h3>
        <input type="hidden" name="nid" value="">
        <input type="text" name="title"   placeholder="제목"   required data-label="제목">
        <textarea      name="content" rows="6" placeholder="내용" required data-label="내용"></textarea>
        <div class="button-group">
          <button type="submit">등록</button>
          <button type="button" onclick="closeModal('modal-notice')">취소</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 영화 모달 (등록/수정 겸용) -->
  <div class="modal" id="modal-movie">
    <div class="modal-box">
      <h3>영화</h3>
      <form method="post" action="/admin/movie/add" data-guard="create">
        <input type="hidden" name="mid" value="">
        <input type="text" name="title"     placeholder="제목"      required data-label="제목">
        <input type="text" name="subtitle"  placeholder="소제목"    data-label="소제목">
        <textarea name="description" rows="4" placeholder="내용"    data-label="내용"></textarea>
        <input type="date" name="release"   required data-label="개봉일">
        <input type="text" name="duration"  placeholder="상영시간(분)" required data-label="상영시간">
        <input type="text" name="genre"     placeholder="장르"     required data-label="장르">

        <!-- 감독 자동완성 -->
        <div style="position:relative;">
          <input type="text" name="director" id="directorInput" placeholder="감독" autocomplete="off" required data-label="감독">
          <ul id="directorSuggestions" class="autocomplete-list"></ul>
          <div id="directorInput-info" class="info-text"></div>
        </div>

        <!-- 배우 자동완성 -->
        <div style="position:relative;">
          <div class="input-with-button">
            <input type="text" name="actors" id="actorInput" placeholder="배우 이름 입력 (쉼표로 구분)" autocomplete="off" data-label="배우">
            <button type="button" onclick="openModal('modal-actor')">추가</button>
          </div>
          <ul id="actorSuggestions" class="autocomplete-list"></ul>
          <div id="actorInput-info" class="info-text"></div>
        </div>

        <input type="text" name="type"      placeholder="상영 타입" data-label="상영 타입">
        <input type="text" name="cinema"    placeholder="영화관"   data-label="영화관">
        <input type="text" name="posterUrl" placeholder="사진 URL" data-label="사진 URL">
        <input type="text" name="videoUrl"  placeholder="영상 URL" data-label="영상 URL">
        <div class="button-group">
          <button type="submit">등록</button>
          <button type="button" onclick="closeModal('modal-movie')">취소</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 배우 등록 모달 (등록만) -->
  <div class="modal" id="modal-actor">
    <div class="modal-box">
      <h3>배우 등록</h3>
      <form method="post" action="/admin/actor/add" data-guard="create">
        <input type="text" name="a_name"      placeholder="이름"     required data-label="이름">
        <textarea name="a_plot" rows="4"      placeholder="소개"     required data-label="소개"></textarea>
        <input type="text" name="a_url_image" placeholder="사진 URL" required data-label="사진 URL">
        <div class="button-group">
          <button type="submit">등록</button>
          <button type="button" onclick="closeModal('modal-actor')">취소</button>
        </div>
      </form>
    </div>
  </div>

  <!-- ===== 공통 스크립트: 폼 가드 (빈칸 차단 + 등록/수정 확인) ===== -->
  <script>
  (function(){
    document.querySelectorAll('form[data-guard]').forEach(function(form){
      var mode = (form.getAttribute('data-guard') || 'create').toLowerCase(); // create|update

      // 최초 기준값 저장(수정 비교용)
      form.querySelectorAll('[name]').forEach(function(el){
        if(el.type !== 'file') el.dataset.initial = (el.value || '').trim();
      });

      function labelOf(el){
        return el.getAttribute('data-label') || el.name;
      }

      form.addEventListener('submit', function(e){
        /* 1) 비어있는 required 검사 */
        var empties = [];
        var req = form.querySelectorAll('[name][required]');
        req.forEach(function(el){
          var empty = (el.type === 'file')
                        ? !(el.files && el.files.length > 0)
                        : !((el.value || '').trim());
          if(empty) empties.push(labelOf(el));
        });
        if(empties.length){
          e.preventDefault();
          alert(empties.join(', ') + ' 칸이 비어있어서 ' + (mode==='create' ? '등록' : '수정') + '이(가) 안됩니다.');
          var firstEmpty = Array.from(req).find(function(el){
            return (el.type === 'file') ? !(el.files && el.files.length > 0) : !((el.value || '').trim());
          });
          if(firstEmpty) firstEmpty.focus();
          return;
        }

        /* 2) 브라우저 기본 유효성(형식) */
        if(!form.checkValidity()) return;

        /* 3) 확인 프롬프트 */
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
          msg = changed.length
            ? ('다음 항목이 변경됩니다:\n  - ' + changed.join('\n  - ') + '\n\n정말 수정하시겠습니까?')
            : '변경된 내용이 없습니다.\n그래도 수정하시겠습니까?';
        }
        if(!confirm(msg)) e.preventDefault();
      });
    });
  })();
  </script>
</body>
</html>
