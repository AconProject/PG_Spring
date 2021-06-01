<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<head>
<meta charset="UTF-8">
<title>Play Ground</title>
<!-- <style type="text/css">body{background-image: url("./images/background.png");}</style>-->
<meta name="description" content="PlayGround" />
<meta name="author" content="TeamTwo" />
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />

<%
	String mesg = (String) session.getAttribute("memberAdd");
	if (mesg != null) {
%>
<script type="text/javascript">
     alert('<%=mesg%>');
</script>
<%
	session.removeAttribute("memberAdd");

	}
%>
</head>
<body>
	
	<jsp:include page="Main/mainPage.jsp" flush="true"></jsp:include>


</body>
</html>