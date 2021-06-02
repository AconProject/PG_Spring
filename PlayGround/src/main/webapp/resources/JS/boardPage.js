let boardId = '';

window.onload = function(){

	// boardId 값 가져오기
	boardId = location.href.substr(
		location.href.lastIndexOf('=') + 1
	);
	
	document.getElementById('boardId').setAttribute('value', boardId);

	getBoardContents();
};

/* JSP에 새로운 태그 및 컨텐츠 삽입 */
function insertElement(childTag, parentId, content, attr, attrVal){
	let newEle = document.createElement(childTag);
	if (attr && attrVal)
		newEle.setAttribute(attr, attrVal);
	newEle.innerHTML = content;
	let parentEle = document.getElementById(parentId);
	parentEle.appendChild(newEle);
}

/* 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data){
	let jsonObj = JSON.parse(data[0]);
	let conmmentNum = data.length - 1;

	let html =
		'카테고리 - ' + jsonObj.boardCategory + '<br>' +
		'제목 - ' + jsonObj.boardName + '<br>' +
		'작성자 - ' + jsonObj.mbrName + '<br>' +
		'날짜 - ' + jsonObj.boardDate + '<br>' +
		'조회수 - ' + jsonObj.boardCount + '<br>' +
		'추천수 - ' + jsonObj.boardLiked + '<br>' +
		'댓글수 - ' + conmmentNum + '<br>' +
		'내용 - ' + jsonObj.boardContent + '<br>';
	
	document.getElementById('boardContents').innerHTML = html;

	checkMemberId(jsonObj.mbrId);
}

/* 게시글 댓글 파싱 후 출력 */
function jsonParserForBoardReply(data){
	let html = '';
	for (let i=1; i<data.length; i++){
		let jsonObj = JSON.parse(data[i]);
		
		html +=
		'닉넴 - ' + jsonObj.mbrName + '<br>' +
		'댓글 - ' + jsonObj.replyContent + '<br>' +
		'날짜 - ' + jsonObj.replyDate + '<br>' +
		'추천수 - ' + jsonObj.replyLiked + '<br>' +
		'------------------------------<br>';
	}
	document.getElementById('boardComments').innerHTML = html;
}

/* 게시글 내용 불러오기 */
function getBoardContents(){
	fetch('../BoardDetailServlet?boardId=' + boardId)
		.then(res => res.json())
		.then(data => {
			jsonParserForBoardContents(data);
			if (data.length > 1)
				jsonParserForBoardReply(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 글 작성자만 수정/삭제 버튼 표시 */
function checkMemberId(writerId){
	let loginId = document.getElementById('loginId').getAttribute('value');
	if (loginId === writerId) {
		insertElement('button', 'updateBtn', '글 수정', 'id', 'update');
		insertElement('button', 'deleteForm', '글 삭제', 'type', 'submit');
		
		document.getElementById('update').addEventListener('click', function(){
			location.href = 'updateBoard.jsp?boardId=' + boardId;
		}, false);
	}
}