let boardUrlId;

window.onload = function () {

	// boardId 값 가져오기
	boardUrlId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);
	
	let insertCommentBtn = document.getElementById('insertCommentBtn');
	if (insertCommentBtn)
		insertCommentBtn.addEventListener('click', insertComment, false);
	
	let boardLikeBtn = document.getElementById('boardLikeBtn');
	if (boardLikeBtn)
		boardLikeBtn.addEventListener('click', boardLikeEvent, false);

	getBoardContents();
	getBoardReplies();
	checkBoardLike();
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

/****************************** json parser **********************************/

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
function jsonParserForBoardReply(data) {
	let conmmentNum = data.length;
	let replyDate;

	let html = '';
	for (let i = 0; i < data.length; i++) {

		replyDate = convertDate(data[i].replyDate);
		html +=
			'------------------------------<br>' +
			'댓글수 - ' + conmmentNum + '<br>' +
			'닉넴 - ' + data[i].mbrName + '<br>' +
			'댓글 - ' + data[i].replyContent + '<br>' +
			'날짜 - ' + replyDate + '<br>' +
			'추천수 - <span id="replyLike' + data[i].replyId + '">' + data[i].replyLiked + '</span><br>';
		
		document.getElementById('boardComments').innerHTML = html;

		let loginId = document.getElementById('loginId').value;
		if (loginId !== '') {
			html += '<button id="replyLikeBtn' + i + '" value="' + data[i].replyId + '">추천</button>';
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
			jsonParserForBoardReply(data);
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

/* 게시글 좋아요 클릭 */
function boardLikeEvent() {
	let boardLikeNum = document.getElementById('boardLike').innerText;

	fetch('../boardLike', {
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
		})
		.catch(err => {
			console.log(err);
		});
}

/* 좋아요 선택 여부에 따라 버튼 바꾸기 */
function checkBoardLike() {
	fetch('??')
		.then(res => res.json())
		.then(data => {
			if (data === 1)
				document.getElementById('boardLikeBtn').innerHTML = '좋아요 취소';
			else
				document.getElementById('boardLikeBtn').innerHTML = '좋아요';
		})
		.catch(err => {
			console.log(err);
		});
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
				getBoardReplies();
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
	let replyLikeNum = document.getElementById('replyLike' + eventId).innerText;

	fetch('../../reply/replyLike/', {
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			replyId: eventId,
			boardId: boardUrlId,
			replyLike: replyLikeNum,
		}),
	})
		.then(res => res.json())
		.then(data => {
			document.getElementById('replyLike' + eventId).innerText = data;
		})
		.catch(err => {
			console.log(err);
		});
}