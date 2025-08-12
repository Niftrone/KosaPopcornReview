(function ($) {
  var state = {
    currentlyOpenMenu: null,
    isLoggedIn: String(window.isLoggedIn) === 'true'
  };

  function getCsrfHeader() {
    var token  = $('meta[name="_csrf"]').attr('content');
    var header = $('meta[name="_csrf_header"]').attr('content');
    return token && header ? { name: header, value: token } : null;
  }

  function closeCurrentMenu() {
    if (!state.currentlyOpenMenu) return;
    var $menu = state.currentlyOpenMenu;
    var $btn  = $menu.prev();
    $menu.removeClass('active');
    if ($btn.length) $btn.attr('aria-expanded', 'false');
    state.currentlyOpenMenu = null;
  }

  function toggleMenu($button) {
    var $commentItem = $button.closest('.comment-item');
    if ($commentItem.length === 0) return;

    var cId  = $commentItem.data('cid');
    var $menu = $('#menu-' + cId);
    if ($menu.length === 0) return;

    if (state.currentlyOpenMenu && !state.currentlyOpenMenu.is($menu)) {
      closeCurrentMenu();
    }

    var isOpen = !$menu.hasClass('active');
    $menu.toggleClass('active', isOpen);
    $button.attr('aria-expanded', String(isOpen));
    state.currentlyOpenMenu = isOpen ? $menu : null;
  }

  function enterEditMode(cId) {
    var $commentItem = $('.comment-item[data-cid="' + cId + '"]');
    var $textP = $commentItem.find('.comment-text').first();
    if ($commentItem.length === 0 || $textP.length === 0) return;

    if ($commentItem.find('.comment-edit-container').length) return;

    var original = $textP.text();
    var html =
      '<div class="comment-edit-container">' +
      '  <textarea class="comment-edit-textarea" rows="3">' + $('<div/>').text(original).html() + '</textarea>' +
      '  <div class="comment-edit-actions">' +
      '    <button type="button" class="edit-cancel-btn">취소</button>' +
      '    <button type="button" class="edit-save-btn">저장</button>' +
      '  </div>' +
      '</div>';

    $textP.hide().after(html);
    closeCurrentMenu();
  }

  function cancelEdit(cId) {
    var $commentItem = $('.comment-item[data-cid="' + cId + '"]');
    $commentItem.find('.comment-edit-container').remove();
    $commentItem.find('.comment-text').show();
  }

  // 댓글 수정: x-www-form-urlencoded + POST (/comment/{cId}/update)
  function updateComment(cId) {
    var $commentItem = $('.comment-item[data-cid="' + cId + '"]');
    var $textarea = $commentItem.find('.comment-edit-textarea');
    if ($textarea.length === 0) return;

    var updated = $.trim($textarea.val());
    if (!updated) {
      alert('댓글 내용을 입력해주세요.');
      return;
    }
    var rId = $('#rId').val();

    var data = {
      cId: cId,            // Comment.cId
      cPlot: updated,      // Comment.cPlot
      'review.rId': rId    // Comment.review.rId
    };

    var csrf = getCsrfHeader();

    $.ajax({
      url: '/comment/' + cId + '/update',
      type: 'POST',
      data: data, // jQuery가 폼 인코딩으로 전송
      beforeSend: function (xhr) {
        if (csrf) xhr.setRequestHeader(csrf.name, csrf.value);
      },
      success: function () {
        alert('댓글이 성공적으로 수정되었습니다.');
        $commentItem.find('.comment-text').text(updated).show();
        cancelEdit(cId);
      },
      error: function (xhr) {
        alert(xhr.responseText || '댓글 수정에 실패했습니다.');
      }
    });
  }

  // 댓글 삭제: POST (/comment/{cId}/delete)
  function requestDelete(cId) {
    if (!confirm('정말로 이 댓글을 삭제하시겠습니까?')) return;

    var rId = $('#rId').val();
	var data = {
	  cId: cId,            // Comment.cId
	  'review.rId': rId    // Comment.review.rId
	};
    var csrf = getCsrfHeader();

    $.ajax({
      url: '/comment/' + cId + '/delete',
      type: 'POST',
      data: data,
      beforeSend: function (xhr) {
        if (csrf) xhr.setRequestHeader(csrf.name, csrf.value);
      },
      success: function () {
        alert('댓글이 삭제되었습니다.');
        var $commentItem = $('.comment-item[data-cid="' + cId + '"]');
        $commentItem.css('opacity', 0);
        setTimeout(function () {
          $commentItem.remove();
          if ($('.comment-item').length === 0) {
            $('#comment-list-section').html('<p style="text-align: center; color: #888;">첫 번째 댓글을 남겨주세요.</p>');
          }
        }, 300);
      },
      error: function (xhr) {
        alert(xhr.responseText || '댓글 삭제에 실패했습니다.');
      }
    });
  }

  // 댓글 등록: 폼 전송 + POST /comment/add
  function submitComment(e) {
    e.preventDefault();

    if (!state.isLoggedIn) {
      alert('로그인이 필요한 기능입니다.');
      $('#loginModal').addClass('active');
      return;
    }

    var cPlot = $('#cPlotInput').val() || '';
    var rId = $('#rId').val();

    if (!$.trim(cPlot)) {
      alert('댓글 내용을 입력해주세요.');
      return;
    }

    var data = {
      'review.rId': rId,
      cPlot: $.trim(cPlot)
    };

    var csrf = getCsrfHeader();

    $.ajax({
      url: '/comment/add',
      type: 'POST',
      data: data,
      beforeSend: function (xhr) {
        if (csrf) xhr.setRequestHeader(csrf.name, csrf.value);
      },
      success: function () {
        location.reload();
      },
      error: function (xhr) {
        alert(xhr.responseText || '댓글 등록에 실패했습니다.');
      }
    });
  }

  function autoResizeTextarea(e) {
    var $ta = $(e.target);
    if (!$ta.is('.comment-input')) return;
    $ta.height('auto');
    $ta.height($ta.prop('scrollHeight'));
  }

  function handleReportClick() {
    if (!state.isLoggedIn) {
      alert('로그인이 필요한 기능입니다.');
      $('#loginModal').addClass('active');
    } else {
      alert('신고 기능은 준비 중입니다.');
    }
  }

  // 이벤트 바인딩(위임)
  function bindEvents() {
    // 문서 아무 곳 클릭 시 현재 열려있는 메뉴 닫기
    $(document).on('click', function () {
      closeCurrentMenu();
    });

    // 메뉴 버튼 클릭
    $(document).on('click', '.menu-button', function (e) {
      e.stopPropagation();
      toggleMenu($(this));
    });

    // 메뉴 내 "수정"
    $(document).on('click', '.menu-item-edit', function (e) {
      e.stopPropagation();
      var cId = $(this).closest('.comment-item').data('cid');
      if (cId != null) enterEditMode(cId);
    });

    // 메뉴 내 "삭제"
    $(document).on('click', '.menu-item-delete', function (e) {
      e.stopPropagation();
      var cId = $(this).closest('.comment-item').data('cid');
      if (cId != null) requestDelete(cId);
    });

    // 편집 저장/취소
    $(document).on('click', '.edit-cancel-btn', function () {
      var cId = $(this).closest('.comment-item').data('cid');
      if (cId != null) cancelEdit(cId);
    });

    $(document).on('click', '.edit-save-btn', function () {
      var cId = $(this).closest('.comment-item').data('cid');
      if (cId != null) updateComment(cId);
    });

    // 댓글 폼 제출
    $('#commentForm').on('submit', submitComment);

    // 신고 버튼
    $('.review-report-button').on('click', handleReportClick);

    // 뒤로 가기
    $('.back-button').on('click', function () { history.back(); });

    // 자동 리사이즈
    $(document).on('input', autoResizeTextarea);

    // URL 파라미터 처리
    var urlParams = new URLSearchParams(location.search);
    if (urlParams.get('error') === 'auth_required') {
      alert('로그인이 필요한 기능입니다.');
      $('#loginModal').addClass('active');
    }
  }

  // 초기화
  $(function () {
    bindEvents();
  });

})(jQuery);
