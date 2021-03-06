<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<head>
<link href="<c:url value="/resources/CSS/header.css" />" rel="stylesheet">
</head>
<header>
		<div class="wrapper">
		
			<h1>
				<a href="${request.getContextPath()}/app"><img class="logo" src="<c:url value="/resources/Image/logo.png" />" alt="로고 이미지"></a>
			</h1>
			
			<%
   				MemberDTO dto =(MemberDTO)session.getAttribute("login");

  			    if(dto != null){
	 			String mbrName = dto.getMbrName();
			%>

			<nav>
				<div class="empty"></div>
				<ul class="nav">

					<li><a href="${request.getContextPath()}/app/board/list">게시판</a></li>
					<li><a href="${request.getContextPath()}/app/news/list">뉴스 및 소식</a></li>
					<li><a href="${request.getContextPath()}/app/loginCheck/myPage">마이페이지</a></li>
					<li><a href="${request.getContextPath()}/app/loginCheck/logout">로그아웃</a></li>
				</ul>
			</nav>
			<%
  			    } else {
			%>
			
			<nav>
				<div class="empty"></div>
				<ul class="nav">
					<li><a href="${request.getContextPath()}/app/board/list">게시판</a></li>
					<li><a href="${request.getContextPath()}/app/news/list">뉴스 및 소식</a></li>
					<li><a href="${request.getContextPath()}/app/LoginForm">로그인</a></li>
					<li><a href="${request.getContextPath()}/app/MemberForm">회원가입</a></li>
				</ul>
			</nav>
			
			<%
  			    }
			%>
		</div>
</header>