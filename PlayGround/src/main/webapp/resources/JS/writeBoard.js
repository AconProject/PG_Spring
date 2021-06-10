let boardId;

window.onload = function () {
	// boardId 값 가져오기
	boardId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);

	document.getElementById('boardId').setAttribute('value', boardId);
	document.getElementById('reset').addEventListener('click', cancelBoard, false);
	document.getElementById('submit').addEventListener('click', uploadBoard, false);

	if (boardId !== 'insert')
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
	fetch('../boards/' + boardId)
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
	let mbrId = document.getElementById('loginId').value;

	if (boardId === 'insert')
		insertBoard(category, title, content, mbrId);
	else
		updateBoard(category, title, content);
}

function insertBoard(category, title, content, mbrId) {
	fetch('../boards', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			'boardId': boardId,
			'boardCategory': category,
			'boardName': title,
			'boardContent': content,
			'mbrId': mbrId,
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
			'boardId': boardId,
			'boardCategory': category,
			'boardName': title,
			'boardContent': content,
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