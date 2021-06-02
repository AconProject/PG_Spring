<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Update Board</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="${pageContext.request.contextPath}/JS/updateBoard.js?v=<%=System.currentTimeMillis() %>"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<div class="wrapper contents">

		<form action="../BoardModifyServlet" method="post">
			<input type="hidden" name="boardId" id="boardId">
			<input type="hidden" name="boardKind" value="boardUpdate">
			<select name="boardCategory">
				<option value="common">일반글</option>
				<option value="info">게임정보</option>
				<option value="sales">할인정보</option>
				<option value="QnA">QnA</option>
			</select>
			<input type="text" name="boardName" id="boardName">
			<input type="text" name="boardContent" id="boardContent">
			<button type="reset">다시쓰기</button>
			<button type="submit">완료</button>
		</form>

	</div>

	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>