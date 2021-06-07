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
	<script src="<c:url value="/resources/JS/boardPage.js?v=1" />"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<input type="hidden" id="loginId">
	<div class="wrapper contents">
		<!-- 게시글 내용 -->
		<section>
			<div id="boardContents"></div>
			<div id="updateBtn"></div>
			<form action="board/delete/" id="deleteForm">
				<input type="hidden" name="boardId" id="boardId">
			</form>
		</section>

		<!-- 댓글 -->
		<section>
			<div id="boardComments"></div>

			<%
			MemberDTO dto = (MemberDTO)session.getAttribute("login");
			//Gson gson = new GsonBuilder().create();

			if(dto != null){
				String loginId = dto.getMbrId();
				String loginName = dto.getMbrName();
			%>
			<script>
				let loginId = <%= loginId %>;
				document.getElementById('loginId').setAttribute('value', loginId);
			</script>
			<div><%= loginName %></div>
			<input type="text" id="comment">
			<button id="submitComment">댓글 작성</button>
			<%
  			}
			%>
		</section>
	</div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>