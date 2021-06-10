<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Update Board</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="<c:url value="/resources/JS/writeBoard.js?v=8" />"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<input type="hidden" id="boardId">
	<div class="wrapper contents">

		<select id="boardCategory">
			<option value="common">일반글</option>
			<option value="info">게임정보</option>
			<option value="sales">할인정보</option>
			<option value="QnA">QnA</option>
		</select>
		<input type="text" id="boardName">
		<input type="text" id="boardContent">
		<button id="reset">다시쓰기</button>
		<button id="submit">완료</button>


	</div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>