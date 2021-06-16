<%@ page import="com.dto.GameDTO"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<table width="100%" cellspacing="0" cellpadding="0">

	<tr>
		<td>
			<table align="center" width="710" cellspacing="0" cellpadding="0" border="0">
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
 <%-- <%
   List<GoodsDTO> list = (List<GoodsDTO>)request.getAttribute("goodsList");
 
   for(int i = 1; i <= list.size(); i++) {
	   GoodsDTO dto = list.get(i-1);
	   String gCode = dto.getgCode();
	   String gCategory = dto.getgCategory();
	   String gName = dto.getgName();
	   String gContent = dto.getgContent();
	   int gPrice = dto.getgPrice();
	   String gImage = dto.getgImage();
   
 %> --%>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
					<!-- 한줄에 4개씩 보여주기 -->	
				   <%-- <%
				    	if(i%4==0) {
				   %>
				       <tr>
				        <td height="10">
				       </tr>
				   <%
				    	} // end if
				   %>		 --%>
						
<%-- <%
   }//end for
%> --%>
				</tr>
				<tr>
				<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table style='padding:15px'>
								<tr>
									<td>
										<a href="#"> 
											<img src="${pageContext.request.contextPath}/Image/sampleGame.jpg" border="0" align="center" width="200">
										</a>
									</td>
								</tr>
					
								<tr>
									<td height="10">
								</tr>

								<tr>
									<td class= "td_default" align ="center">
										<a class= "a_black" href="#">After Alpha <br></a>
									</td>
								</tr>
								<tr>
									<td height="10">
								</tr>
								<tr>
									<td class="td_gray" align ="center">
										<p>아주아주 꿀잼인 게임 After Alpha 처음들어본 게임</p>
									</td>
								</tr>
							</table>
						</td>
				 
				</tr>
				
			</table>
		</td>
	</tr>
	<tr>
		<td height="10">
	</tr>
</table>