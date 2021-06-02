<%@page import="com.dto.MemberDTO"%>
<%@page import="com.google.gson.*"%>
<%@page import="org.json.simple.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BoardPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="${pageContext.request.contextPath}/JS/boardPage.js?v=<%=System.currentTimeMillis() %>"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<input type="hidden" id="loginId">
	<div class="wrapper contents">
		<!-- 게시글 내용 -->
		<section>
			<div id="boardContents"></div>

			<%
			MemberDTO dto = (MemberDTO)session.getAttribute("login");
			Gson gson = new GsonBuilder().create();

			if(dto != null){
			%>
			<script>
				let loginJSON = <%= gson.toJson(dto) %>;
				let loginId = loginJSON.mbrId;
				document.getElementById('loginId').setAttribute('value', loginId);
			</script>
			<%
  			}
			%>

			<div id="updateBtn"></div>
			<form action="../BoardModifyServlet" id="deleteForm">
				<input type="hidden" name="boardId" id="boardId">
				<input type="hidden" name="boardKind" value="boardDelete">
			</form>
		</section>

		<!-- 댓글 -->
		<section>
			<div id="boardComments"></div>
		</section>
	</div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>