<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>MainPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
	<link href="<c:url value="/resources/CSS/Main.css?v=11" />" rel="stylesheet">
	<script src="<c:url value="/resources/JS/main.js?v=6" />"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<!-- 메인화면 컨텐츠-->
    <div class="wrapper">

		<!-- 메인 상단 -->
		<div class="searchBox">
			<input type="text" id="searchText" placeholder="게임검색">
			<button id="search">
				<img src="<c:url value="/resources/Image/search.png" />" alt="검색">
			</button>
		</div>

        <section class="main-contents">
			<button id="newGame" class="gamesBtn">최신게임</button>
			<button id="recommendedGame" class="gamesBtn">추천게임</button>
			<div class="container">
				<div>
					<table class="topTable">
						<tr id="topTableNum"></tr>
						<tr id="topTableImg"></tr>
						<tr id="topTableName"></tr>
						<tr id="topTableYear"></tr>
						<tr id="topTableCategory"></tr>
					</table>
				</div>
				<div>
					<ol class="topChart" id="topChart" start="4"></ol>
				</div>
			</div>
        </section>

		<!-- 메인 중단 -->
        <section class="main-contents">
			<div class="container">
				<div>
					<table class="midTable" id="midTable"></table>
				</div>
				<div>
					<input type="text" id="tagSearch" placeholder="태그검색">
					<div class="tagScroll" id="tagScroll"></div>
				</div>
			</div>
        </section>

		<!-- 메인 하단 -->
		<section class="main-contents">
			<div class="bestBoard">
				<p>게임 베스트</p><p>질문 답변 베스트</p>
			</div>
			<div class="container">
				<div>
					<button class="boardBtn" id="recommendedPost">추천</button>
					<button class="boardBtn" id="mostViewPost">조회</button>
					<ol class="boardChart" id="boardPost"></ol>
				</div>
				<div>
					<button class="boardBtn" id="recommendedQnA">추천</button>
					<button class="boardBtn" id="mostViewQnA">조회</button>
					<ol class="boardChart" id="boardQnA"></ol>
				</div>
			</div>
			<div class="news">
				<p>최신 뉴스</p>
			</div>
			<div class="container">
				<div>
					<ol class="newsChart" id="mainNews"></ol>
				</div>
			</div>
        </section>

    </div>


	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>
</body>
</html>