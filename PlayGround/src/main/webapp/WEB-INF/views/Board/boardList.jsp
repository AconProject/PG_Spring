<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BoardPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/CSS/BoardList.css?v=<%=System.currentTimeMillis() %>" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/JS/boardList.js?v=<%=System.currentTimeMillis() %>"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<!-- 게시판 컨텐츠-->
    <div class="wrapper contents">

		<h1>게시판</h1>

		<select id="boardCategory">
			<option value="all">전체 카테고리</option>
			<option value="common">일반글</option>
			<option value="info">게임정보</option>
			<option value="sales">할인정보</option>
			<option value="QnA">QnA</option>
		</select>

		<table id="boardList">
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
		</table>

		<div class="searchBox">
			<select id="searchCategory">
				<option value="contents" selected>제목+내용</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select>
			<input type="text" id="searchText">
			<button id="search"><img src="../Image/search.png" alt="검색"></button>
		</div>

		<%
			MemberDTO dto = (MemberDTO)session.getAttribute("login");
			if(dto != null){
		%>
		<button id="write">글 작성</button>
		<%
  			}
		%>

		<div id="paging"></div>

    </div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>