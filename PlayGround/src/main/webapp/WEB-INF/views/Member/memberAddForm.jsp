<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Image/gameLogo.png" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/MemberAdd.css">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#idchk").on("click", function() {
			$.ajax({
				url : 'idDuplicateCheck',
				type : 'get',
				data : {
					id : $("#mbrId").val(),
				},
				dataType : "text",
				success : function(data, status, xhr) {
					$("#result").text(data);
				},
				error : function(xhr, status, error) {
				}
			});//end ajax
		});//end on

		// 아이디 ,비밀번호 체크
		$("form").on("submit", function() {

			var mbrId = $("#mbrId");
			var mbrPw = $("#mbrPw");
			var mbrPw2 = $("#mbrPw2");

			if (mbrId.val().length == 0) {
				swal("Oops!!", "ID를 다시 입력해주세요!", "error");
				mbrId.focus();
				event.preventDefault();
			} else if (mbrPw.val().length == 0) {
				swal("Oops!!", "PASSWORD를 다시 입력해주세요!", "error");
				mbrPw.focus();
				event.preventDefault();
			}
			// 비밀번호 / 비밀번호 일치하지 않는 경우
			if (mbrPw.val() != mbrPw2.val()) {
				swal("Oops!!", "PASSWORD가 일치하지 않습니다! 다시 확인해주세요!", "error");
				mbrPw.focus();
				event.preventDefault();
			}

		});

		// 비밀번호 숫자 제한(6자리)
		$("#mbrPw").focusout(function() {
			var passwd1 = $("#mbrPw").val();
			if (passwd1.length < 6) {
				swal("Oops!!", "비밀번호는 6글자 이상만 이용 가능합니다!", "error");
				$("#mbrPw").value = null;
				event.preventDefault();
			}
		});

		// 비밀번호 확인
		$("#mbrPw2").on("mouseout", function() {
			var mbrPw = $("#mbrPw").val();
			var mbrPw2 = $("#mbrPw2").val();

			if (mbrPw == mbrPw2) {
				swal("Good!!", "비밀번호가 일치합니다!", "success");
			} else {
				swal("Oops!!", "비밀번호가 일치하지 않습니다. 다시 입력해주세요!", "error");
			}
		});
	});

	// 태그페이지 넘어가기
	var tagPage;
	function tag() {
		console.log("tagPage!!");
		tagPage = window
				.open("${pageContext.request.contextPath}/Member/tagPage.jsp",
						"",
						"width=200,height=300,left=700,top=650,scrollbars=1,location=no,resizable=no");
	}
</script>

<!--나오는 값: 아이디,비빌번호, 비밀번호 확인, 닉네임, 이메일 , 가입일자 (안보이는 값으로)   -->

<form action="memberAdd" method="post" class="addForm" id="addForm">
	<a href="${pageContext.request.contextPath}/Main.jsp"><img src="${pageContext.request.contextPath}/Image/logo.png"></a>
	<h2>회원가입</h2>
	<div class="contentform">

		<div class="row" style="display: inline;">
			<span class="title">아이디 *
				<button id="idchk" class="idchk">중복체크</button>
			</span> <input type="text" class="content" name="mbrId" id="mbrId" autofocus> <span id="result"></span>
		</div>

		<div class="row">
			<span class="title">비밀번호 *</span> <input type="text" class="content" name="mbrPw" id="mbrPw" autocomplete="off" placeholder=" 비밀번호는 6자리 이상이어야 합니다.">
		</div>

		<div class="row" style="display: inline;">
			<span class="title">비밀번호 확인 * <span id="pwcheck"></span>
			</span> <input type="text" class="content" name="mbrPw2" id="mbrPw2">
		</div>

		<div class="row">
			<span class="title">닉네임 *</span> <input type="text" class="content" name="mbrName" id="mbrName">
		</div>

		<div class="row">
			<span class="title">이메일 *</span> <input type="email" class="content" name="mbrEmail" id="mbrEmail">
		</div>

		<div class="row">
			<span class="title" id="tagname">태그</span>
			<button name="mbrGenre" id="tagbtn" onclick="tag(); return false;">Tag</button>
			<input type="text" name="mbrGenre" id="mbrGenre" class="content">
		</div>

		<div class="button">
			<input type="submit" value="제 출">
		</div>

	</div>

</form>





