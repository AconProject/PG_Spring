let boardId = '';

window.onload = function () {
	// boardId 값 가져오기
	boardId = location.href.substr(
		location.href.lastIndexOf('=') + 1
	);

	document.getElementById('boardId').setAttribute('value', boardId);

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
	fetch('board/read/' + boardId)
		.then(res => res.json())
		.then(data => {
			jsonParserForBoardContents(data[0]);
		})
		.catch(err => {
			console.log(err);
		});
}