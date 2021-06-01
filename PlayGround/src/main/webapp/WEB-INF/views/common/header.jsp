<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/CSS/header.css" rel="stylesheet">
<header>
		<div class="wrapper">
		
			<h1>
				<a href="${pageContext.request.contextPath}/Main.jsp"><img class="logo" src="${pageContext.request.contextPath}/Image/logo.png" alt="로고 이미지"></a>
			</h1>
			
			<%
   				MemberDTO dto =(MemberDTO)session.getAttribute("login");

  			    if(dto != null){
	 			String mbrName = dto.getMbrName();
			%>

			<nav>
				<div class="empty"></div>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath}/Board/boardList.jsp">게시판</a></li>
					<li><a href="${pageContext.request.contextPath}/Board/newsList.jsp">뉴스 및 소식</a></li>
					<li><a href="${pageContext.request.contextPath}/MyPageServlet">마이페이지</a></li>
					<li><a href="${pageContext.request.contextPath}/LogoutServlet">로그아웃</a></li>
				</ul>
			</nav>
			<%
  			    } else {
			%>
			
			<nav>
				<div class="empty"></div>
				<ul class="nav">
					<li><a href="${pageContext.request.contextPath}/Board/boardList.jsp">게시판</a></li>
					<li><a href="${pageContext.request.contextPath}/Board/newsList.jsp">뉴스 및 소식</a></li>
					<li><a href="${pageContext.request.contextPath}/LoginServlet">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/MemberUIServlet">회원가입</a></li>
				</ul>
			</nav>
			
			<%
  			    }
			%>
		</div>
</header>