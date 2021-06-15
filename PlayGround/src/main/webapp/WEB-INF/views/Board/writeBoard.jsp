<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Write Board</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="<c:url value="/resources/CSS/WriteBoard.css?v=21" />" rel="stylesheet">
	<script src="<c:url value="/resources/JS/writeBoard.js?v=26" />"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<input type="hidden" id="loginId">
	<input type="hidden" id="loginName">
	<%
		MemberDTO dto = (MemberDTO)session.getAttribute("login");

		if(dto != null){
			String loginId = dto.getMbrId();
			String loginName = dto.getMbrName();
	%>
		<script>
			let loginId = '<%= loginId %>';
			let loginName = '<%= loginName %>';
			document.getElementById('loginId').setAttribute('value', loginId);
			document.getElementById('loginName').setAttribute('value', loginName);
		</script>
	<%
		}
	%>

	<!-- 게시글 입력 -->
	<section class="wrapper contents">

		<h1>게시글 작성</h1>
		<hr>

		<select id="boardCategory">
			<option value="common">일반글</option>
			<option value="info">게임정보</option>
			<option value="sales">할인정보</option>
			<option value="QnA">QnA</option>
		</select>

		<input type="text" id="boardName" placeholder="제목">

		<div>
			<textarea id="boardContent"></textarea>
		</div>

		<button id="submit">완료</button>
		<button id="reset">다시쓰기</button>


	</section>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>