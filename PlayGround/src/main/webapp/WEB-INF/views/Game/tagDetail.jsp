<%@page import="com.dto.GameDTO"%>
<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    List<GameDTO> list = (List<GameDTO>)request.getAttribute("tagDetailSelect");
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
							<table style='padding:5px'>
								<tr>
									<td>
										<a href="GameDetailServlet?gameNo=<%=gameNo %>"><!-- 이미지링크 --> 
											<img src="<%=gameImage %>" border="0" align="center" width="290" height="135">
										</a>
									</td>
								</tr>
								<tr>
								
									<td height="10">
								</tr>
								<tr>
									<td class= "td_default" align ="left">
										<a class= "a_black" href=""> 
										<%= gameName%><br>
										</a>
									</td>
									
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="left">
										장르 : <%= gameGenre%>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_red" align ="right"><strong>
									출시일 : <%= gameReleasedDate%>	</strong></td>
								</tr>
							</table>
						</td>
					<!-- 한줄에 4개씩 보여주기 -->	
				   <%
				      if(i%4==0){
				   %>
				       <tr>
				        <td height="30">
				       </tr>
				   <%
				      }//end if
				   %>		
						
<%
    }//end for
%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="10">
	</tr>
</table>
