<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BoardPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="<c:url value="/resources/CSS/BoardPage.css?v=23" />" rel="stylesheet">
	<script src="<c:url value="/resources/JS/boardPage.js?v=59" />"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<input type="hidden" id="loginId">
	<input type="hidden" id="loginName">
	<div class="wrapper contents">
		<!-- 게시글 내용 -->
		<section>
			<div id="boardCategory"></div>
			<div id="boardHead"></div>
			<hr>
			<div class="boardIcons">
				<img class="icon" src="<c:url value="/resources/Image/eye.png" />">&nbsp;<span id="hits"></span>
				<img class="icon" src="<c:url value="/resources/Image/thumb.png" />">&nbsp;<span id="recommends"></span>
				<img class="icon" src="<c:url value="/resources/Image/reply.png" />">&nbsp;<span id="comments">0</span>
			</div>
			<div id="boardContents"></div>
			<%
			MemberDTO dto = (MemberDTO)session.getAttribute("login");
			if(dto != null){
			%>
				<button id="boardLikeBtn">
					<img src="<c:url value="/resources/Image/afterLike.png" />">
				</button>
			<%
  			}
			%>
			<div id="boardBtns"></div>
		</section>

		<!-- 댓글 -->
		<section>
			<h1>댓글</h1>
			<hr>
			<table id="boardComments"></table>
			<div id="paging"></div>

			<%
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
				<span><%= loginName %></span>
				<textarea id="comment"></textarea>
				<button id="insertCommentBtn">작성</button>
			<%
  			}
			%>
		</section>
	</div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>