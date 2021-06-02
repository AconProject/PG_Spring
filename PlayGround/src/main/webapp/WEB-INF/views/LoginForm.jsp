<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style> body{} </style>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<%
	String mesg = (String) session.getAttribute("mesg");
    String mesg1 = (String)request.getAttribute("mbrId");
    String mesg2 = (String)request.getAttribute("mbrPw");
    
    if(mesg1 != null){
%>    
   <script>
     alert('<%= mesg1 %>');
   </script>
<%
	session.removeAttribute("mbrId");
  } 
   if(mesg2 != null) {
%> 
	<script>
     alert('<%= mesg2 %>');
   </script>
<%
	session.removeAttribute("mbrId");
  } 
   if(mesg != null) {
%>
	<script>
     alert('<%= mesg %>');
   </script>
<%
	session.removeAttribute("mesg");
  } 
%>
<title>Login</title>
</head>
<body>
	<jsp:include page="Member/loginForm.jsp" flush="false" />
</body>
</html>