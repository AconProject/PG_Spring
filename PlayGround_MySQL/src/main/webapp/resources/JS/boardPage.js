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

/* JSP에 새로운 태그 및 컨텐츠 삽입 */
function insertElement(childTag, parentId, content, attr, attrVal) {
	let newEle = document.createElement(childTag);
	if (attr && attrVal)
		newEle.setAttribute(attr, attrVal);
	newEle.innerHTML = content;
	let parentEle = document.getElementById(parentId);
	parentEle.appendChild(newEle);
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

	insertElement('h3', 'boardCategory', '[' + boardCategory + ']');
	insertElement('h1', 'boardHead', data.boardName);
	insertElement('h3', 'boardHead', data.mbrName);
	insertElement('span', 'boardHead', boardDate);

	document.getElementById('hits').innerHTML = data.boardCount;
	document.getElementById('recommends').innerHTML = data.boardLiked;

	document.getElementById('boardContents').innerHTML = data.boardContent;

	if (checkMemberId(data.mbrId)) {
		insertElement('button', 'boardBtns', '수정', 'id', 'updateBtn');
		insertElement('button', 'boardBtns', '삭제', 'id', 'deleteBtn');

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

	document.getElementById('comments').innerHTML = conmmentNum;

	for (let i = start; i < data.length && i < end; i++) {

		replyDate = convertDate(data[i].replyDate);

		insertElement('tr', 'boardComments', '', 'id', 'comment' + i);
		insertElement('th', 'comment' + i, data[i].mbrName);
		insertElement('td', 'comment' + i, '<textarea id="reply' + data[i].replyId +
			'" readonly>' + data[i].replyContent + '</textarea>');
		insertElement('td', 'comment' + i, replyDate);
		insertElement('td', 'comment' + i, '<span id="replyLike' + data[i].replyId + '">' +
			data[i].replyLiked + '</span>');
		insertElement('td', 'comment' + i, '<input type="hidden" id="isLiked' + data[i].replyId +
			'" value="' + data[i].visit + '">');

		let loginId = document.getElementById('loginId').value;
		if (loginId !== '') {
			let src;
			if (data[i].visit === 0)
				src = '../../resources/Image/emptyThumb.png';
			else
				src = '../../resources/Image/thumb.png';

			insertElement('td', 'comment' + i,
				'<img id="replyLikeBtn' + data[i].replyId + '" src="' + src + '">');
		}

		if (checkMemberId(data[i].mbrId)) {
			insertElement('td', 'comment' + i, '<button id="deleteCommentBtn' + i +
				'" value="' + data[i].replyId + '">삭제</button>');
			insertElement('td', 'comment' + i, '<button id="updateCommentBtn' + data[i].replyId +
				'" value="' + data[i].replyId + '">수정</button>');
		}
	}
	let replyLikeBtns = document.querySelectorAll('img[id^="replyLikeBtn"]');
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
			let boardLikeBtn = document.getElementById('boardLikeBtn');
			if (isBoardLiked === 1)
				boardLikeBtn.setAttribute('src', '../../resources/Image/thumb.png');
			else
				boardLikeBtn.setAttribute('src', '../../resources/Image/emptyThumb.png');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 좋아요 클릭 */
function boardLikeEvent() {
	let boardLikeNum = document.getElementById('comments').innerText;

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
				document.getElementById('recommends').innerText = data;
				isBoardLiked = 1;
				document.getElementById('boardLikeBtn')
					.setAttribute('src', '../../resources/Image/thumb.png');
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
				document.getElementById('recommends').innerText = data;
				isBoardLiked = 0;
				document.getElementById('boardLikeBtn')
					.setAttribute('src', '../../resources/Image/emptyThumb.png');
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
	let commentTextArea = document.getElementById('comment');
	let comment = commentTextArea.value;

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
				removeAllElements('#boardComments *');
				getBoardReplies();
			}
		})
		.catch(err => {
			console.log(err);
		});

	commentTextArea.value = '';
}

/* 댓글 수정 */
function updateComment() {
	let eventId = this.value;
	let replyTextArea = document.getElementById('reply' + eventId);

	replyTextArea.removeAttribute('readonly');
	replyTextArea.style.border = '1px solid black';
	replyTextArea.style.textAlign = 'left';
	replyTextArea.focus();

	this.innerHTML = '완료';
	this.removeEventListener('click', updateComment);
	this.addEventListener('click', updateCommentSubmit, false);
}

function updateCommentSubmit() {
	let eventId = this.value;
	let replyTextArea = document.getElementById('reply' + eventId);
	let comment = replyTextArea.value;

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
				document.getElementById('reply' + eventId).value = comment;
			}
		})
		.catch(err => {
			console.log(err);
		});

	replyTextArea.setAttribute('readonly', 'readonly');
	replyTextArea.style.border = 'none';
	replyTextArea.style.textAlign = 'center';

	this.innerHTML = '수정';
	this.removeEventListener('click', updateCommentSubmit);
	this.addEventListener('click', updateComment, false);
}

/* 댓글 삭제 */
function deleteComment() {
	let replyId = this.value;

	fetch('../../reply/replies/' + replyId, {
		method: 'DELETE',
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('댓글 삭제 실패');
			} else {
				removeAllElements('#boardComments *');
				getBoardReplies();
			}
		})
		.catch(err => {
			console.log(err);
		});
}

/* 댓글 좋아요 클릭 */
function replyLikeEvent() {
	let eventId = this.id.slice(12,);
	let isReplyLiked = document.getElementById('isLiked' + eventId).value;
	let replyLikeNum = document.getElementById('replyLike' + eventId).innerText;

	// 좋아요 누른적 없음 - 추가
	if (isReplyLiked === '0') {
		fetch('../../reply/replyLikePlus', {
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
				document.getElementById('isLiked' + eventId).value = 1;
				document.getElementById('replyLikeBtn' + eventId)
					.setAttribute('src', '../../resources/Image/thumb.png');
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
				boardId: boardUrlId,
				replyLike: replyLikeNum,
			}),
		})
			.then(res => res.json())
			.then(data => {
				document.getElementById('replyLike' + eventId).innerText = data;
				document.getElementById('isLiked' + eventId).value = 0;
				document.getElementById('replyLikeBtn' + eventId)
					.setAttribute('src', '../../resources/Image/emptyThumb.png');
			})
			.catch(err => {
				console.log(err);
			});
	}
}