<%@page import="com.dto.BoardDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/CSS/BoardPage.css" rel="stylesheet">

		<%
        	int boardId = Integer.parseInt(request.getParameter("boardId"));
        	System.out.println("boardID jsp:" + boardId);
        	
        %>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function range() {

		var x = document.getElementById("newmeter").value;
		document.getElementById("reviewScore").innerHTML = x;

	}
	
	window.onload = function(){
		var boardId = "<%= boardId %>";
		 $.ajax({
		        url:'BoardDetailServlet',
		        type: 'get',
		        dataType:'json',
		        data: {boardId : boardId}
		 		,
		        success :  function(data, status, xhr){
					console.log("ajax: " + data);	  
					var board = JSON.parse(data[0]);
					console.log(board.boardContent);
					$("#boardCategory").text(board.boardCategory);
					$("#boardContent").text(board.boardContent);
					$("#boardName").text(board.boardName);
					$("#boardDate").text("[ " + board.boardDate + " ]");
					$("#mbrName").text(board.mbrName);
		        },
		        error : function(xhr, status, error) {
					console.log(error);
					
				}
		    });	
	}; 
</script>

</head>
<body>

	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
    <div class="wrapper">
    
        <section class="main-contents">
        
        
        <h3 id="boardCategory"></h3>
        <h1 id="boardName"></h1>
        <span id="boardDate">[]</span>
        <span id="mbrName"></span>
        <hr>
        <span id="replyCount">344</span>
        <img class="img" alt="댓글" src="${pageContext.request.contextPath}/Image/reply.png">
        <span id="boardLiked"></span>
        <img class="img" alt="좋아요" src="${pageContext.request.contextPath}/Image/thumb.png">
        <span id="boardCount"></span>
        <img class="img" alt="조회수" src="${pageContext.request.contextPath}/Image/eye.png">
        <br>
        
        <!-- 게시글 -->
        <div class="content">
			<p id="boardContent"></p>
		</div>
		
		<!-- 좋아요 -->
		<div class="button_good">
			<button id="likedbtn"></button>
		</div>
		
		<%
			MemberDTO mdto =(MemberDTO)session.getAttribute("login");
			String login_mbrName = mdto.getMbrName();
			//if(mbrName.contentEquals(login_mbrName)) {
		%>
		<div class="boardbutton">
			<button type="submit" class="boardbtn" id="boardupdate" onclick = "location.href='${pageContext.request.contextPath}/Board/updateBoard.jsp?boardId=<%=boardId%>'">수정</button>		
			<button type="submit" class="boardbtn" name="boardKind" id="boarddelete" value="boardDelete">삭제</button>
		</div>
		<%
			//}
		%>
			
		
	</section>
       
       
       
	<section class="review-contents">
		<div>
		<h1 id="boardReview">댓글</h1>
		<hr>
	    	<table class="midTable">
						<tr>
							<td class="mbrName" id="mbrName">닉네임 뭐로하지</td>
							<td class="review"><p id="gameReplyContent">만약 같이 할 사람이 있고 할만한 게임을 찾고 계시다면 꼭 사셔서 해보시길 바랍니다. 시간 가는 줄 모르고 즐겼습니다. 아직 초반이지만 엔딩까지가 너무 기대되고 플레이 하는 내내 웃으면서 즐겼습니다.</p></td>
							<td class="meter"><meter min="0" max="100" value="75.1"></meter><span id="gameScore">75.1</span></td>
							<td class="thumb"><img class="icon" src="${pageContext.request.contextPath}/Image/thumb.png" alt="추천수"><span id="gameReplyRecommend">12</span></td>
							<td><button class="btn" type="submit" id="update">수정</button></td>
							<td><button class="btn" type="submit" id="delete">삭제</button></td>
						</tr>
						<tr>
							<td class="mbrName" id="mbrName">Samlple_user</td>
							<td class="review"><p id="gameReplyContent">겜은 샀고, 친구는 어디서 사면 되나요?</p></td>
							<td class="meter"><meter min="0" max="100" value="98.5"></meter><span id="gameScore">98.5</span></td>
							<td class="thumb"><img class="icon" src="${pageContext.request.contextPath}/Image/thumb.png" alt="추천수"><span id="gameReplyRecommend">10</span></td>
							<td><button class="btn" type="submit" id="update">수정</button></td>
							<td><button class="btn" type="submit" id="delete">삭제</button></td>
						</tr>
					</table>
					
					<hr>
					
					<!-- 댓글 삽입  -->
					<%
					
						MemberDTO reply_mdto =(MemberDTO)session.getAttribute("login");
						
						String name = "로그인해주세요";
			    		if(reply_mdto != null ){
			    			name =  reply_mdto.getMbrName();
			    		} else if(reply_mdto == null) {
					%>
					<script>
					    function click() {
							alert("로그인하고 작성하세요!");
						}
					</script>
					<%
			    		}
			    		
					%>
					<form action="">
						<table class="reviewTable">
							<tr>
								<td rowspan="3" class="replymbrName" id="replymbrName"><%= name %></td>
								<td rowspan="3" class="review">
									<textarea name="reviewContent" id="gameReplyContent" cols="80" rows="5" placeholder=" 내용을 입력해주세요"></textarea>
								</td>
								<td class="newmeter">0 <input type="range" name="reviewScore" id="newmeter" min="0" max="100" onclick="range()"> 100
								</td>
							</tr>
							<tr>
								<td><span id="reviewScore">0</span></td>
							</tr>
							<tr>
								<td><button type="submit" class="btn" id="submit" onclick="click();">올리기</button></td>
							</tr>
							
							
						</table>
					</form>
		</div>
		</section>
	</div>
	
	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>

    
</body>
</html>