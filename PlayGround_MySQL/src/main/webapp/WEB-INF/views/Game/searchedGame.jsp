<%@page import="com.dto.GameDTO"%>
<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
<table width="100%" cellspacing="0" cellpadding="0">
<tr>
		<td>
			<table align="center" width="710" cellspacing="0" cellpadding="0"
				border="0">
				<tr>
					<td height="5"></td>
				</tr>
				<tr>
					<td height="1" colspan="8" bgcolor="CECECE"></td>
				</tr>
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
				<!-- request에서 데이터 얻은 후  모든 멤버변수를 변수에 저장  후 표에 출력해줌-->				
				<%
				    List<GameDTO> list = (List<GameDTO>)request.getAttribute("tagDetail");
				    for(int i=1;i<=list.size();i++){
				    	GameDTO dto = list.get(i-1);
				/*     	ReviewDTO dto2 = list.get(i-1); */
				    	String gameNo = dto.getGameNo();
				    	String gameCategory = dto.getGameCategory();
				    	String gameImage = dto.getGameImage();
				    	String gameName = dto.getGameName();
				    	String gameGenre = dto.getGameGenre();
				    	String gameReleasedDate = dto.getGameReleasedDate();
				 %>
					<td>
						<table style="border:1px solid black; padding:10px" width="300">
							<tr>
								<td colspan="2" align="center" style="border-bottom:1px solid black">
									<a href="../detailPage/<%=gameNo %>"><!-- 이미지링크 --> 
										<img src="<%=gameImage %>" border="0" width="290" height="130">
									</a>
								</td>
							</tr>
							<tr>
								<td colspan="2" class= "td_default" style="text-align:left;vertical-align:top;border-bottom:1px solid black" height="55">
									<a class= "a_black" href="../detailPage/<%=gameNo %>"> 
										<strong><%= gameName%></strong><br>
									</a>
								</td>
							</tr>
<!-- 							<tr>
								<td class="td_blue" align ="left" style="border-right:1px solid black">
									평점 : <font color="red">gameScore</font>
								</td>
								<td class="td_blue" align ="right">
									새글 : 1
								</td>
							</tr> -->
							<tr>
								<td colspan="2" class="td_gray" align ="left" height="55" style="border-top:1px solid black">
									장르 : <%= gameGenre%>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="td_red" align ="right">
									<strong>출시일 : <%= gameReleasedDate%></strong>
								</td>
							</tr>
						</table>
					</td>
				<!-- 한줄에 4개씩 보여주기 -->
				<%
					if(i%4==0){
				%>
				<tr>
					<td height="10">
				</tr>
				<%
					}//end if
    }//end for
%>
			</table>
</body>
</html>
