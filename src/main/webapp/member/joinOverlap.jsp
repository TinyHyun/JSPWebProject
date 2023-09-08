<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//중복 확인 팝업 창으로 전달되는 아이디를 받는다.
String id = request.getParameter("id");

//중복된 아이디가 없으면 true를 반환 / 중복된 아이디가 있으면 false를 반환
MemberDAO dao = new MemberDAO(application);
boolean isExist = dao.idOverlap(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
//재입력한 아이디를 부모창으로 전송
function idUse() {
	//opener 속성을 통해 부모창의 DOM을 선택 할 수 있다.
	//사용하능한 아이디를 부모창으로 전송
	opener.document.myform.id.value = document.overlapFrm.retype_id.value;
	//팝업창을 닫는다.
	self.close();
}
</script>
</head>
<body>
	<h2>아이디 중복 확인</h2>
	<div>
		입력한 아이디: <%= id %>
		<%
		if (isExist == true){
		%>
		<p>
			사용 가능한 아이디입니다.
			<br />
			<input type="button" value="아이디 사용하기" onclick="idUse();" />
		</p>
		<form name="overlapFrm">
			<input type="hidden" name="retype_id" value="<%= id %>" />
		</form>
		<%
		}
		else{
		%>
		<p>
			사용할 수 없는 아이디입니다.
			<br />
			아이디를 다시 입력하세요.
		</p>
		<form name="overlapFrm">
			<input type="text" name="id" size="20" />
			<input type="submit" value="아이디 중복확인" />
		</form>
		<%
		}
		%>
	</div>
</body>
</html>



















