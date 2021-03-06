<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link href="<c:url value="/resources/CSS/Login.css" />" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("form").submit(function(event) {
			// 아이디 & 비밀번호 입력 검사
			
			var mbrId = $("#mbrId");
			var mbrPw = $("#mbrPw");
			console.log(mbrId,mbrPw);
			
			if (mbrId.val().length == 0) {
				swal("Oops!!", "ID를 다시 입력해주세요!", "error");
				mbrId.focus();
				event.preventDefault();
				
			} else if (mbrPw.val().length == 0) {
				swal("Oops!!", "PASSWORD를 다시 입력해주세요!", "error");
				mbrPw.focus();
				event.preventDefault();
			}
		})
	});
	
</script>
</head>

<body>

	<form action="login" method="post" class="loginForm">
		<a href="${request.getContextPath()}/app"><img class="logo" src="resources/Image/logo.png" alt="로고 이미지"></a>
		<p>" 자신을 알아야 평화를 찾을 수 있는 법 "</p>
		<div class="idForm">
			<input type="text" name="mbrId" id="mbrId" placeholder="ID">
		</div>
		<div class="pwForm">
			<input type="text" name="mbrPw" id="mbrPw" placeholder="PassWord">
		</div>
		<div class="button">
			<button type="submit" name="login" id="login">L O G I N</button>
		</div>
		<div class="check">
			<a href="${request.getContextPath()}/app/FindIdPw" id="find">아이디/비밀번호 찾기</a> 
			<a href="${request.getContextPath()}/app/MemberForm" id="create">회원가입</a>
		</div>
	</form>
	
</body>
</html>