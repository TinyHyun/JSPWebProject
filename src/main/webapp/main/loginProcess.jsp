<%@page import="utils.CookieManager"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//로그인 폼에서 전송한 폼값을 받는다.
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//쿠키
String save_id = request.getParameter("save_id");

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
/*
폼값으로 받은 아이디, 패스워드를 인수로 전달하여 로그인 처리를 위한 회원인증을 진행한다.
일치하는 레코드가 있다면 DTO에 저장하여 반환한다.
*/
MemberDTO memberDTO = dao.getMemberDTO(id, pass);

//자원해제
dao.close();


if (memberDTO.getId() != null) {
	//로그인에 성공한 경우
	//session 영역에 회원아이디와 이름을 저장한다.
	session.setAttribute("id", memberDTO.getId());
	session.setAttribute("name", memberDTO.getName());
	
	//쿠키
	if (save_id != null && save_id.equals("Y")){
		CookieManager.makeCookie(response, "saveId", id, 86400);
	}
	else {
		CookieManager.deleteCookie(response, "saveId");
	}
	
	//그리고 로그인 페이지로 <'이동'>한다.
	response.sendRedirect("../index.jsp");
}
else {
	// 로그인에 실패한 경우
    // JavaScript를 사용하여 경고창을 표시하고 로그인 페이지로 포워드한다.
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter printWriter = response.getWriter();
    out.println("<script>alert('아이디와 비밀번호를 다시 입력하세요.');</script>");
    out.println("<script>location.href='../member/login.jsp';</script>");

}
%>