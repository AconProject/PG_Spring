<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${!empty success }">
	<script>
	alert('${success}');
	</script>
</c:if>

<c:if test="${!empty deleteResult }">
	<script>
		alert('${deleteResult}');
	</script>
</c:if>

<c:if test="${!empty mesg }">
	<script>
		alert('${mesg}');
	</script>
</c:if>

	
<!DOCTYPE html>
<HTML>
<head>
<meta charset="UTF-8">
<title>Play Ground</title>
<!-- <style type="text/css">body{background-image: url("./images/background.png");}</style>-->
<meta name="description" content="PlayGround" />
<meta name="author" content="TeamTwo" />


</head>
<body>
	
	<jsp:include page="Main/mainPage.jsp" flush="true"></jsp:include>


</body>
</html>