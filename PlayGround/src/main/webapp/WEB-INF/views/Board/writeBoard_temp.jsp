<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write Board</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/resources/CSS/WriteBoard.css?v=<%=System.currentTimeMillis() %>" />" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>   
<!-- 스타일관련 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.css" rel="stylesheet">
<!-- 자바스크립트관련 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/summernote.js"></script>
<!-- 한글관련 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.6/lang/summernote-ko-KR.min.js"></script>

<script>
    $(document).ready(function() {
        $('#boardContent').summernote({
            lang: 'ko-KR',
            height: 500,
        })
    })
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
        <h1>게시글 작성</h1>
        <hr>
        <div class="container">
		<form class="boardwrite" action="../BoardModifyServlet" method="post">
			
			<select class="select_category" name="boardCategory" id="boardCategory" >
				<option value="common">일반글</option>
				<option value="info">게임정보</option>
				<option value="sales">할인정보</option>
				<option value="QnA">QnA</option>
			</select>

			<input type="text" name="boardName" id="boardName" placeholder="제목" ><br>
			
			<div class="write">
        		<textarea name="boardContent" id="boardContent" cols="30" rows="10" class="form-control"></textarea>
   			</div>
			
			<button type="submit" name="boardKind" id="boardsubmit" value="boardInsert">제출</button>
			<button type="reset" name="boardreset" id="boardreset">다시쓰기</button>
				
		</form>
		</div>
        </section>
        
	</div>
		
	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>
	
</body>
</html>