let boardId = '';

window.onload = function(){
	// boardId 값 가져오기
	boardId = location.href.substr(
		location.href.lastIndexOf('=') + 1
	);

	document.getElementById('boardId').setAttribute('value', boardId);

	getBoardContents();
};

/*  수정 전 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data){
	let jsonObj = JSON.parse(data[0]);
	document.getElementById('boardName').setAttribute('value', jsonObj.boardName);
	document.getElementById('boardContent').setAttribute('value', jsonObj.boardContent);
	
	let selectedCategory =
		document.querySelector('option[value = "' + jsonObj.boardCategory + '"]');
	selectedCategory.setAttribute('selected', 'selected');
}

/* 수정 전 게시글 내용 불러오기 */
function getBoardContents(){
	fetch('../BoardDetailServlet?boardId=' + boardId)
		.then(res => res.json())
		.then(data => {
			jsonParserForBoardContents(data);
		})
		.catch(err => {
			console.log(err);
		});
}