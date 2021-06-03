window.onload = function(){

	// 화면에 표시할 데이터 불러오기
	getNewGame();
	getTag();
	getTagGame();
	getRecommendedPost();
	getRecommendedQnA();
	getNews();

	// 버튼 클릭 이벤트 등록
	document.getElementById('newGame').addEventListener('click', getNewGameEvent, false);
	document.getElementById('recommendedGame').addEventListener('click', getRecommendedGame, false);
	document.getElementById('recommendedPost').addEventListener('click', getRecommendedPostEvent, false);
	document.getElementById('mostViewPost').addEventListener('click', getMostViewPost, false);
	document.getElementById('recommendedQnA').addEventListener('click', getRecommendedQnAEvent, false);
	document.getElementById('mostViewQnA').addEventListener('click', getMostViewQnA, false);
};

/* 모든 요소 삭제 (데이터 갱신 시 기존 데이터 삭제 위함) */
function removeAllElements(query){
	let removeEles = document.querySelectorAll(query);
	for (let i=0; i<removeEles.length; i++)
		removeEles[i].parentNode.removeChild(removeEles[i]);
}

/* JSP에 새로운 태그 및 컨텐츠 삽입 */
function insertElement(childTag, parentId, content, attr, attrVal){
	let newEle = document.createElement(childTag);
	if (attr && attrVal)
		newEle.setAttribute(attr, attrVal);
	newEle.innerHTML = content;
	let parentEle = document.getElementById(parentId);
	parentEle.appendChild(newEle);
}

function convertDate(timeStamp){
	let rawDate = '';
	let date = '';
	rawDate = new Date(timeStamp);
	date += rawDate.getFullYear() + '.' +
			(rawDate.getMonth()+1) + '.' +
			rawDate.getDate();
	return date;
}

/************************** json parser ******************************/

/* 상단에 표시할 게임데이터 파싱 후 출력 */
function jsonParserForTop(data){
	for (let i=0; i<data.length; i++){
		if (i<3){
			insertElement('td', 'topTableNum', (i+1)+'.');
			insertElement('td', 'topTableImg', '<a href="GameDetailServlet?gameNo='
				+ data[i].gameNo +'"><img class="gameImg" src="' + data[i].gameImage
				+ '" alt="이미지를 불러올 수 없습니다."></a>');
			insertElement('td', 'topTableName', '<a href="GameDetailServlet?gameNo='
				+ data[i].gameNo + '">' + data[i].gameName + '</a>', 'class', 'center');
			insertElement('td', 'topTableYear',
				data[i].gameReleasedDate, 'class', 'center');
			insertElement('td', 'topTableCategory',
				'#' + data[i].gameCategory, 'class', 'center tag');
		} else{
			insertElement('li', 'topChart', '<a href="GameDetailServlet?gameNo='
				+ data[i].gameNo + '">' + data[i].gameName + data[i].gameReleasedDate + '</a>');
		}
	}
}

/* 중단에 표시할 게임데이터 파싱 후 출력 */
function jsonParserForMiddle(data){
	for (let i=0; i<data.length; i++){
		insertElement('tr', 'midTable', '', 'id', 'midTr'+i);
		insertElement('td', 'midTr'+i, (i+1)+'.');
		insertElement('td', 'midTr'+i, '<a href="GameDetailServlet?gameNo='
			+ data[i].gameNo + '"><img class="gameImg" src="' + data[i].gameImage
			+ '" alt="이미지를 불러올 수 없습니다."></a>');
		insertElement('td', 'midTr'+i, '<a href="GameDetailServlet?gameNo='
			+ data[i].gameNo + '">' + data[i].gameName+data[i].gameReleasedDate + '</a>');
	}
}       

/* 중단 태그 파싱 후 출력 */
function jsonParserForTags(data){
	for (let i=0; i<data.length; i++){
		insertElement('p', 'tagScroll',
			'<input type="checkbox" name="tag" value="' +
			data[i].genreId + '">' + data[i].gameCategory, 'class', 'tag');
	}
}

/* 하단에 표시할 게시판 데이터 파싱 후 출력 */
function jsonParserForBoard(data, boardCategory){
	let boardDate = '';
	for (let i=0; i<data.length; i++){
		boardDate = convertDate(data[i].boardDate);
		insertElement('li', boardCategory, '<a href="BoardDetailServlet?boardId='
			+ data[i].boardId + '">' + data[i].boardName + '</a><div><span>'
			+ boardDate + '</span>&nbsp<img class="icon" src="resources/Image/eye.png">&nbsp<span>'
			+ data[i].boardCount + '</span>&nbsp<img class="icon" src="resources/Image/thumb.png">&nbsp<span>'
			+ data[i].boardLiked + '</span></div>');
	}
}

/* 하단에 표시할 뉴스 데이터 파싱 후 출력 */
function jsonParserForNews(data){
	let newsDate = '';
	for (let i=0; i<5; i++){
		newsDate = convertDate(data[i].newsDate);
		insertElement('li', 'mainNews', '<a href="'+ data[i].newsUrl + '">'
			+ data[i].newsTitle + newsDate + '</a>');
	}
}

/************************** ajax ******************************/

/* 상단 최신게임 불러오기 (페이지 첫 로딩) */
function getNewGame(){
	fetch('game/category/new')
		.then(res => res.json())
		.then(data => {
			jsonParserForTop(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 상단 최신게임 불러오기 (버튼 클릭) */
function getNewGameEvent(){
	fetch('game/category/new')
		.then(res => res.json())
		.then(data => {
			removeAllElements('.topTable td');
			removeAllElements('.topChart li');
			jsonParserForTop(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 상단 추천게임 불러오기 (버튼 클릭) */
function getRecommendedGame(){
	fetch('game/category/recommend')
		.then(res => res.json())
		.then(data => {
			removeAllElements('.topTable td');
			removeAllElements('.topChart li');
			jsonParserForTop(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 중단 태그 불러오기 및 태그 클릭 이벤트 등록 */
function getTag(){
	fetch('genre/genreList')
		.then(res => res.json())
		.then(data => {
			jsonParserForTags(data);
			let tags = document.getElementsByName('tag');
			tags.forEach((tag) => {
				tag.addEventListener('click', getCheckboxValue, false);
			});
		})
		.catch(err => {
			console.log(err);
		});
}

/* 중단 태그별 게임 불러오기 (페이지 첫 로딩) */
function getTagGame(){
	fetch('game/tag/noTag')
		.then(res => res.json())
		.then(data => {
			jsonParserForMiddle(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 중단 태그별 게임 불러오기 (태그 클릭) */
function getTagGameEvent(tagId){
	fetch('game/tag/'+tagId)
		.then(res => res.json())
		.then(data => {
			removeAllElements('.midTable tr');
			jsonParserForMiddle(data);
		})
		.catch(err => {
			console.log(err);
		});
}

/* 중단 태그 클릭 이벤트 (버튼 클릭) */
function getCheckboxValue(){
	let query = 'input[name="tag"]:checked';
	let selectedEls = 
		document.querySelectorAll(query);

	if (selectedEls.length === 0){
		removeAllElements('.midTable tr');
		getTagGame();
	} else{
		let checkedTagId = '';
		selectedEls.forEach((el) => {
			checkedTagId += el.value + ',';
		});
		getTagGameEvent(checkedTagId);
	}

	// 3개 클릭 시 체크박스 막기
	if (selectedEls.length > 2) {
		query = 'input[name="tag"]:not(:checked)';
		selectedEls = document.querySelectorAll(query);
		selectedEls.forEach((el) => {
			el.setAttribute('disabled', 'disabled');
		});
	} else {
		query = 'input[name="tag"]';
		selectedEls = document.querySelectorAll(query);
		selectedEls.forEach((el) => {
			el.removeAttribute('disabled');
		});
	}
}

/* 하단 게임게시판 추천순으로 불러오기 (페이지 첫 로딩) */
function getRecommendedPost(){
	fetch('board/gameInfoCategory/recommend')
		.then(res => res.json())
		.then(data => {
			jsonParserForBoard(data, 'boardPost');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 게임게시판 추천순으로 불러오기 (버튼 클릭) */
function getRecommendedPostEvent(){
	fetch('board/gameInfoCategory/recommend')
		.then(res => res.json())
		.then(data => {
			removeAllElements('#boardPost li');
			jsonParserForBoard(data, 'boardPost');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 게임게시판 조회수 정렬 (버튼 클릭) */
function getMostViewPost(){
	fetch('board/gameInfoCategory/hit')
		.then(res => res.json())
		.then(data => {
			removeAllElements('#boardPost li');
			jsonParserForBoard(data, 'boardPost');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 QnA게시판 추천수 정렬 (페이지 첫 로딩) */
function getRecommendedQnA(){
	fetch('board/qnaCategory/recommend')
		.then(res => res.json())
		.then(data => {
			jsonParserForBoard(data, 'boardQnA');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 QnA게시판 추천수 정렬 (버튼 클릭) */
function getRecommendedQnAEvent(){
	fetch('board/qnaCategory/recommend')
		.then(res => res.json())
		.then(data => {
			removeAllElements('#boardQnA li');
			jsonParserForBoard(data, 'boardQnA');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 QnA게시판 조회수 정렬 (버튼 클릭) */
function getMostViewQnA(){
	fetch('board/qnaCategory/hit')
		.then(res => res.json())
		.then(data => {
			removeAllElements('#boardQnA li');
			jsonParserForBoard(data, 'boardQnA');
		})
		.catch(err => {
			console.log(err);
		});
}

/* 하단 뉴스게시판 불러오기 */
function getNews(){
	fetch('news/newsList')
		.then(res => res.json())
		.then(data => {
			jsonParserForNews(data);
		})
		.catch(err => {
			console.log(err);
		});
}