<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link href="${pageContext.request.contextPath}/CSS/MemberUpdate.css" rel="stylesheet">

<%
MemberDTO dto = (MemberDTO) session.getAttribute("login");
String loginId = dto.getMbrId();
String loginPw = dto.getMbrPw();
%>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#deleteCheck").click(function(event) {
			// 아이디 & 비밀번호 입력 검사
			var loginId= "<%=loginId%>";
			var loginPw= "<%=loginPw%>";

							var mbrId = $("#mbrId").val();
							var mbrPw = $("#mbrPw").val();

							if (loginId != mbrId) { //ID 동일한지 확인
								swal("Oops!!", "ID를 다시 입력해주세요!", "error");
								$("input:checkbox[id='deleteCheck']").prop(
										"checked", false);
								event.preventDefault();
							} else if (loginPw != mbrPw) { //PW 동일한지 확인
								swal("Oops!!", "PASSWORD를 다시 입력해주세요!", "error");
								$("input:checkbox[id='deleteCheck']").prop(
										"checked", false);
								event.preventDefault();
							} else { //ID && PW 동일: 입력값 변경 불가
								swal("삭제 가능!!",
										"회원 탈퇴를 원하시면 아래의 [확인]버튼을 눌러주세요!\n입력값 변경이 불가하오니, 변경을 원할 시, 취소버튼을 클릭해주세요");
								/*@@@@@@@@@@@@@@@@@@@이 부분 초록색 체크 표시 아이콘 뜨게 해주세요 @@@@@@@@@@@@@@@@@@@ */
								$("#mbrId").prop('readonly', true);
								$("#mbrPw").prop('readonly', true);
							}
						}) //end click event

		// 확인 버튼 누를시, 체크박스 클릭되어있는지 확인
		$("form").submit(
				function(event) {
					if ($('#deleteCheck').is(':checked')) { //체크 되어있을 경우
						alert("회원 탈퇴 하셨습니다.\n서비스를 이용하기 위해서는 새로 로그인 해주십시오.");
					} else { // 체크 되어있지 않은 경우
						swal("Oops!!",
								"회원 탈퇴를 위해서는 아이디, 비밀번호를 입력하시고, 체크박스를 눌러주세요. ",
								"error");
						$("input:checkbox[id='deleteCheck']").prop("checked",
								false);
						event.preventDefault();
					}
				})//end submit 

		//취소버튼 눌러있을때, 만약 입력값이 변경 불가가 되어있을 경우, 입력가능하게 설정 변경.
		$("#resetBtn").click(function(Event) {
			$("#mbrId").prop('readonly', false);
			$("#mbrPw").prop('readonly', false);
		})

	}); // end ready
</script>
</head>

<body>

	<!-- 페이지 상단 로고 및 배너 -->
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>


	<!-- 메인화면 컨텐츠-->
	<!-- 안의 내용은 데이터 받아오면 변경 예정 -->
	<div class="wrapper">
		<h2>회원 탈퇴</h2>
		<!-- 상단 -->
		<section class="main-contents">

			<form action="../MemberDeleteServlet" name="deleteForm" method="post">

				<div class="row" style="display: inline;">
					<span class="title">아이디 * </span> <input type="text" class="content" name="mbrId" id="mbrId" autofocus>
				</div>

				<div class="row">
					<span class="title">비밀번호 *</span> <input type="text" class="content" name="mbrPw" id="mbrPw" autocomplete="off" placeholder="비밀번호를 입력해주세요">
				</div>


				<input type="checkbox" name="deleteCheck" id="deleteCheck">정말 삭제하시겠습니까?<br> <br> 체크 박스를 눌러야, 회원 삭제를 할 수 있습니다. <br>
				<button type="submit">확인</button>
				<button type="reset" id="resetBtn">취소</button>

			</form>

		</section>

	</div>

	<!-- 페이지 최하단 배너 -->
	<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>

</body>
</html>