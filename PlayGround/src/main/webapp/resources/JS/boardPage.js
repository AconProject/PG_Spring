let boardId;

window.onload = function () {

	// boardId 값 가져오기
	boardId = location.href.substr(
		location.href.lastIndexOf('/') + 1
	);

	document.getElementById('boardId').setAttribute('value', boardId);

	getBoardContents();
};

/* JSP에 새로운 태그 및 컨텐츠 삽입 */
function insertElement(childTag, parentId, content, attr, attrVal) {
	let newEle = document.createElement(childTag);
	if (attr && attrVal)
		newEle.setAttribute(attr, attrVal);
	newEle.innerHTML = content;
	let parentEle = document.getElementById(parentId);
	parentEle.appendChild(newEle);
}

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

/****************************** json parser **********************************/

/* 게시글 데이터 파싱 후 출력 */
function jsonParserForBoardContents(data) {
	let boardDate = convertDate(data.boardDate);

	let html =
		'카테고리 - ' + data.boardCategory + '<br>' +
		'제목 - ' + data.boardName + '<br>' +
		'작성자 - ' + data.mbrName + '<br>' +
		'날짜 - ' + boardDate + '<br>' +
		'조회수 - ' + data.boardCount + '<br>' +
		'추천수 - ' + data.boardLiked + '<br>' +
		'내용 - ' + data.boardContent + '<br>';

	document.getElementById('boardContents').innerHTML = html;

	checkMemberId(data.mbrId);
}

/* 게시글 댓글 파싱 후 출력 */
function jsonParserForBoardReply(data) {
	let conmmentNum = data.length - 1;
	let replyDate;

	let html = '';
	for (let i = 1; i < data.length; i++) {

		replyDate = convertDate(data[i].replyDate);
		html +=
			'------------------------------<br>' +
			'댓글수 - ' + conmmentNum + '<br>' +
			'닉넴 - ' + data[i].mbrName + '<br>' +
			'댓글 - ' + data[i].replyContent + '<br>' +
			'날짜 - ' + replyDate + '<br>' +
			'추천수 - ' + data[i].replyLiked + '<br>';
	}
	document.getElementById('boardComments').innerHTML = html;
}

/* 글 작성자만 수정/삭제 버튼 표시 */
function checkMemberId(writerId) {
	let loginId = document.getElementById('loginId').getAttribute('value');
	if (loginId === writerId) {
		insertElement('button', 'updateBtn', '글 수정', 'id', 'update');
		insertElement('button', 'deleteForm', '글 삭제', 'type', 'submit');

		document.getElementById('update').addEventListener('click', function () {
			location.href = 'board/write/' + boardId;
		}, false);
	}
}

/********************************* ajax *************************************/

/* 게시글 내용 불러오기 */
function getBoardContents() {
	fetch('../boards/' + boardId)
		.then(res => res.json())
		.then(data => {
			jsonParserForBoardContents(data);
		})
		.then(
			fetch('../../reply/read/' + boardId)
				.then(res => res.json())
				.then(data => {
					jsonParserForBoardReply(data);
				})
		)
		.catch(err => {
			console.log(err);
		});
}