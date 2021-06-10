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
	let fetchMethod;

	if (boardId !== 'insert')
		fetchMethod = 'PATCH';
	else
		fetchMethod = 'POST';

	fetch('../boards', {
		method: fetchMethod,
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({
			boardCategory: category,
			boardName: title,
			boardContent: content,
		}),
	})
		.then(res => res.json())
		.then(data => {
			if (data === 1) {
				if (boardId !== 'insert')
					alert('새 게시글을 작성했습니다.');
				else
					alert('게시글을 수정했습니다.');
				location.href = '../list';
			} else {
				alert('오류 발생');
			}
		})
		.catch(err => {
			console.log(err);
		});
}