<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   MemberDTO dto =(MemberDTO)session.getAttribute("login");

   if(dto != null){
	 String mbrName = dto.getMbrName();
%>
안녕하세요.<%=mbrName  %>
<a href="LogoutServlet">로그아웃</a>    
<a href="MyPageServlet">내 페이지</a>
<%
   }else{
%>    
<a href="LoginServlet">로그인</a>
<a href="MemberUIServlet">회원가입</a>

<%
   }//end if~else
%>
    