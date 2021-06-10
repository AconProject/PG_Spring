let boardUrlId;

window.onload = function () {
	// boardId 값 가져오기
	boardUrlId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);

	document.getElementById('boardId').setAttribute('value', boardUrlId);
	document.getElementById('reset').addEventListener('click', cancelBoard, false);
	document.getElementById('submit').addEventListener('click', uploadBoard, false);

	if (boardUrlId !== 'insert')
		getBoardContents();
};

/*  수정 전 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data) {
	document.getElementById('boardName').setAttribute('value', data.boardName);
	document.getElementById('boardContent').setAttribute('value', data.boardContent);

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

function cancelBoard() {
	document.getElementById('boardName').value = '';
	document.getElementById('boardContent').value = '';
}

function uploadBoard() {
	let category = document.getElementById('boardCategory').value;
	let title = document.getElementById('boardName').value;
	let content = document.getElementById('boardName').value;
	let memberId = document.getElementById('loginId').value;

	if (boardUrlId === 'insert')
		insertBoard(category, title, content, memberId);
	else
		updateBoard(category, title, content);
}

function insertBoard(category, title, content, memberId) {
	fetch('../boards', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			mbrId: memberId,
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
				location.href = '../list';
			}
		})
		.catch(err => {
			console.log(err);
		});
}

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
				location.href = '../list';
			}
		})
		.catch(err => {
			console.log(err);
		});
}