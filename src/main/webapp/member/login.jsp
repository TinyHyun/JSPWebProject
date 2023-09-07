<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
//로그인 폼의 입력값을 검증
function validateForm(frm) {
	//아이디와 패스워드의 입력값에 대한 검증
	if (frm.id.value == ''){
		alert("아디이를 입력하세요.");
		frm.id.focus();
		return false;
	}
	
	if (frm.pass.value == ''){
		alert("패스워드를 입력하세요.");
		frm.pass.focus();
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
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				
				<!-- 로그인 -->
				<form action="../main/loginProcess.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this)" >
					<div class="login_box01" style="height: 230px;">
						<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
						<ul>
							<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="id" value="" class="login_input01" /></li>
							<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="pass" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/login_btn.gif" class="login_btn01" /></a>
					</div>
				</form>
				
				
				
				
				<p style="text-align:center; margin-bottom:50px;"><a href="./id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="./join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
