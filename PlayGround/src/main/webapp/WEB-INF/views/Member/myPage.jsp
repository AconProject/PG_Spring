<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link href="<c:url value="/resources/CSS/MyPage.css" />" rel="stylesheet">

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<%
  
	MemberDTO dto =(MemberDTO)session.getAttribute("login");
    String mbrId = dto.getMbrId();
    String mbrName = dto.getMbrName();
    String mbrPw = dto.getMbrPw();
    String mbrEmail = dto.getMbrEmail();
    String mbrGenre = dto.getMbrGenre();
    String mbrRegdate = dto.getMbrRegdate();
   
%>

	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
    <div class="wrapper">
		<h2>마이페이지</h2>
		<!-- 상단 -->
        <section class="main-contents">
        
			<div class="container">
				<div class="side">
	 				<div class="menu" id="profile" onclick="location.href='${pageContext.request.contextPath}/MyPage.jsp'">프로필</div>
	 				<div class="menu" id="update" onclick="location.href='${pageContext.request.contextPath}/Member/memberUpdate.jsp'">정보수정</div>
				</div>
				
				<div class="content">
				
					

						<div class="member">아이디 &nbsp;&nbsp;&nbsp; <span><%= mbrId %></span>
						</div><br>
						
						<div class="member">닉네임 &nbsp;&nbsp;&nbsp; <span><%= mbrName %></span>
						</div><br>
						
						<div class="member">이메일 &nbsp;&nbsp;&nbsp; <span><%= mbrEmail %></span>	
						</div><br>
						
						<div class="member">선호장르 &nbsp;&nbsp;&nbsp; 
						<%
							if(mbrGenre==null){
						%>
							<div id="notag">선택하신 태그가 없습니다.</div>
						<%
							} else if(mbrGenre!=null) {
							String [] category = mbrGenre.split(",");
							for(int i=0; i<category.length; i++) {
						%>
							<a href="#" class="tag">#<%= category[i] %></a>
						
						<%
							}
							}
						%>
						
						</div><br>
						
						<button type="submit" onclick = "location.href='${pageContext.request.contextPath}/Member/memberUpdate.jsp'">수 정</button>
						<button type="submit" onclick = "location.href='${pageContext.request.contextPath}/Member/memberDelete.jsp'">삭 제</button>
					
					
				</div>
			</div>
        </section>

	</div>
		
	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>

