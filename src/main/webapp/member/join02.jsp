<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
	function validateForm(frm) {
		
		//아이디 검증
		if (frm.id.value == ''){
			alert("아이디를 입력하세요.");
			frm.id.focus();
			return false;
		}
		
		//아이디가 4~12자로 입력되었는지 검증
		//4~12자 사이가 아니라면
		if (!(4 <= frm.id.value.length && frm.id.value.length <= 12)){
			alert("아이디는 4~12자 사이만 입력 가능합니다.");
			frm.id.value = '';
			frm.id.focus();
			return false;
		}
		
		//아이디는 숫자로 시작할 수 없다.
		//아스키코드를 사용해서 입력한 아이디의 첫 문자를 확인한다.
		if (48 <= frm.id.value.charCodeAt(0) && frm.id.value.charCodeAt(0) <= 57){
			//console.log("입력한 아이디: " , frm.id.value, frm.id.value[0], charCodeAt(0));
			alert("아이디는 숫자로 시작할 수 없습니다.");
			frm.id.value = '';
			frm.id.focus();
			return false;
		}
		
		//아이디는 영문 + 숫자 조합으로만 사용할 수 있다.
		//아이디의 길이만큼 반복한다.
		for (var i=0 ; i<frm.id.value.length ; i++){
			if (!(('a' <= frm.id.value[i] && frm.id.value[i] <= 'z') ||
				('A' <= frm.id.value[i] && frm.id.value[i] <= 'Z') ||
				('0' <= frm.id.value[i] && frm.id.value[i] <= '9'))) {
				alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
				frm.id.value = '';
				frm.id.focus();
				return false;
			}
		}
		
		//비밀번호 입력했는지 확인
		if (frm.pass.value == ''){
			alert("비밀번호를 입력해주세요.");
			frm.pass.focus();
			return false;
		}
		
		//비밀번호는 4~12자만 가능하다.
		if (!(4 <= frm.pass.value.length && frm.pass.value.length <= 12)){
			alert("비밀번호는 4~12자 사이만 입력 가능합니다.");
			frm.pass.value = '';
			frm.pass.focus();
			return false;
		}
		
		//비밀번호는 영문 + 숫자 조합으로만 사용할 수 있다.
		//비밀번호의 길이만큼 반복한다.
		for (var i=0 ; i<frm.pass.value.length ; i++){
			if (!(('a' <= frm.pass.value[i] && frm.pass.value[i] <= 'z') ||
				('A' <= frm.pass.value[i] && frm.pass.value[i] <= 'Z') ||
				('0' <= frm.pass.value[i] && frm.pass.value[i] <= '9'))) {
				alert("비밀번호는 영문 및 숫자의 조합만 가능합니다.");
				frm.pass.value = '';
				frm.pass.focus();
				return false;
			}
		}
		
		
		//비밀번호 확인에 입력 값이 있는지 확인
		if (frm.pass2.value == ''){
			alert("비밀번호 확인을 입력해주세요.");
			frm.pass2.focus();
			return false;
		}
		
		//입력한 비밀번호의 값이 같지 않을때 경고창과 값을 지우고 포커스한다.
		if (frm.pass.value != frm.pass2.value){
			alert("비밀번호가 일치하지 않습니다.");
			frm.pass.value = '';
			frm.pass2.value = '';
			frm.pass.focus();
			return false;
		}
		
		//이름입력 확인
		if (frm.name.value == ''){
			alert("이름을 입력하세요.");
			frm.name.focus();
			return false;
		}
		
		//핸드폰 번호 입력란의 값에 대한 검증
		if (frm.mobile1.value == '' || frm.mobile2.value.value == '' || frm.mobile3.value == ''){
			alert("핸드폰 번호를 입력하세요.");
			frm.mobile1.focus();
			return false;
		}
		
		//이메일 입력란의 값에 대한 검증
		if (frm.email_1.value == '' || frm.email_2.value == ''){
			alert("이메일을 입력하세요.");
			frm.email_1.focus();
			return false;
		}
		
		//주소 입력란의 상세주소 입력 값에 대한 검증
		if (frm.addr2.value == ''){
			alert("상세주소를 적어주세요.");
			frm.addr2.focus();
			return false;
		}
		
	}
	
	//핸드폰 번호 입력란 포커스 이동
	function focusMove(thisObj, nextName, inputLen) {
		//입력한 문자의 길이
		var strLen = thisObj.value.length;
		//제한 길이가 넘어가는지 확인
		if (strLen >= inputLen){
			eval('document.myform.' + nextName).focus();
		}
	}
	
	//이메일 도메인 가져오기
	function email_input(frm) {
		//이메일의 도메인을 선택한 경우의 value값 가져오기
		var choiceDomain = frm.last_email_check2.value;
		
		//'선택해주세요'를 선택한 경우
		if (choiceDomain == ''){
			//입력한 모든 값을 지운다.
			frm.email_1.value = '';
			frm.email_2.value = '';
			//이메일 입력 첫번째 칸으로 포커스 이동한다.
			frm.email_1.focus();
		}
		//'직접입력'을 선택한 경우
		else if (choiceDomain == '직접입력'){
			//도메인에 입력된 값을 지운다.
			frm.email_2.value = '';
			//readOnly 속성을 false로 해제한다.
			frm.email_2.readOnly = false;
			//도메인 입력란으로 포커스 이동
			frm.email_2.focus();
		}
		//포털 도메인을 선택한 경우
		else {
			//선택한 도메인을 입력한다.
			frm.email_2.value = choiceDomain;
			//도메인 입력 후 수정 할 수 없게 한다.
			frm.email_2.readOnly = true;
		}
	}
	
</script>

<!-- 주소란 CDN -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function zipFind(){
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                console.log(data.zonecode);
                console.log(data.address);
                
                let frm = document.myform;
                frm.zipcode.value = data.zonecode;
                frm.addr1.value = data.address;
                frm.addr2.focus();
            }
        }).open();
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
				<form action="./joinAct.jsp" method="post" onsubmit="return validateForm(this)" name="myform">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;<a onclick="id_check_person(this.form);" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" onkeyup="focusMove(this, 'tel2', 3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" onkeyup="focusMove(this, 'tel3', 4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" onkeyup="focusMove(this, 'mobile1', 4);" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" onkeyup="focusMove(this, 'mobile2', 3);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" onkeyup="focusMove(this, 'mobile3', 4);" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" onkeyup="focusMove(this, 'email_1', 4);" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
							<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
							<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
							<select name="last_email_check2" onChange="email_input(this.form);" class="pass" id="last_email_check2" >
								<option selected="" value="">선택해주세요</option>
								<option value="직접입력" >직접입력</option>
								<option value="naver.com" >naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net" >hanmail.net</option>
								<option value="nate.com" >nate.com</option>
							</select>
			 
							<input type="checkbox" name="mailing" value="Y">
							<span>이메일 수신동의</span>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value=""  class="join_input" style="width:50px;" />&nbsp;&nbsp;
						<a href="javascript:;" title="새 창으로 열림" onclick="zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" placeholder="상세주소" />
						
						</td>
					</tr>
				</table>
				
				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
