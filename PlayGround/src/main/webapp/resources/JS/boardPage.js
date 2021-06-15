let boardUrlId;
let isBoardLiked;

window.onload = function () {

	// boardId 값 가져오기
	boardUrlId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);

	let insertCommentBtn = document.getElementById('insertCommentBtn');
	if (insertCommentBtn)
		insertCommentBtn.addEventListener('click', insertComment, false);

	let boardLikeBtn = document.getElementById('boardLikeBtn');
	if (boardLikeBtn) {
		boardLikeBtn.addEventListener('click', boardLikeEvent, false);
		checkBoardLiked();
	}

	getBoardContents();
	getBoardReplies();
};

/* 타임스탬프 -> 날짜 변환 */
function convertDate(timeStamp) {
	let rawDate;
	let date;
	rawDate = new Date(timeStamp);
	date = rawDate.getFullYear() + '.' +
		(rawDate.getMonth() + 1) + '.' +
		rawDate.getDate();
	return date;
}

/* 보드 카테고리 ID에 맞는 카테고리명 출력 */
function getBoardCategory(categoryId) {
	switch (categoryId) {
	case 'common':
		return '일반글';
	case 'info':
		return '게임정보';
	case 'sales':
		return '할인정보';
	case 'QnA':
		return 'QnA';
	default:
		return '-';
	}
}

/* 작성자와 로그인 유저가 동일한지 체크 (1:일치, 0:불일치) */
function checkMemberId(writerId) {
	let loginId = document.getElementById('loginId').getAttribute('value');
	if (loginId === writerId)
		return 1;
	else
		return 0;
}

/* 모든 요소 삭제 (데이터 갱신 시 기존 데이터 삭제 위함) */
function removeAllElements(query) {
	let removeEles = document.querySelectorAll(query);
	removeEles.forEach(el => {
		el.parentNode.removeChild(el);
	});
}

/************************** paging & json parser ******************************/

/* 페이징함수 호출함수 */
function prepareForPaging(data) {
	let totalData = data.length; // 총 댓글 수
	let maxDataPerPage = 5; // 한 페이지에 나타낼수 있는 댓글 수
	let maxPagePerWindow = 5; // 한 화면에 나타낼수 있는 페이지 수
	paging(data, totalData, maxDataPerPage, maxPagePerWindow, 1);
}

/* 페이징 처리 */
function paging(data, totalData, maxDataPerPage, maxPagePerWindow, currentPage) {
	let totalPage = Math.ceil(totalData / maxDataPerPage); // 총 페이지수
	let pageGroup = Math.ceil(currentPage / maxPagePerWindow); // 페이지 그룹

	let last = pageGroup * maxPagePerWindow; // 화면에 보여질 마지막 페이지 번호
	if (last > totalPage)
		last = totalPage;

	let first = last - (maxPagePerWindow - 1); // 화면에 보여질 첫번째 페이지 번호
	if (first < 1)
		first = 1;

	let next = last + 1;
	let prev = first - 1;
	let html = '';

	// 페이지 숫자 출력
	if (prev > 0)
		html += '<a href="#" id="prev">&lt;</a>';

	for (let i = first; i <= last; i++)
		html += '<a href="#" id="page' + i + '">' + i + '</a>';

	if (last < totalPage)
		html += '<a href="#" id="next">&gt;</a>';

	document.getElementById('paging').innerHTML = html;
	document.getElementById('page' + currentPage).style.color = 'white';
	document.getElementById('page' + currentPage).style.backgroundColor = '#34314c';

	// 댓글 일부만 출력
	let start = (currentPage - 1) * maxDataPerPage;
	let end = currentPage * maxDataPerPage;
	jsonParserForBoardReply(data, start, end);

	// 페이지 숫자 클릭 시 다시 페이징
	let pages = document.querySelectorAll('#paging a');
	pages.forEach(page => {
		page.addEventListener('click', function () {
			let id = this.getAttribute('id');
			let selectedPage = this.innerText;

			if (id == 'next')
				selectedPage = next;
			if (id == 'prev')
				selectedPage = prev;

			removeAllElements('#boardComments *');
			paging(data, totalData, maxDataPerPage, maxPagePerWindow, selectedPage);
		}, false);
	});
}

/* 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data) {
	let boardDate = convertDate(data.boardDate);
	let boardCategory = getBoardCategory(data.boardCategory);

	let html =
		'카테고리 - ' + boardCategory + '<br>' +
		'제목 - ' + data.boardName + '<br>' +
		'작성자 - ' + data.mbrName + '<br>' +
		'날짜 - ' + boardDate + '<br>' +
		'조회수 - ' + data.boardCount + '<br>' +
		'추천수 - <span id="boardLike">' + data.boardLiked + '</span><br>' +
		'내용 - ' + data.boardContent + '<br>';

	document.getElementById('boardContents').innerHTML = html;

	if (checkMemberId(data.mbrId)) {
		html +=
			'<button id="updateBtn">수정</button>' +
			'<button id="deleteBtn">삭제</button>';

		document.getElementById('boardContents').innerHTML = html;

		document.getElementById('updateBtn').addEventListener('click', function () {
			location.href = '../write/' + boardUrlId;
		}, false);
		document.getElementById('deleteBtn').addEventListener('click', deleteBoard, false);
	}
}

/* 게시글 댓글 파싱 후 출력 */
function jsonParserForBoardReply(data, start, end) {
	let conmmentNum = data.length;
	let replyDate;

	let html = '';
	for (let i = start; i < data.length && i < end; i++) {

		replyDate = convertDate(data[i].replyDate);
		html +=
			'------------------------------<br>' +
			'댓글수 - ' + conmmentNum + '<br>' +
			'닉넴 - ' + data[i].mbrName + '<br>' +
			'댓글 - <span id="reply' + data[i].replyId + '">' + data[i].replyContent + '</span><br>' +
			'날짜 - ' + replyDate + '<br>' +
			'추천수 - <span id="replyLike' + data[i].replyId + '">' + data[i].replyLiked + '</span><br>' +
			'<input type="hidden" id="isLiked' + data[i].replyId + '" value="' + data[i].isLiked + '">';

		document.getElementById('boardComments').innerHTML = html;

		let loginId = document.getElementById('loginId').value;
		if (loginId !== '') {
			let mesg;
			if (data[i].isLiked === 0)
				mesg = '추천';
			else
				mesg = '추천 취소';
			
			html +=
				'<button id="replyLikeBtn' + data[i].replyId +
				'" value="' + data[i].replyId + '">' + mesg + '</button>';
		}

		if (checkMemberId(data[i].mbrId)) {
			html +=
				'<button id="updateCommentBtn' + i + '" value="' + data[i].replyId + '">수정</button>' +
				'<button id="deleteCommentBtn' + i + '" value="' + data[i].replyId + '">삭제</button>';

			document.getElementById('boardComments').innerHTML = html;

			let replyLikeBtns = document.querySelectorAll('button[id^="replyLikeBtn"]');
			let updateCommentBtns = document.querySelectorAll('button[id^="updateCommentBtn"]');
			let deleteCommentBtns = document.querySelectorAll('button[id^="deleteCommentBtn"]');

			replyLikeBtns.forEach(el => {
				el.addEventListener('click', replyLikeEvent, false);
			});

			updateCommentBtns.forEach(el => {
				el.addEventListener('click', updateComment, false);
			});

			deleteCommentBtns.forEach(el => {
				el.addEventListener('click', deleteComment, false);
			});
		}
	}
}

/********************************* ajax *************************************/

/* 게시글 내용 불러오기 */
function getBoardContents() {
	fetch('../boards/' + boardUrlId)
		.then(res => res.json())
		.then(data => {
			jsonParserForBoardContents(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 댓글 불러오기 */
function getBoardReplies() {
	fetch('../../reply/read/' + boardUrlId)
		.then(res => res.json())
		.then(data => {
			prepareForPaging(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 삭제 */
function deleteBoard() {
	fetch('../boards/' + boardUrlId, {
		method: 'DELETE',
	})
		.then(res => res.json())
		.then(data => {
			if (data === 1) {
				alert('게시글 삭제 완료');
				location.href = '../list';
			} else {
				alert('게시글 삭제 실패');
			}
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 좋아요 선택 여부 체크 */
function checkBoardLiked() {
	fetch('../boardLikeCount/' + boardUrlId)
		.then(res => res.json())
		.then(data => {
			isBoardLiked = data;
			if (isBoardLiked === 1)
				document.getElementById('boardLikeBtn').innerHTML = '좋아요 취소';
			else
				document.getElementById('boardLikeBtn').innerHTML = '좋아요';
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 좋아요 클릭 */
function boardLikeEvent() {
	let boardLikeNum = document.getElementById('boardLike').innerText;

	// 좋아요 누른적 없음 - 추가
	if (isBoardLiked === 0) {
		fetch('../boardLikePlus', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				boardId: boardUrlId,
				boardLike: boardLikeNum,
			}),
		})
			.then(res => res.json())
			.then(data => {
				document.getElementById('boardLike').innerText = data;
				isBoardLiked = 1;
				document.getElementById('boardLikeBtn').innerHTML = '좋아요 취소';
			})
			.catch(err => {
				console.log(err);
			});
	}
	else { // 이미 좋아요 누름 - 취소
		fetch('../boardLikeMinus', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				boardId: boardUrlId,
				boardLike: boardLikeNum,
			}),
		})
			.then(res => res.json())
			.then(data => {
				document.getElementById('boardLike').innerText = data;
				isBoardLiked = 0;
				document.getElementById('boardLikeBtn').innerHTML = '좋아요';
			})
			.catch(err => {
				console.log(err);
			});
	}
}

/* 댓글 작성 */
function insertComment() {
	let memberId = document.getElementById('loginId').value;
	let memberName = document.getElementById('loginName').value;
	let comment = document.getElementById('comment').value;

	fetch('../../reply/replies', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			boardId: boardUrlId,
			mbrId: memberId,
			mbrName: memberName,
			replyContent: comment,
		}),
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('댓글 업로드 실패');
			} else {
				getBoardReplies();
			}
		})
		.catch(err => {
			console.log(err);
		});

	document.getElementById('comment').value = '';
}

/* 댓글 수정 */
function updateComment(event) {
	let eventId = event.target.value;
	let comment = document.getElementById('comment').value;

	fetch('../../reply/replies', {
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			replyId: eventId,
			replyContent: comment,
		}),
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('댓글 수정 실패');
			} else {
				document.getElementById('reply' + eventId).innerHTML = comment;
			}
		})
		.catch(err => {
			console.log(err);
		});
}

/* 댓글 삭제 */
function deleteComment(event) {
	let replyId = event.target.value;

	fetch('../../reply/replies/' + replyId, {
		method: 'DELETE',
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('댓글 삭제 실패');
			} else {
				getBoardReplies();
			}
		})
		.catch(err => {
			console.log(err);
		});
}

/* 댓글 좋아요 클릭 */
function replyLikeEvent(event) {
	let eventId = event.target.value;
	let isReplyLiked = document.getElementById('isLiked' + eventId).value;

	// 좋아요 누른적 없음 - 추가
	if (isReplyLiked === 0) {
		fetch('../../reply/replyLikePlus', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				replyId: eventId,
			}),
		})
			.then(res => res.json())
			.then(data => {
				document.getElementById('replyLike' + eventId).innerText = data;
				document.getElementById('isLiked' + eventId).value = 1;
				document.getElementById('replyLikeBtn' + eventId).innerHTML = '추천 취소';
			})
			.catch(err => {
				console.log(err);
			});
	}
	else { // 이미 좋아요 누름 - 취소
		fetch('../../reply/replyLikeMinus', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				replyId: eventId,
			}),
		})
			.then(res => res.json())
			.then(data => {
				document.getElementById('replyLike' + eventId).innerText = data;
				document.getElementById('isLiked' + eventId).value = 0;
				document.getElementById('replyLikeBtn' + eventId).innerHTML = '추천';
			})
			.catch(err => {
				console.log(err);
			});
	}
}