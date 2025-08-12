<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- JSTL 변수 설정: URL 파라미터가 없으면 'notice'를 기본 섹션으로 사용 --%>
<c:set var="activeSection" value="${empty param.section ? 'notice' : param.section}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Admin Dashboard</title>
<link rel="stylesheet" href="<c:url value='/css/common.css'/>">
<style>
    /* General Styles */
    body { background-color: #121619; font-family: 'Noto Sans KR', sans-serif; margin: 0; color: #E5E7EB; }
    .container { display: flex; height: 100vh; }

    /* Sidebar */
    .sidebar { width: 220px; background-color: #1F2937; display: flex; flex-direction: column; align-items: center; padding: 30px 10px; flex-shrink: 0; }
    .sidebar h2 { margin-bottom: 40px; }
    .sidebar h2 a { color: #FFF; font-size: 24px; font-weight: bold; text-decoration: none; }
    .sidebar .nav-btn { background-color: transparent; color: #D1D5DB; font-size: 16px; margin-bottom: 10px; border: none; text-align: left; padding: 12px 20px; width: 100%; border-radius: 8px; cursor: pointer; text-decoration: none; box-sizing: border-box; display: block; transition: background-color 0.2s, color 0.2s; }
    .sidebar .nav-btn.active, .sidebar .nav-btn:hover { background-color: #3B82F6; color: #FFF; }

    /* Main Content */
    .main { flex: 1; padding: 40px; overflow-y: auto; }
    .section { display: none; }
    .section.active { display: block; animation: fadeIn 0.5s; }
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }

    .title { font-size: 28px; margin-bottom: 25px; font-weight: bold; color: #FFF; }
    .controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    
    /* Buttons */
    .btn { padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 14px; }
    .btn-primary { background-color: #3B82F6; color: #fff; }
    .btn-danger { background-color: #EF4444; color: #fff; }
    .btn-secondary { background-color: #6B7280; color: #fff; }

    /* Search Box */
    .search-box { display: flex; width: 100%; max-width: 500px; }
    .search-box input[type="text"] { flex: 1; padding: 10px 14px; border-radius: 6px 0 0 6px; border: 1px solid #4B5563; background-color: #374151; color: #fff; font-size: 14px; }
    .search-box input[type="text"]:focus { outline: none; border-color: #3B82F6; }
    .search-box button { padding: 10px 16px; border: none; border-radius: 0 6px 6px 0; background-color: #3B82F6; color: #fff; cursor: pointer; }
    
    /* Table */
    .table-box { background-color: #1F2937; border-radius: 10px; padding: 10px; overflow-x: auto; }
    .table-box table { width: 100%; border-collapse: collapse; }
    .table-box th, .table-box td { padding: 12px 15px; text-align: center; font-size: 14px; border-bottom: 1px solid #374151; }
    .table-box th { color: #9CA3AF; }
    .table-box td { color: #E5E7EB; }
    .table-box tr:last-child td { border-bottom: none; }
    .table-box .btn { padding: 6px 12px; font-size: 13px; margin: 0 4px; }

    /* Modal */
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.7); justify-content: center; align-items: center; z-index: 1000; }
    .modal.active { display: flex; }
    .modal-box { background: #374151; padding: 30px; border-radius: 10px; width: 90%; max-width: 650px; box-shadow: 0 10px 25px rgba(0,0,0,0.3); }
    .modal-box h3 { font-size: 20px; margin-top: 0; margin-bottom: 20px; text-align: left; color: #FFF; }
    .modal-form { display: flex; flex-direction: column; gap: 16px; }
    .modal-form label { font-size: 14px; font-weight: 500; margin-bottom: -10px; text-align: left; }
    .modal-form input, .modal-form textarea { width: 100%; padding: 12px; border: 1px solid #6B7280; border-radius: 6px; background: #4B5563; color: #fff; box-sizing: border-box; }
    .modal-form input:focus, .modal-form textarea:focus { outline: none; border-color: #3B82F6; }
    .modal-form .button-group { display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px; }
    
    /* Actor/Director Autocomplete Styles */
    .autocomplete-container { position: relative; }
    .suggestions-list { display: none; position: absolute; background-color: #4B5563; border: 1px solid #6B7280; border-radius: 6px; width: 100%; max-height: 180px; overflow-y: auto; z-index: 1001; }
    .suggestion-item { padding: 10px; cursor: pointer; border-bottom: 1px solid #6B7280; }
    .suggestion-item:last-child { border-bottom: none; }
    .suggestion-item:hover { background-color: #3B82F6; }
    
    .selected-actors-box { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 8px; padding: 8px; border: 1px solid #4B5563; border-radius: 6px; min-height: 40px; }
    .actor-tag { background-color: #3B82F6; color: #fff; padding: 5px 12px; border-radius: 15px; display: flex; align-items: center; font-size: 14px; }
    .remove-tag { margin-left: 8px; cursor: pointer; font-weight: bold; }
</style>
</head>
<body>
  <div class="container">
    <%-- Sidebar --%>
    <div class="sidebar">
      <h2><a href="<c:url value='/'/>">Admin</a></h2>
      <a href="?section=notice" class="nav-btn ${activeSection == 'notice' ? 'active' : ''}">공지사항 관리</a>
      <a href="?section=movie" class="nav-btn ${activeSection == 'movie' ? 'active' : ''}">영화 관리</a>
      <a href="?section=report" class="nav-btn ${activeSection == 'report' ? 'active' : ''}">신고 리뷰 관리</a>
    </div>

    <div class="main">
      <%-- Notice Section --%>
      <div id="notice-section" class="section ${activeSection == 'notice' ? 'active' : ''}">
        <div class="controls">
          <div class="title">공지사항 관리</div>
          <button class="btn btn-primary" onclick="App.openModal('notice-modal', true)">공지 등록</button>
        </div>
        <div class="search-box">
          <form method="get" action="<c:url value='/admin/notice/search'/>">
            <input type="hidden" name="section" value="notice" />
            <input type="text" name="keyword" placeholder="제목으로 검색..." value="${param.keyword}"/>
            <button type="submit">🔍</button>
          </form>
        </div>
        <div class="table-box" style="margin-top:20px;">
          <table>
            <thead><tr><th>번호</th><th>제목</th><th>등록일</th><th style="width: 150px;">관리</th></tr></thead>
            <tbody>
              <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <tr>
                  <td>${status.count}</td>
                  <td style="text-align: left;"><c:out value="${notice.notice}" /></td>
                  <td><c:out value="${notice.noticeDate}" /></td>
                  <td>
                    <button class="btn btn-secondary" onclick="App.openNoticeEditModal(this)"
                            data-id="${notice.noticeId}" 
                            data-title="${notice.notice}" 
                            data-plot="${notice.noticePlot}">수정</button>
                    <form method="post" action="<c:url value='/admin/notice/delete'/>" onsubmit="return App.confirmDelete(event)" style="display: inline;">
                      <input type="hidden" name="noticeId" value="${notice.noticeId}" />
                      <button type="submit" class="btn btn-danger">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty noticeList}"><tr><td colspan="4">등록된 공지사항이 없습니다.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </div>

      <%-- Movie Section --%>
      <div id="movie-section" class="section ${activeSection == 'movie' ? 'active' : ''}">
        <div class="controls">
          <div class="title">영화 관리</div>
          <button class="btn btn-primary" onclick="App.openModal('movie-modal', true)">영화 등록</button>
        </div>
        <div class="search-box">
          <form method="get" action="<c:url value='/admin/movie/search'/>">
            <input type="hidden" name="section" value="movie" />
            <input type="text" name="keyword" placeholder="제목으로 검색..." value="${param.keyword}"/>
            <button type="submit">🔍</button>
          </form>
        </div>
        <div class="table-box" style="margin-top:20px;">
          <table>
            <thead><tr><th>번호</th><th>제목</th><th>부제목</th><th>개봉일</th><th style="width: 150px;">관리</th></tr></thead>
            <tbody>
              <%-- JSON 데이터 블록으로 배우 정보를 저장 (JS에서 사용) --%>
              <c:forEach var="movie" items="${movieList}" varStatus="status">
                <script type="application/json" id="actors-json-${movie.mId}">
                  [<c:forEach items="${movie.actors}" var="actor" varStatus="loop">{"aId":"${actor.aId}","aName":"${actor.aName}"}<c:if test="${!loop.last}">,</c:if></c:forEach>]
                </script>
                <tr>
                  <td>${status.count}</td>
                  <td style="text-align: left;"><c:out value="${movie.mTitle}" /></td>
                  <td style="text-align: left;"><c:out value="${movie.mSubtitle}" /></td>
                  <td><c:out value="${movie.mRelease}" /></td>
                  <td>
                    <button class="btn btn-secondary edit-movie-btn"
                            data-mid="${movie.mId}"
                            data-mtitle="${movie.mTitle}"
                            data-msubtitle="${movie.mSubtitle}"
                            data-mplot="${movie.mPlot}"
                            data-mrelease="${movie.mRelease}"
                            data-mshowtime="${movie.mShowtime}"
                            data-mcategory="${movie.mCategory}"
                            data-mscreeningtype="${movie.mScreeningType}"
                            data-mmovietheater="${movie.mMovieTheater}"
                            data-murlimage="${movie.mUrlImage}"
                            data-murlmovie="${movie.mUrlMovie}"
                            data-actors-id="actors-json-${movie.mId}">수정</button>
                    <form method="post" action="<c:url value='/admin/movie/delete'/>" onsubmit="return App.confirmDelete(event)" style="display: inline;">
                      <input type="hidden" name="mId" value="${movie.mId}" />
                      <button type="submit" class="btn btn-danger">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty movieList}"><tr><td colspan="5">등록된 영화가 없습니다.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </div>
      
      <%-- Report Section --%>
      <div id="report-section" class="section ${activeSection == 'report' ? 'active' : ''}">
        <div class="title">신고 리뷰 관리</div>
        <div class="table-box">
          <table>
            <thead><tr><th>내용</th><th>작성자</th><th>신고자</th><th>신고일</th><th>사유</th><th>관리</th></tr></thead>
            <tbody>
              <c:forEach var="report" items="${reportList}">
                <tr>
                  <td style="text-align: left;"><c:out value="${report.review.rPlot}" /></td>
                  <td><c:out value="${report.review.user.name}" /></td>
                  <td><c:out value="${report.user.name}" /></td>
                  <td><c:out value="${report.rrDate}" /></td>
                  <td><c:out value="${report.rrPlot}" /></td>
                  <td>
                    <form method="post" action="<c:url value='/admin/review/delete'/>" onsubmit="return App.confirmDelete(event)" style="display: inline;">
                      <input type="hidden" name="rrId" value="${report.rrId}" />
                      <button type="submit" class="btn btn-danger">삭제</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty reportList}"><tr><td colspan="6">신고된 리뷰가 없습니다.</td></tr></c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <%-- Notice Modal --%>
  <div class="modal" id="notice-modal">
    <div class="modal-box">
      <h3>공지사항 등록/수정</h3>
      <form class="modal-form" method="post" action="">
        <input type="hidden" name="noticeId">
        <input type="text" name="notice" placeholder="제목" required>
        <textarea name="noticePlot" rows="8" placeholder="내용" required></textarea>
        <div class="button-group">
          <button type="submit" class="btn btn-primary">저장</button>
          <button type="button" class="btn btn-secondary" onclick="App.closeModal('notice-modal')">취소</button>
        </div>
      </form>
    </div>
  </div>

  <%-- Movie Modal --%>
  <div class="modal" id="movie-modal">
    <div class="modal-box">
      <h3>영화 등록/수정</h3>
      <form class="modal-form" method="post" action="" id="movie-form">
        <input type="hidden" name="mId">
        <input type="text" name="mTitle" placeholder="제목" required>
        <input type="text" name="mSubtitle" placeholder="부제목">
        <textarea name="mPlot" rows="4" placeholder="줄거리"></textarea>
        <input type="date" name="mRelease" required>
        <input type="text" name="mShowtime" placeholder="상영시간 (분)">
        <input type="text" name="mCategory" placeholder="장르" required>
        
        <%-- 감독 입력 필드 삭제 --%>
        
        <div class="autocomplete-container">
          <label>인물</label>
          <div id="selected-actors-box" class="selected-actors-box"></div>
          <input type="text" id="actor-search-input" placeholder=" 이름 검색 후 추가">
          <div id="actor-suggestions" class="suggestions-list"></div>
        </div>
        
        <input type="text" name="mScreeningType" placeholder="상영 타입 (2D, 3D, IMAX 등)">
        <input type="text" name="mMovieTheater" placeholder="주요 상영관">
        <input type="text" name="mUrlImage" placeholder="포스터 이미지 URL">
        <input type="text" name="mUrlMovie" placeholder="예고편 영상 URL">
        
        <div class="button-group">
          <button type="submit" class="btn btn-primary">저장</button>
          <button type="button" class="btn btn-secondary" onclick="App.closeModal('movie-modal')">취소</button>
        </div>
      </form>
    </div>
  </div>

<script>
const App = (() => {
    // 영화 수정 모달의 배우 목록을 관리하는 상태 변수
    let selectedActors = new Map();

    // --- DOM Elements ---
    const getElement = (id) => document.getElementById(id);
    const movieForm = getElement('movie-form');
    const noticeModal = getElement('notice-modal');
    const movieModal = getElement('movie-modal');
    
    // --- Utility Functions ---
    const debounce = (func, delay = 300) => {
        let timeout;
        return (...args) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), delay);
        };
    };

     const fetchSuggestions = async (query, suggestionsBox, onSelect) => {
         if (!query.trim()) {
             suggestionsBox.style.display = 'none';
             return;
         }
         try {
             const url = `<c:url value='/api/actors/search'/>?name=` + encodeURIComponent(query);
             
             const response = await fetch(url);
             if (!response.ok) throw new Error('Server response was not ok.');
             const data = await response.json();

             suggestionsBox.innerHTML = '';
             if (data && data.length > 0) {
                 data.forEach(actor => {
                     const item = document.createElement('div');
                     item.className = 'suggestion-item';
                     item.textContent = actor.aName;
                     item.onclick = () => {
                         onSelect(actor);
                         suggestionsBox.style.display = 'none';
                     };
                     suggestionsBox.appendChild(item);
                 });
                 suggestionsBox.style.display = 'block';
             } else {
                 suggestionsBox.style.display = 'none';
             }
         } catch (error) {
             console.error('Failed to fetch suggestions:', error);
             suggestionsBox.style.display = 'none';
         }
     };

    // --- Actor Management ---
    const manageActorList = (action, actor) => {
        if (action === 'add') {
            selectedActors.set(actor.aId, actor.aName);
        } else if (action === 'remove') {
            selectedActors.delete(actor.aId);
        }
        renderSelectedActors();
    };

    const renderSelectedActors = () => {
        const container = getElement('selected-actors-box');
        container.innerHTML = '';
        selectedActors.forEach((name, id) => {
            const tag = document.createElement('span');
            tag.className = 'actor-tag';
            tag.textContent = name;
            
            const removeBtn = document.createElement('span');
            removeBtn.className = 'remove-tag';
            removeBtn.textContent = 'x';
            removeBtn.onclick = () => manageActorList('remove', { aId: id, aName: name });
            
            tag.appendChild(removeBtn);
            container.appendChild(tag);
        });
    };

    const prepareActorsForSubmission = (form) => {
        form.querySelectorAll('input[name="actors"]').forEach(input => input.remove());
        selectedActors.forEach((name, id) => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'actors';
            input.value = id;
            form.appendChild(input);
        });
    };

    // --- Modal Handling ---
    const openModal = (modalId, isCreate) => {
        const modal = getElement(modalId);
        if (!modal) return;

        const form = modal.querySelector('form');
        form.reset();

        if (modalId === 'movie-modal') {
            selectedActors.clear();
            renderSelectedActors();
            // 감독 관련 필드 초기화 코드 삭제
            form.action = isCreate ? "<c:url value='/admin/movie/add'/>" : "<c:url value='/admin/movie/update'/>";
        } else if (modalId === 'notice-modal') {
             form.action = isCreate ? "<c:url value='/admin/notice/add'/>" : "<c:url value='/admin/notice/update'/>";
        }
        
        modal.classList.add('active');
    };
    
    const closeModal = (modalId) => {
        getElement(modalId)?.classList.remove('active');
    };

    const openNoticeEditModal = (button) => {
        openModal('notice-modal', false);
        const form = noticeModal.querySelector('form');
        const data = button.dataset;
        form.querySelector('[name="noticeId"]').value = data.id;
        form.querySelector('[name="notice"]').value = data.title;
        form.querySelector('[name="noticePlot"]').value = data.plot;
    };
    
    const populateMovieEditModal = (button) => {
        openModal('movie-modal', false);
        const form = movieModal.querySelector('form');
        const data = button.dataset;
        
        // 필드 값 채우기
        form.querySelector('[name="mId"]').value = data.mid;
        form.querySelector('[name="mTitle"]').value = data.mtitle;
        form.querySelector('[name="mSubtitle"]').value = data.msubtitle;
        form.querySelector('[name="mPlot"]').value = data.mplot;
        form.querySelector('[name="mRelease"]').value = data.mrelease.split(' ')[0];
        form.querySelector('[name="mShowtime"]').value = data.mshowtime;
        form.querySelector('[name="mCategory"]').value = data.mcategory;
        form.querySelector('[name="mScreeningType"]').value = data.mscreeningtype;
        form.querySelector('[name="mMovieTheater"]').value = data.mmovietheater;
        form.querySelector('[name="mUrlImage"]').value = data.murlimage;
        form.querySelector('[name="mUrlMovie"]').value = data.murlmovie;

        // 감독 정보 채우기 관련 코드 전체 삭제

        // 배우 정보 채우기
        const actorsJson = getElement(data.actorsId)?.textContent;
        if (actorsJson) {
            try {
                JSON.parse(actorsJson).forEach(actor => manageActorList('add', actor));
            } catch (e) {
                console.error("배우 정보 파싱 오류:", e);
            }
        }
    };
    
    const confirmDelete = (event) => {
        if (!confirm('정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
            event.preventDefault();
            return false;
        }
        return true;
    };

    // --- Event Listeners & Initialization ---
    const init = () => {
        getElement('movie-section')?.addEventListener('click', (e) => {
            if (e.target.matches('.edit-movie-btn')) {
                populateMovieEditModal(e.target);
            }
        });
        
        movieForm?.addEventListener('submit', (e) => {
            prepareActorsForSubmission(e.target);
        });

        // 감독 검색 자동완성 관련 이벤트 리스너 삭제

        // 배우 검색 자동완성
        getElement('actor-search-input')?.addEventListener('keyup', debounce(e => {
            fetchSuggestions(e.target.value, getElement('actor-suggestions'), (actor) => {
                manageActorList('add', actor);
                e.target.value = ''; // 입력 필드 비우기
            });
        }));

        document.addEventListener('click', e => {
            if (!e.target.closest('.autocomplete-container')) {
                document.querySelectorAll('.suggestions-list').forEach(el => el.style.display = 'none');
            }
        });
    };
    
    document.addEventListener('DOMContentLoaded', init);

    return {
        openModal,
        closeModal,
        openNoticeEditModal,
        confirmDelete
    };
})();
</script>
</body>
</html>