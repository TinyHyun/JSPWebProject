<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//폼값 받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String tel = request.getParameter("tel1") 
			+ "-" + request.getParameter("tel2") 
			+ "-" + request.getParameter("tel3");
String mobile = request.getParameter("mobile1")
				+ "-" + request.getParameter("mobile2")
				+ "-" + request.getParameter("mobile3");
String email = request.getParameter("email_1") + "@" + request.getParameter("email_2");
String mailing = request.getParameter("mailing");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");


//DTO 객체에 저장하기
MemberDTO dto = new MemberDTO();
dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setMailing(mailing);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);


//DAO 객체 생성 및 insert처리+
MemberDAO dao = new MemberDAO(application);
int result = dao.registInsert(dto);
if (result == 1) {
	JSFunction.alertLocation("회원가입이 완료되었습니다.", "login.jsp", out);
}
else {
%>

<script>
	alert('회원가입에 실패했습니다.');
	//history.back();
	history.go(-1);
</script>
<%
}
%>



























