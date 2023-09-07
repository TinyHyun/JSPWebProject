<%@page import="utils.JSFunction"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");

//출력결과가 Console에 나온다.
System.out.println(id + "=" + id);
System.out.println(name + "=" + name);
System.out.println(email + "=" + email);


/*
web.xml에 입력한 컨텍스트 초기화 파라미터를 읽어온다.
해당 정보는 application 내장객체를 사용해서 읽어올 수 있다.
*/
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//위 정보를 통해 DAO객체를 생성하고 오라클에 연결한다.
MemberDAO dao = new MemberDAO(application);

String pwsearch = dao.pwsearch(id, name, email);

//자원해제
dao.close();


//비밀번호를 찾았을 경우
if (pwsearch != null) {
	JSFunction.alertLocation("비밀번호는 "+ pwsearch + "입니다.", "./login.jsp", out);
}
//비밀번호를 찾지 못했을 때
else {
	JSFunction.alertBack("비밀번호를 찾지 못했습니다.", out);
}
%>