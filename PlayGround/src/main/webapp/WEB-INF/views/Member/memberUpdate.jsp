<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link href="${pageContext.request.contextPath}/CSS/MemberUpdate.css" rel="stylesheet">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

		function result() {
			var check = document.getElementsByName("tag");
			var mesg ="";
			
            for (var i = 0; i < check.length; i++) {
            	 if (check[i].checked) {
              	   mesg += "," + check[i].value;
              	 }
            }
            mesg = mesg.substring(1); 
            document.getElementById("mbrGenre").value=mesg;
            document.getElementById("genre").innerText=mesg;
		}
		
		/* function click() {
			const query = 'input[name="tag"]:checked';
			const select = document.querySelectorAll(query);
			
			var result = '';
			select.forEach((el) => {
				result += "," +el.value;
			});
			result = result.subString(1);
			
			document.getElementById("mbrGenre").value=result;
            document.getElementById("genre").innerText=result;
		} */
		
		function check() {
			
			// 비밀번호 체크
			var mbrPw = document.updateForm.mbrPw.value;
			if(mbrPw.length==0) {
				swal("Oops!!", "비밀번호를 작성해주세요", "error");
				document.updateForm.mbrPw.focus();
				event.preventDefault();
			} else if(mbrPw.length<6){
				swal("Oops!!", "비밀번호는 6글자 이상만 이용 가능합니다!", "error");
				document.updateForm.mbrPw.focus();
				event.preventDefault();
			}
			
			// 닉네임 체크
			var mbrName = document.updateForm.mbrName.value;
			if(mbrName.length==0) {
				swal("Oops!!", "닉네임을 작성해주세요", "error");
				document.updateForm.mbrName.focus();
				event.preventDefault();
			}
			
			// 이메일 체크
			var mbrEmail = document.updateForm.mbrEmail.value;
			if(mbrEmail.length==0) {
				swal("Oops!!", "이메일을 작성해주세요", "error");
				document.updateForm.mbrEmail.focus();
				event.preventDefault();
			}
			
		}

		
</script>
</head>

<body>

	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	
	<% 
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
	    String mbrId = dto.getMbrId();
	    String mbrName = dto.getMbrName();
	    String mbrPw = dto.getMbrPw();
	    String mbrEmail = dto.getMbrEmail();
	    String mbrGenre = dto.getMbrGenre();
	    String mbrRegdate = dto.getMbrRegdate();
	    
	    System.out.println("memberUpdate.jsp: "+dto.toString());
	%>
	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
    <div class="wrapper">
		<h2>회원정보 수정</h2>
		<!-- 상단 -->
        <section class="main-contents">
        
			<form action="loginCheck/memberUpdate" name="updateForm" method="post">
			
				<div class="member">아이디 &nbsp;&nbsp;&nbsp; <%=mbrId%>
				<input type="hidden" class="mbrinfo" value="<%=mbrId%>" name="mbrId" id="mbrId" style="border:none;">
                </div>
				
				<div class="member">비밀번호 &nbsp;&nbsp;&nbsp;
				<input type="text" class="mbrinfo" value="" name="mbrPw" id="mbrPw">
				</div><br>
				
				<div class="member">닉네임 &nbsp;&nbsp;&nbsp;
				<input type="text" class="mbrinfo" value="<%= mbrName %>" name="mbrName" id="mbrName">
				</div><br>
				
				<div class="member">이메일 &nbsp;&nbsp;&nbsp;
				<input type="email" class="mbrinfo" value="<%= mbrEmail %>" name="mbrEmail" id="mbrEmail">
				</div><br>
				
				<div class="member">
					선호장르
					<button onclick="result(); return false;">선택완료</button><br>
					<span id="genre"></span>
					<input type="hidden" name="mbrGenre" id="mbrGenre"  class="content">
					
					<table border="1">
						<tr>
							<td>
							<input type="checkbox" name="tag" id="tag1" value="레이싱">
							<label for="tag1">&nbsp;레이싱</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag2" value="생존" >
							<label for="tag2">&nbsp;생존</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag3" value="슈팅" >
							<label for="tag3">&nbsp;슈팅</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag4" value="스포츠" >
							<label for="tag4">&nbsp;스포츠</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag5"	value="시뮬레이션" >
							<label for="tag5">&nbsp;시뮬레이션</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag6" value="액션" >
							<label for="tag6">&nbsp;액션</label>
							</td>
						</tr>
						
						<tr>
							<td>
							<input type="checkbox" name="tag" id="tag7" value="어드밴처">
							<label for="tag7">&nbsp;어드밴처</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag8" value="오프월드">
							<label for="tag8">&nbsp;오프월드</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag9" value="음악">
							<label for="tag9">&nbsp;음악</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag10" value="전략">
							<label for="tag10">&nbsp;전략</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag11" value="전쟁">
							<label for="tag11">&nbsp;전쟁</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag12" value="캐쥬얼">
							<label for="tag12">&nbsp;캐쥬얼</label>
							</td>
						</tr>
						
						<tr>
							<td>
							<input type="checkbox" name="tag" id="tag13" value="모험">
							<label for="tag13">&nbsp;모험</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag14" value="판타지">
							<label for="tag14">&nbsp;판타지</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag15" value="퍼즐">
							<label for="tag15">&nbsp;퍼즐</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag16" value="롤플레잉">
							<label for="tag16">&nbsp;롤플레잉</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag17" value="공상과학">
							<label for="tag17">&nbsp;공상과학</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag18" value="턴제전략">
							<label for="tag18">&nbsp;턴제전략</label>
							</td>
						</tr>
						
						<tr>
							<td>
							<input type="checkbox" name="tag" id="tag19" value="협동" onclick="click()">
							<label for="tag19">&nbsp;협동</label></td>
							<td>
							<input type="checkbox" name="tag" id="tag20" value="애니" onclick="click()">
							<label for="tag20">&nbsp;애니</label></td>
							<td>
							<input type="checkbox" name="tag" id="tag21" value="어려움" onclick="click()">
							<label for="tag21">&nbsp;어려움</label></td>
							<td>
							<input type="checkbox" name="tag" id="tag22" value="카드배틀" onclick="click()">
							<label for="tag22">&nbsp;카드배틀</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag23"value="인디게임" onclick="click()">
							<label for="tag23">&nbsp;인디게임</label>
							</td>
							<td>
							<input type="checkbox" name="tag" id="tag24" value="경영" onclick="click()">
							<label for="tag24">&nbsp;경영</label>
							</td>
						</tr>
					</table>
				</div>
					<button type="submit" onclick="check();">확인</button>
					<button type="reset">취소</button>
			</form>

		</section>

	</div>	
	
	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>
	
</body>
</html>