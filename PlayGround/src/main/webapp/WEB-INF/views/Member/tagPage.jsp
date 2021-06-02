<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../CSS/TagPage.css">
<title>TagPage</title>

 <script type="text/javascript">
		function result() {
            var tagCheck= document.getElementsByName("tag"); //전부다 가져옴
            var mesg="";
            console.log(tagCheck)
            for (var i = 0; i < tagCheck.length; i++) {
                   if (tagCheck[i].checked) 
                	   mesg += "," + tagCheck[i].value
            }
            mesg = mesg.substring(1);
            
            opener.document.getElementById("mbrGenre").value=mesg;
			window.close();		
		}
	</script>
</head>
<body>
<input type="checkbox" name="tag" id="tag1" value="레이싱"><label for="tag1">레이싱</label><br>
<input type="checkbox" name="tag" id="tag2" value="생존"><label for="tag2">생존</label><br>
<input type="checkbox" name="tag" id="tag3" value="슈팅"><label for="tag3">슈팅</label><br>
<input type="checkbox" name="tag" id="tag4" value="스포츠"><label for="tag4">스포츠</label><br>
<input type="checkbox" name="tag" id="tag5" value="시뮬레이션"><label for="tag5">시뮬레이션</label><br>
<input type="checkbox" name="tag" id="tag6" value="액션"><label for="tag6">액션</label><br>
<input type="checkbox" name="tag" id="tag7" value="어드밴처"><label for="tag7">어드밴처</label><br>
<input type="checkbox" name="tag" id="tag8" value="오프월드"><label for="tag8">오프월드</label><br>
<input type="checkbox" name="tag" id="tag9" value="음악"><label for="tag9">음악</label><br>
<input type="checkbox" name="tag" id="tag10" value="전략"><label for="tag10">전략</label><br>
<input type="checkbox" name="tag" id="tag11" value="전쟁"><label for="tag11">전쟁</label><br>
<input type="checkbox" name="tag" id="tag12" value="캐쥬얼"><label for="tag12">캐쥬얼</label><br>
<input type="checkbox" name="tag" id="tag13" value="모함"><label for="tag13">모함</label><br>
<input type="checkbox" name="tag" id="tag14" value="판타지"><label for="tag14">판타지</label><br>
<input type="checkbox" name="tag" id="tag15" value="퍼즐"><label for="tag15">퍼즐</label><br>
<input type="checkbox" name="tag" id="tag16" value="롤플레잉"><label for="tag16">롤플레잉</label><br>
<input type="checkbox" name="tag" id="tag17" value="공상과학"><label for="tag17">공상과학</label><br>
<input type="checkbox" name="tag" id="tag18" value="턴제전략"><label for="tag18">턴제전략</label><br>
<input type="checkbox" name="tag" id="tag19" value="협동"><label for="tag19">협동</label><br>
<input type="checkbox" name="tag" id="tag20" value="애니"><label for="tag20">애니</label><br>
<input type="checkbox" name="tag" id="tag21" value="어려움"><label for="tag21">어려움</label><br>
<input type="checkbox" name="tag" id="tag22" value="카드배틀"><label for="tag22">카드배틀</label><br>
<input type="checkbox" name="tag" id="tag23" value="인디게임"><label for="tag23">인디게임</label><br>
<input type="checkbox" name="tag" id="tag24" value="경영"><label for="tag24">경영</label><br>

<button onclick="result()">확 인</button>


</body>
</html>