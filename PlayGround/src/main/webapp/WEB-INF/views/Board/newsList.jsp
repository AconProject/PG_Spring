<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>NewsPage</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/CSS/BoardList.css?v=<%=System.currentTimeMillis() %>" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/JS/newsList.js?v=<%=System.currentTimeMillis() %>"></script>
</head>
<body>
	<!-- 페이지 상단 로고 및 배너 -->
    <jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<!-- 게시판 컨텐츠-->
    <div class="wrapper contents">

		<h1>뉴스 및 소식</h1>

		<table id="newsList">
			<tr>
				<th>제목</th>
				<th>날짜</th>
			</tr>
		</table>

		<div id="paging"></div>

    </div>


	<!-- 페이지 맨 밑부분 -->
    <jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
</body>
</html>