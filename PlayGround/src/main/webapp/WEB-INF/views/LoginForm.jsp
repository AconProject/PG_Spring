<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${!empty mbrId }">
	<script>
		alert('${mbrId}');
	</script>
</c:if>

<c:if test="${!empty mbrPw }">
	<script>
		alert('${mbrPw}');
	</script>
</c:if>

<c:if test="${!empty mesg }">
	<script>
		alert('${mesg}');
	</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<style>
body {
	
}
</style>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<title>Login</title>
</head>
<body>
	<jsp:include page="Member/loginForm.jsp" flush="false" />
</body>
</html>