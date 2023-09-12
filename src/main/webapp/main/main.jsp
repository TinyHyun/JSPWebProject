<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
</head>

<script>
//로그인 폼의 입력값을 검증
function validateForm(frm) {
	//아이디와 패스워드의 입력값에 대한 검증
	if (!frm.id.value){
		alert("아디이를 입력하세요.");
		frm.id.focus();
		return false;
	}
	
	if (!frm.pass.value){
		alert("패스워드를 입력하세요.");
		frm.pass.focus();
		return false;
	}
}
</script>

<%
String saveId = CookieManager.readCookie(request, "saveId");

String cookieCheck = "";

if (!saveId.equals("")){
	cookieCheck = "checked";
}
%>

<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
				<div class="login_box">
					<!-- 로그인 전 -->
					<%
					if (session.getAttribute("id") == null){
					%>
					
					<!-- 로그인 폼 -->
					<form action="./loginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this)" >
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" name="id" value="<%= saveId %>" class="login_input" /></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" /></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="password" name="pass" value="" class="login_input" /></td>
						</tr>
					</table>
					<p>
						<input type="checkbox" name="save_id" value="Y" <%= cookieCheck %> /><img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					</form>
					<%
					}
					else {
					%>
					<!-- 로그인 후 -->
					<p style="padding:10px 0px 10px 10px">
						<span style="font-weight:bold; color:#333;">
						<%= session.getAttribute("name") %>님,
						</span> 반갑습니다.
						<br />
						로그인 하셨습니다.
					</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="../images/login_btn04.gif" /></a>
						<a href="./logOut.jsp" onclick="return confirm('로그아웃을 하시겠습니까?');" ><img src="../images/login_btn05.gif" /></a>
					</p>
			 		<%
					}
			 		%>
				</div>
			</div>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="../space/sub01List.jsp?tname=board"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<c:forEach items="${ notice }" var="row">
						<li>
							<p style="width: 230px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
								<a href="../space/sub01View.jsp?tname=board&num=${ row.num }">${ row.title }</a>
								<span>${ row.postdate }</span>
							</p>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="../space/sub01List.jsp?tname=freeboard"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<c:forEach items="${ free }" var="dto">
					<li>
						<p style="width: 230px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
							<a href="../space/sub01View.jsp?tname=freeboard&num=${ dto.num }">${ dto.title }</a>
							<span>${ dto.postdate }</span>
						</p>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<iframe src="https://calendar.google.com/calendar/embed?src=tnslwkd1229%40gmail.com&ctz=Asia%2FSeoul" style="border: 0" width="350" height="250" frameborder="0" scrolling="no"></iframe>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="../space/sub01List.jsp?tname=photoboard"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
					<c:forEach items="${ photo }" var="photo">
					<li>
						<p style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
							<a href="../controller/photoView.tj?tname=photoboard&num=${ photo.num }"><img style="margin-left: 4px; width: 94%; height: 100px;" src="../Uploads/${ photo.sfile }" alt="" /></a>
						</p>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>