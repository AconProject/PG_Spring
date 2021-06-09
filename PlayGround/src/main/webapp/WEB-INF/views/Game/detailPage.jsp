<%@page import="com.dto.GameDTO"%>
<%@page import="com.dto.RateDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/resources/CSS/DetailPage.css" />" rel="stylesheet">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function range() {

		var x = document.getElementById("newmeter").value;
		document.getElementById("reviewScore").innerHTML = x;

	}
	
    function click() {
		alert("로그인하고 작성하세요!");
	}
	
   $(function() {
	   
	   // 수정버튼 누르기
	   $(".upBtn").on("click", function() {
		   console.log("클릭했다!");
		   var reviewId = $(this).attr("data-reviewId");
		   var reviewContent = $(this).attr("data-reviewContent");
		   window.name = "parentForm"; // 댓글수정페이지
		   window.open("Game/reviewUpdateForm.jsp?reviewId=" + reviewId+"&reviewContent=" +reviewContent, "updateForm", "width=570, height=350, resizable=no, scrollbars=no");
	   }); // end upBtn
	   
	   
	   // 삭제버튼 누르기
		$(".delBtn").on("click", function() {
			console.log("클릭했다!");
			var reviewId = $(this).attr("data-reviewId");
			var gameNo = $(this).attr("data-gameNo");
			console.log("gameNo: " + gameNo);
			location.href="reviewDeleteServlet?reviewId=" + reviewId + "&gameNo=" + gameNo;
		}); // end delBtn
		
		// 좋아요버튼 누르기
		$(".icon").on("click", function() {
			console.log("따봉 클릭!");
			var num = $(this).attr("data-num");
			var liked = $("#"+num).text();
			var reviewId = $(this).attr("data-reviewId");
			var gameNo = $(this).attr("data-gameNo");
			var login = $(this).attr("data-login");
			
			console.log("gameNo: ", gameNo);
			console.log("ReviewId: ", reviewId);
			console.log("좋아요 수: ", liked);
			console.log("로그인: ", login);
			
			if(num == null){
				alert('로그인 후 사용 바람');
			}else {
			$.ajax({
				type:"get",
				url:"reviewLikeServlet",
				dataType:"text",
				data:{
					reviewId : reviewId,
					gameNo : gameNo
				},
				success: function(Data, status, xhr) {
					console.log("success");
					console.log(Data);
					if(Data==="이미 좋아요를 누르셨습니다."){
						console.log("이미 좋아요를 눌렀습니다.")
						alert(Data);
					} else {
						console.log("증가된 좋아요 수 : " + Data);
						var liked = $("#"+num).text(Data);
					}
				},
				error : function(xhr, status, error) {
					console.log("error");
				}
			}); // end ajax
			}
			
		}); // end liked
		
	});
    
    
</script>

<%
	String mesg = (String) session.getAttribute("mesg");
	if(mesg != null){
%>
	<script>
     alert('<%= mesg %>');
   </script>

<%
		session.removeAttribute("mbrId");
	  } 
%>
</head>


<body>
	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<%
	

	GameDTO gdto = (GameDTO) request.getAttribute("detailGame");
	RateDTO ratedto = (RateDTO) request.getAttribute("gameScore");
	double gameScore = ratedto.getGameScore();

	System.out.println("detailjsp - 게임정보 gdto : " + gdto);
	String gameNo = gdto.getGameNo();
	String gameName = gdto.getGameName();
	String gameIamge = gdto.getGameImage();
	int gamePrice = gdto.getGamePrice();
	String gameContent = gdto.getGameContent();
	String gameCategory = gdto.getGameCategory();
	String gameGenre = gdto.getGameGenre();
	String gameReleasedDate = gdto.getGameReleasedDate();
	
	/* 게임출시년도만 뜨기 */
	String date = gameReleasedDate.substring(0, 4);
	
	/* double gameScore = rdto.getGameScore(); */
	String[] category = gameGenre.split(",");
	
	MemberDTO login =(MemberDTO)session.getAttribute("login");
	%>

	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
	<div class="wrapper">
		<!-- 상단 -->
		<section class="main-contents">
			<div class="gamename">
				<h1 id="gameName"><%=gameName%><small id="gameReleaseDate">( <%= date %> )</small>
				</h1>
			</div>
			<div class="container">
				<div>
					<table class="topTable">
						<tr>
							<td rowspan="2" style="width: 250px;"><img class="gameImg" id="gameImage" src="<%= gameIamge %>" alt="게임 이미지"></td>
							<td class="tags">
								<table>
									<tr>
										<td><a href="./GameTagDetailServlet?gameCategory=<%=category[0]%>" class="tag">#<%=category[0]%></a></td>
										<td><a href="./GameTagDetailServlet?gameCategory=<%=category[1]%>" class="tag">#<%=category[1]%></a></td>
										<td><a href="./GameTagDetailServlet?gameCategory=<%=category[2]%>" class="tag">#<%=category[2]%></a></td>
									</tr>
									<tr>
										<td><a href="./GameTagDetailServlet?gameCategory=<%=category[3]%>" class="tag">#<%=category[3]%></a></td>
										<td><a href="./GameTagDetailServlet?gameCategory=<%=category[4]%>" class="tag">#<%=category[4]%></a></td>
									</tr>
								</table>
							</td>
							<td rowspan="2"><div class="score" id="gameScore"><%= gameScore %></div></td>
						</tr>
						<tr>
							<td><p class="content" id="gameContent">“ <%= gameContent %> ” </p></td>
						</tr>

					</table>
				</div>
			</div>
		</section>

		<!-- 중단 -->
		<%
			List<ReviewDTO> rdto = (List<ReviewDTO>) request.getAttribute("reviewList");
			if (rdto != null) {
				int totalPage = rdto.size();
				int perPage = 4;
				int p = 1;
				
		%>
		
		<section class="main-contents">
			<div class="usereval">
				<h1>유저평가</h1>
			</div>
			<div class="container">
				<div>
				
					<%
						if(login != null) {
						for (int i = (p - 1) * 4; i < (p * perPage); i++) {
							if (i == totalPage) break;
							ReviewDTO review = rdto.get(i);
							String id = "gameReviewLiked" + i;
					 %>
					 
					 	<table class="midTable">
						<tr>
							<td class="mbrName" id="mbrName"><%= review.getMbrName() %></td>
							<td class="review"><p id="gameReplyContent"><%= review.getReviewContent() %></p></td>
							<td class="meter"><meter min="0" max="100" value="<%= review.getReviewScore() %>"></meter><span id="gameScore"><%= review.getReviewScore() %></span></td>
							<td class="thumb"><img class="icon" src="Image/thumb.png" alt="추천수" data-login="<%= login.getMbrId()%>" data-num="<%= id %>" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>"><span id="<%=id%>"><%= review.getReviewLiked() %></span></td>
							<%
								if(login.getMbrName().equals(review.getMbrName())) {
							%>
							
							<td><button type="submit" class="upBtn" id="update" data-reviewContent="<%= review.getReviewContent() %>" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">수정</button></td>
							<td><button type="submit" class="delBtn" id="delete" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">삭제</button></td>
							
							<%
								}
							%>
								
						</tr>
						</table>
						
					<%				
							}
						} else {
							for (int i = (p - 1) * 4; i < (p * perPage); i++) {
								if (i == totalPage) break;
								ReviewDTO review = rdto.get(i);
					%>
						
						<table class="midTable">
						<tr>
							<td class="mbrName" id="mbrName"><%= review.getMbrName() %></td>
							<td class="review"><p id="gameReplyContent"><%= review.getReviewContent() %></p></td>
							<td class="meter"><meter min="0" max="100" value="<%= review.getReviewScore() %>"></meter><span id="gameScore"><%= review.getReviewScore() %></span></td>
							<td class="thumb"><img class="icon" src="Image/thumb.png" alt="추천수"><span id="gameReplyRecommend"><%= review.getReviewLiked() %></span></td>
						</tr>
						</table>
						
						<script>
							
						</script>
					<%
							}
						}
					}
					%>
					
					<!-- 댓글 삽입  -->
					<%
						String name = "로그인해주세요";
			    		if(login != null ){
			    			name =  login.getMbrName();
			    	%>
			    			
			    			<form action="reviewInsertServlet">
							<input type="hidden" name="gameNo" value="<%= gameNo %>">
							<table class="reviewTable">
								<tr>
									<td rowspan="3" class="mbrName" id="mbrName"><%= name %></td>
									<td rowspan="3" class="review">
									<textarea name="reviewContent" id="gameReplyContent" cols="80" rows="5" placeholder=" 내용을 입력해주세요"></textarea>
									</td>
									<td class="newmeter">0 <input type="range" name="reviewScore" id="newmeter" min="0" max="100" onclick="range()"> 100
									</td>
								<tr>
									<td><span id="reviewScore">0</span></td>
								</tr>
								<tr>
									<td><button type="submit" id="submit">올리기</button></td>
								</tr>
							</table>
						</form>
						
					<%
						}
					%>
		
				</div>
			</div>
		</section>

		<!-- 하단 -->
		<section class="main-contents">
			<div class="assogame">
				<h1>연관 게임</h1>
			</div>
			
			<div class="container">
				<div>
					<table class="bottomTable">
					<tr>
					<%
						List<GameDTO> relategame = (List<GameDTO>)request.getAttribute("relateGame");
						for(int i = 0; i < relategame.size(); i++) {
							GameDTO relate = relategame.get(i);
							String gameNum = relate.getGameNo();
							String gamename = relate.getGameName();
							String gameImage = relate.getGameImage();
					%> 
						
							<td><<a href="GameDetailServlet?gameNo=<%= gameNum %>" ><img class="game" id="game1" src="<%= gameImage %>" alt="게임 이미지"></a></td>
					<%
						}
					%> 
						</tr>
						<tr>
					<%
						for(int i = 0; i < relategame.size(); i++) {
							GameDTO relate = relategame.get(i);
							String gameNum = relate.getGameNo();
							String gamename = relate.getGameName();
							String gameImage = relate.getGameImage();
					%>
							<td class="title"><a href="GameDetailServlet?gameNo=<%= gameNum %>" class="gametitle" id="title1"><%= gamename %></a></td>
					<%
						}
					%> 
						</tr>
					
					</table>
				</div>
			</div>
		</section>

	</div>

	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>

</body>
</html>
