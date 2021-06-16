let boardUrlId;

window.onload = function () {
	// boardId 값 가져오기
	boardUrlId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);

	document.getElementById('reset').addEventListener('click', cancelBoard, false);
	document.getElementById('submit').addEventListener('click', uploadBoard, false);

	if (boardUrlId !== 'insert')
		getBoardContents();
};

/* 게시글 작성 리셋 */
function cancelBoard() {
	document.getElementById('boardName').value = '';
	document.getElementById('boardContent').value = '';
}

/* 게시글 작성, 수정 */
function uploadBoard() {
	let memberId = document.getElementById('loginId').value;
	let memberName = document.getElementById('loginName').value;
	let category = document.getElementById('boardCategory').value;
	let title = document.getElementById('boardName').value;
	let content = document.getElementById('boardContent').value;

	if (boardUrlId === 'insert')
		insertBoard(category, title, content, memberId, memberName);
	else
		updateBoard(category, title, content);
}

/****************************** json parser **********************************/

/*  수정 전 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data) {
	document.getElementById('boardName').setAttribute('value', data.boardName);
	document.getElementById('boardContent').innerHTML = data.boardContent;

	let selectedCategory =
		document.querySelector('option[value = "' + data.boardCategory + '"]');
	selectedCategory.setAttribute('selected', 'selected');
}

/* 수정 전 게시글 내용 불러오기 */
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

/********************************* ajax *************************************/

/* 게시글 작성 */
function insertBoard(category, title, content, memberId, memberName) {
	fetch('../boards', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			mbrId: memberId,
			mbrName: memberName,
			boardCategory: category,
			boardName: title,
			boardContent: content,
		}),
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('게시글 작성 실패');
			} else {
				alert('게시글 작성 완료');
				location.href = '../page/' + data;
			}
		})
		.catch(err => {
			console.log(err);
		});
}

/* 게시글 수정 */
function updateBoard(category, title, content) {
	fetch('../boards', {
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			boardId: boardUrlId,
			boardCategory: category,
			boardName: title,
			boardContent: content,
		}),
	})
		.then(res => res.json())
		.then(data => {
			if (data === -1) {
				alert('게시글 수정 실패');
			} else {
				alert('게시글 수정 완료');
				location.href = '../page/' + boardUrlId;
			}
		})
		.catch(err => {
			console.log(err);
		});
}