<%@page import="board1.BoardDAO"%>
<%@page import="board1.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 작성자 본인만 삭제할 수 있으므로 기본적인 로그인 체크는 해야한다. -->    
<%@ include file="./IsLoggedIn.jsp"%>  
<%
//일련번호를 폼값으로 받는다. 
String num = request.getParameter("num");   
String tname = request.getParameter("tname");

if (tname == null){
	tname = "photoboard";
}

BoardDTO dto = new BoardDTO();             
BoardDAO dao = new BoardDAO(application);

//본인 확인을 위해 기존 게시물을 인출한다. 
if (tname == null){
	dto = dao.selectView(num);
}
else {
	dto = dao.selectView(num, tname);  
}


/* session영역에 저장된 회원정보를 얻어온 후 String 타입으로 변환한다. 
session을 포함한 4가지 영역에 값을 저장할때는 모두 Object타입으로 자동
형변환되므로 사용을 위해서는 기존의 타입으로 형변환 해야한다. */
String sessionId = session.getAttribute("id").toString(); 
//String sessionId = (String) session.getAttribute("UserId");

int delResult = 0;

//세션아이디와 게시물의 아이디가 일치하면 작성자 본인이므로..
if (sessionId.equals(dto.getId())) { 
	//게시물을 삭제한다. 
    dto.setNum(num);
	if (tname == null) {
		delResult = dao.deletePost(dto);
	}
	else {
	    delResult = dao.deletePost(dto, tname);
	}
    dao.close();

    if (delResult == 1) {
    	/* 게시물이 삭제되면 목록으로 이동한다. */
        JSFunction.alertLocation("게시물이 삭제되었습니다.", "./sub01List.jsp?tname=" + tname, out); 
    } 
    else {
    	/* 삭제에 실패하면 뒤로 이동한다. */
        JSFunction.alertBack("게시물 삭제에 실패하였습니다.", out);
    } 
} 
else {
	/* 작성자 본인이 아니면 삭제할 수 없다. */
    JSFunction.alertBack("작성자만 삭제할 수 있습니다.", out);
    return;
}
%>



