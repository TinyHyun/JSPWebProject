<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
/////아이디 찾기/////
function idSearch(frm) {
	
	//회원이름 입력값에 대한 검증
	if (frm.name.value == ''){
		alert("회원님의 이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	
	//이메일 입력값에 대한 검증
	if (frm.email.value == ''){
		alert("이메일을 입력해주세요.");
		frm.email.focus();
		return false;
	}
	
}

/////비번찾기///////
function pwSearch(frm) {
	
	
	//아이디 입력값에 대한 검증
	if (frm.id.value == ''){
		alert("아이디를 입력해주세요.");
		frm.id.focus();
		return false;
	}
	
	//회원이름 입력값에 대한 검증
	if (frm.name.value == ''){
		alert("회원님의 이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	
	//이메일 입력값에 대한 검증
	if (frm.email.value == ''){
		alert("이메일을 입력해주세요.");
		frm.email.focus();
		return false;
	}
	
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form action="./idSearch.jsp" method="post" name="id_search" onsubmit="return idSearch(this)">
						<ul style="left: 70px;">
							<li><input type="text" name="name" value="" class="login_input01" /></li>
							<li><input type="text" name="email" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="id_btn" style="left: 270px;" /></a>
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</form>
					</div>
					<div class="pw_box">
					<form action="./pwSearch.jsp" method="post" name="pw_search" onsubmit="return pwSearch(this)">
						<ul style="left: 70px;">
							<li><input type="text" name="id" value="" class="login_input01" /></li>
							<li><input type="text" name="name" value="" class="login_input01" /></li>
							<li><input type="text" name="email" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="pw_btn" style="left: 270px; top:100px;" /></a>
					</div>
					</form>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
