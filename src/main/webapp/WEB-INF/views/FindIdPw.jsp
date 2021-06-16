<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link href="<c:url value="/resources/CSS/FindIdPw.css" />" rel="stylesheet">
</head>

<%
   String mesg = (String)request.getAttribute("mesg");
  if(mesg!=null){
%>    
   <script>
     alert('<%=mesg %>');
   </script>
<%
  }
%>
<body>

	
	<div class="findform">
	
	<div class="menubar">
		<a href="${request.getContextPath()}/app"><img class="logo" src="resources/Image/logo.png" alt="로고 이미지"></a>
		<a href="${request.getContextPath()}/app/LoginForm" class="menu">로그인</a>
		<a href="${request.getContextPath()}/app/MemberForm" class="menu">회원가입</a>
	</div>
	
	<form action="MemberIdSearch" method="post" class="findid">
		<h2>아이디 찾기</h2>
		<div class="row">
			<span class="title">닉네임</span> 
			<input type="text" class="content" name="mbrName" id="mbrName">
		</div>
		<div class="row">
			<span class="title">이메일</span> 
			<input type="email" class="content" name="mbrEmail" id="mbrEmail">
		</div>
		<div class="button">
			<input type="submit" id="findidsubmit" value="제 출">
		</div>
	</form>
	
	<form action="MemberPwSearch" method="post" class="findpw">
		<h2>비밀번호 찾기</h2>
		<div class="row">
			<span class="title">아이디</span> 
			<input type="text" class="content" name="mbrId" id="mbrId">
		</div>
		<div class="row">
			<span class="title">이메일</span> 
			<input type="email" class="content" name="mbrEmail" id="mbrEmail">
		</div>
		<div class="button">
			<input type="submit" id="findpwsubmit"value="제 출">
		</div>
	</form>
	
</div>

</body>
</html>