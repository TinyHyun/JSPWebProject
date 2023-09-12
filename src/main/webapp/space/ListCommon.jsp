<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board1.BoardDAO"%>
<%@page import="board1.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
BoardDAO dao = new BoardDAO(application);

Map<String, Object> param = new HashMap<String, Object>();

/************************************/
//현재 게시판에서 사용하는 테이블을 Map컬렉션에 저장한다.
param.put("tname", tname);
/************************************/


String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

if (searchWord != null){
	param.put("searchField" ,searchField);
	param.put("searchWord", searchWord);
}

int totalCount = dao.selectCount(param);


/* #paging관련 코드 추가 start# */
int pageSize = 
	Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = 
	Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

int totalPage = (int)Math.ceil((double)totalCount / pageSize); 

int pageNum = 1; 
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
 	pageNum = Integer.parseInt(pageTemp); 

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
/* #paging관련 코드 추가 end# */

List<BoardDTO> boardLists = dao.selectListPage(param);
List<BoardDTO> photoLists = dao.selectPhPage(param);

dao.close();
%>