<%@page import="com.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		$("form").on("submit", function() {
			/* var reviewId = $(this).attr("data-reviewId");
			var reviewContent = $("#reviewContent").val();
			console.log("reviewId: " + reviewId + " content: " + reviewContent);
			$.ajax({
				type:"get",
				url:"../reviewUpdateServlet".
				dataType="text",
				data:{
					reviewId : reviewId,
					reviewContent : reviewContent
				},
				success : function(data, status, xhr) {
					console.log("success!");
				},
				error : function(xhr, status, error) {
					console.log("error!");
				}
			})// end ajax */
			
			window.close();
		})
	}); 
</script>
</head>
<body>

<%
	String reviewId = request.getParameter("reviewId");
	String reviewContent = request.getParameter("reviewContent");
	System.out.println("updateform-review: " + reviewId + "\t" + reviewContent);
%>


<div id="wrap">
	<br>
	<h3>댓글수정</h3>
	<hr size="1">
	<br>
	
	<div id="reviewUpdateForm">
		<form name="reviewupdate" method="get" action="reviewUpdateServlet">
			<input type="hidden" name="reviewId" value="<%= reviewId %>">
			<textarea rows="7" cols="70" name="reviewContent" id="reviewContent"><%= reviewContent %></textarea>
			<br>
			<button type="submit" id="update">제출</button>
			<input type="button" value="창닫기" onclick="window.close();">
		</form>
	</div>
	
</div>

</body>
</html>