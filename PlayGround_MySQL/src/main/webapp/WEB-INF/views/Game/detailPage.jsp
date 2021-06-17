<%@page import="com.dto.GameDTO"%>
<%@page import="com.dto.RateDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head profile="http://www.w3.org/2005/10/profile">
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
		
	   // 삭제버튼 누르기
		$(".delBtn").on("click", function() {
			console.log("클릭했다!");
			var reviewId = $(this).attr("data-reviewId");
			var gameNo = $(this).attr("data-gameNo");
			console.log("gameNo: " + gameNo);
			location.href="../../loginCheck/reviewDelete?reviewId=" + reviewId + "&gameNo=" + gameNo;
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
				url:"../../loginCheck/reviewLike",
				dataType:"text",
				data:{
					reviewId : reviewId
				},
				success: function(Data, status, xhr) {
					console.log("success");
					console.log(Data);		
					
					if(Data!=null){
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
    
	// 
	function reviewUpdate() {
		console.log("수정 버튼 클릭!");
		var upbtn = document.getElementById('update');
		console.log(upbtn);
		var reviewId = upbtn.getAttribute('data-reviewId');
		var reviewContent = upbtn.getAttribute('data-reviewContent');
		console.log(reviewId + "\t" + reviewContent);
		
		var update = "#gameReviewContent" + reviewId;
		console.log("u: ", update);
		   
		$(update).contents().unwrap().wrap( '<textarea class="review" id="reviewUpdate""></textarea>' );
		$("#update").replaceWith('<button id="submit" onclick="submit();" data-reviewId="'+reviewId+'">확인</button>');
		   
		console.log($("#reviewUpdate").id);
	}
    
    // 댓글수정하기
    function submit() {
		const reviewContent = document.getElementById("reviewUpdate").value;
		console.log(reviewContent);
		
		console.log(document.getElementById("submit"));
		
		const reviewId = document.getElementById("submit").getAttribute('data-reviewId');
		console.log(reviewId);
		
		$.ajax({
			type:"post",
			url:"../../loginCheck/reviewUpdate",
			dataType: "text",
			data:{
				reviewContent : reviewContent,
				reviewId : reviewId
			},
			success : function(Data, status, xhr) {
				console.log("success");
				console.log(Data);
				
				var update = "gameReviewContent" + reviewId;
				console.log(update);
				$("#reviewUpdate").replaceWith('<p id="'+update+'">'+Data+'</p>');
				$("#submit").replaceWith('<button type="submit" class="upBtn" id="update" onclick="reviewUpdate();" data-reviewContent="'+reviewContent+'" data-reviewId="' + reviewId + '" >수정</button>');
			},
			error : function(xhr, status, error) {
				console.log("error");
			}
		});
	}
    
    
</script>

<%
	String mesg = (String) session.getAttribute("mesg");
	if(mesg != null){
%>
	<script>
     alert('<%= mesg %>');
   </script>

<%
		session.removeAttribute("mesg");
	  } 
	
%>

<script>
	var game = '${topPageGame}';
	console.log(game);
	
	var gameNo = '${topPageGame.gameNo}';
	var gameName = '${topPageGame.gameName}';
	var gameImage = '${topPageGame.gameImage}';
	var gamePrice = '${topPageGame.gamePrice}';
	var gameContent = '${topPageGame.gameContent}';
	var gameCategory = '${topPageGame.gameCategory}';
	var gameGenre = '${topPageGame.gameGenre}';
	var gameReleasedDate = '${topPageGame.gameReleasedDate}';
	var gameScore = '${topPageScore.gameScore}';
	console.log('gameScore: ' , gameScore);
	var rateCount = '${topPageScore.rateCount}';
	console.log('rateCount: ', rateCount);
	// 게임평균점수
	var avgScore =(gameScore / rateCount).toFixed(1);
	if(isNaN(avgScore)){
		avgScore = 0.0;
	}
	
	var discountRate = '${topPageGame.discountRate}';
	var discountPrice = gamePrice - (gamePrice * (discountRate/100));
	console.log(discountPrice);
	
	var date = gameReleasedDate.substring(0,4);
	console.log(date);
	
	// 장르 배열로 
	var category = [];
	category = gameGenre.split(",");
	
	// 장르 하나씩 뽑기
	for (var i = 0; i < category.length; i++) {
		console.log(category[i]);
	}
	console.log(category[0]);
	
	
	window.onload = function() {
		
		// 상단부분(게임설명)
		if(discountRate != 0.0) {
		// 게임이름
		document.getElementById("gameName").innerHTML = gameName + "   ( " + date + " ) &nbsp;&nbsp;  <span style='font-size:17px; color:red; text-decoration:line-through;'>\\" + gamePrice.toLocaleString('en') + "</span> <span style='font-size:17px; color:red;'>("+ discountRate + "% ) → \\" + discountPrice.toLocaleString() +"</span>";
		} else {
			document.getElementById("gameName").innerHTML = gameName + "   ( " + date + " )  <span style='font-size:17px; color:yellow;'>&nbsp;&nbsp; \\" + gamePrice.toLocaleString('en');
		}
		if(gamePrice == 0){
			gamePrice = '무료';
			document.getElementById("gameName").innerHTML = gameName + "   ( " + date + " )  <span style='font-size:17px; color:yellow;'>&nbsp;&nbsp; " + gamePrice.toLocaleString();
		}
		// 게임이미지
		document.getElementById("gameImage").src = gameImage;
		// 게임장르 넣기
		document.getElementById("tag1").href = "../tagDetail/" + category[0];
		document.getElementById("tag1").innerHTML = "# " + category[0];
		document.getElementById("tag2").href = "../tagDetail/" + category[1];
		document.getElementById("tag2").innerHTML = "# " + category[1];
		document.getElementById("tag3").href = "../tagDetail/" + category[2];
		document.getElementById("tag3").innerHTML = "# " + category[2];
		document.getElementById("tag4").href = "../tagDetail/" + category[3];
		document.getElementById("tag4").innerHTML = "# " + category[3];
		document.getElementById("tag5").href = "../tagDetail/" + category[4];
		document.getElementById("tag5").innerHTML = "# " + category[4];
		// 게임설명
		document.getElementById("gameContent").innerHTML = gameContent;
		// 게임점수
		if(gameScore === 0 && gameScore === 0.0){
			gameScore = 0;
		} 
		document.getElementById("gameScore").innerHTML = avgScore;
		
		
		// 중단부분 - (댓글삽입부분)
		var login = '${login}';
		console.log(login);
		var mbrName = '${login.mbrName}';
		console.log("중단부분 닉네임: " , mbrName);
		var mbrId = '${login.mbrId}';
		console.log(mbrId);
	
		// 회원닉네임
		document.getElementById("mbrName2").innerHTML = mbrName;
	}
	
</script>

</head>


<body>
	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	
	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
	<div class="wrapper">
		<!-- 상단 -->
		<section class="main-contents">
			<div class="gamename">
				<h1 id="gameName"></h1>
			</div>
			<div class="container">
				<div>
					<table class="topTable">
						<tr>
							<td rowspan="2" style="width: 250px;"><img class="gameImg" id="gameImage" src="" alt="게임 이미지"></td>
							<td class="tags">
								<table>
									<tr>
										<td><a href="../tagDetail/" class="tag" id="tag1"></a></td>
										<td><a href="../tagDetail/" class="tag" id="tag2"></a></td>
										<td><a href="../tagDetail/" class="tag" id="tag3"></a></td>
									</tr>
									<tr>
										<td><a href="../tagDetail/" class="tag" id="tag4"></a></td>
										<td><a href="../tagDetail/" class="tag" id="tag5"></a></td>
									</tr>
								</table>
							</td>
							<td rowspan="2"><div class="score" id="gameScore"></div></td>
						</tr>
						<tr>
							<td><p class="content" id="gameContent"></p></td>
						</tr>

					</table>
				</div>
			</div>
		</section>

		<!-- 중단 -->
		<%
			MemberDTO login =(MemberDTO)session.getAttribute("login");
	
			List<ReviewDTO> rdto = (List<ReviewDTO>) request.getAttribute("midPage");
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
						for (int i = 0; i < rdto.size(); i++) {
							ReviewDTO review = rdto.get(i);
							String id = "gameReviewLiked" + i;
							
							int reviewId = review.getReviewId();
							String update = "gameReviewContent" + reviewId;
					 %>
					 
					 	<table class="midTable">
						<tr>
							<td class="mbrName" id="mbrName"><%= review.getMbrName() %></td>
							<td class="review"><p id="<%= update %>" ><%= review.getReviewContent() %></p></td>
							<td class="meter"><meter min="0" max="100" value="<%= review.getReviewScore() %>"></meter><span id="gameScore"><%= review.getReviewScore() %></span></td>
							<td class="thumb"><img class="icon" src="<c:url value="/resources/Image/thumb.png" />" alt="추천수" data-login="<%= login.getMbrId()%>" data-num="<%= id %>" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>"><span id="<%=id%>"><%= review.getReviewLiked() %></span></td>
							
							<%
								if(login.getMbrName().equals(review.getMbrName())) {
							%>
							
							<td><button type="submit" class="upBtn" id="update" onclick="reviewUpdate();" data-reviewContent="<%= review.getReviewContent() %>" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">수정</button></td>
							<td><button type="submit" class="delBtn" id="delete" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">삭제</button></td>
							
							<%
								} else {
							%>
							<td><button type="submit" class="upBtn" id="update2" onclick="reviewUpdate();" data-reviewContent="<%= review.getReviewContent() %>" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">수정</button></td>
							<td><button type="submit" class="delBtn" id="delete2" data-reviewId="<%= review.getReviewId() %>" data-gameNo="<%= review.getGameNo() %>">삭제</button></td>
							<%
								}
							%>
						</tr>
						</table>
						
					<%				
							}
						} else {
							for (int i = 0; i < rdto.size(); i++) {
								ReviewDTO review = rdto.get(i);
								System.out.println("리뷰닉네임: " + review.getMbrName());
					%>
						
						<table class="midTable">
						<tr>
							<td class="mbrName" id="mbrName"><%= review.getMbrName() %></td>
							<td class="review"><p id="gameReviewContent"><%= review.getReviewContent() %></p></td>
							<td class="meter"><meter min="0" max="100" value="<%= review.getReviewScore() %>"></meter><span id="gameScore"><%= review.getReviewScore() %></span></td>
							<td class="thumb"><img class="icon" src="<c:url value="/resources/Image/thumb.png" />" alt="추천수"><span id="gameReplyRecommend"><%= review.getReviewLiked() %></span></td>
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
			    			
			    			<form action="../../loginCheck/reviewInsert">
							<input type="hidden" name="gameNo" value="${gameNo}">
							<input type="hidden" name="mbrId" value="${mbrId}">
							<input type="hidden" name="mbrName" value="${login.mbrName}">
							
							<table class="reviewTable">
								<tr>
									<td rowspan="3" class="mbrName" id="mbrName2"></td>
									<td rowspan="3" class="review">
									<textarea name="reviewContent" id="reviewContent" cols="80" rows="5" placeholder="내용을 입력해주세요"></textarea>
									</td>
									<td class="newmeter">0 <input type="range" name="reviewScore" id="newmeter" min="0" max="100" onclick="range()"> 100
									</td>
								<tr>
									<td><span id="reviewScore">50</span></td>
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
						List<GameDTO> relategame = (List<GameDTO>)request.getAttribute("botPage");
						for(int i = 0; i < relategame.size(); i++) {
							GameDTO relate = relategame.get(i);
							String gameNum = relate.getGameNo();
							String gamename = relate.getGameName();
							String gameImage = relate.getGameImage();
					%> 
						
							<td><a href="./<%= gameNum %>" ><img class="game" id="game1" src="<%= gameImage %>" alt="게임 이미지"></a></td>
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
							<td class="title" width="20%"><a href="./<%= gameNum %>" class="gametitle" id="title1"><%= gamename %></a></td>
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
