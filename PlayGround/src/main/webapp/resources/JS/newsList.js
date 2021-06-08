window.onload = function () {
	getNewsList();
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

/* 모든 요소 삭제 (데이터 갱신 시 기존 데이터 삭제 위함) */
function removeAllElements(query) {
	let removeEles = document.querySelectorAll(query);
	for (let i = 0; i < removeEles.length; i++)
		removeEles[i].parentNode.removeChild(removeEles[i]);
}

/* 타임스탬프 -> 날짜 변환 */
function convertDate(timeStamp) {
	let rawDate = '';
	let date = '';
	rawDate = new Date(timeStamp);
	date += rawDate.getFullYear() + '.' +
		(rawDate.getMonth() + 1) + '.' +
		rawDate.getDate();
	return date;
}

/************************** paging & json parser ******************************/

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

	// 게시판 데이터 일부만 출력
	let start = (currentPage - 1) * maxDataPerPage;
	let end = currentPage * maxDataPerPage;
	jsonParserForNews(data, start, end);

	// 페이지 숫자 클릭 시 다시 페이징
	let pages = document.querySelectorAll('#paging a');
	pages.forEach(page => {
		page.addEventListener('click', function () {
			let id = this.getAttribute('id');
			let selectedPage = this.innerText;

			if (id === 'next')
				selectedPage = next;
			if (id === 'prev')
				selectedPage = prev;

			removeAllElements('tr[id^="news"]');
			paging(data, totalData, maxDataPerPage, maxPagePerWindow, selectedPage);
		}, false);
	});
}

/* 게시판 데이터 파싱 후 출력 */
function jsonParserForNews(data, start, end) {
	let newsDate = '';
	for (let i = start; i < data.length && i < end; i++) {
		newsDate = convertDate(data[i].newsDate);
		insertElement('tr', 'newsList', '', 'id', 'news' + i);
		insertElement('td', 'news' + i, '<a href="' + data[i].newsUrl + '">'
			+ data[i].newsTitle + '</a>');
		insertElement('td', 'news' + i, newsDate);
	}
}

/* 페이징함수 호출함수 */
function processNewsData(data) {
	let totalData = data.length; // 총 게시글 수
	let maxDataPerPage = 15; // 한 페이지에 나타낼수 있는 게시글수
	let maxPagePerWindow = 5; // 한 화면에 나타낼수 있는 페이지 수
	paging(data, totalData, maxDataPerPage, maxPagePerWindow, 1);
}

/********************************** ajax *************************************/

/* 뉴스 목록 불러오기 */
function getNewsList() {
	fetch('newsList')
		.then(res => res.json())
		.then(data => {
			processNewsData(data);
		})
		.catch(err => {
			console.log(err);
		});
}