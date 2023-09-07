<%@page import="utils.BoardPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
//공지사항 테이블 -> board
//String tname = "board";
//String tname = "freeboard";
String tname = request.getParameter("tname");
%>  
    
<%@ include file="./ListCommon.jsp" %>
    
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					
					<%
					if (tname.equals("board")){
					%>
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
					<%
					}
					else if (tname.equals("freeboard")){
					%>
					<img src="../images/space/sub03_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
					<%
					}
					%>
					
				</div>
				<div>
<!-- 게시판 들어가는 부분 S -->
<form method="get">  
    <table width="100%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option style="font-size: 13px;" value="title">제목</option> 
                <option style="font-size: 13px;" value="content">내용</option>
            </select>
            <input class="border" type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
</form>
<table class="table table-bordered" width="100%">
        <tr class="text-center">
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
<%
//컬렉션에 입력된 데이터가 없는지 확인한다. 
if (boardLists.isEmpty()) {
%>
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다.
            </td>
        </tr>
<%
}
else {
	/* 출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에 저장된
	레코드의 갯수만큼 반복하여 출력한다. */
    int virtualNum = 0;  
  
	
    int countNum = 0;  
    for (BoardDTO dto : boardLists)
    {
    	/* 현재 출력할 게시물의 갯수에 따라 번호가 달라지게 되므로 
    	totalCount를 사용하여 가상번호를 부여한다. */
        //virtualNum = totalCount--; 
    	
    	virtualNum = totalCount - (((pageNum - 1) * pageSize) 
    			+ countNum++);
%>
<tr align="center">
    <td><%= virtualNum %></td>
    <td align="left"> 
        <a href="./sub01View.jsp?tname=<%= tname %>&num=<%= dto.getNum() %>&virtualNum=<%= virtualNum %>" style="text-decoration: none;">
        	<%= dto.getTitle() %></a> 
    </td>
    <td align="center"><%= dto.getId() %></td>
    <td align="center"><%= dto.getVisitcount() %></td>
    <td align="center"><%= dto.getPostdate() %></td>  
</tr>
<%
    }
}
%>

    </table>
    <table class="table" width="100%">
        <tr align="right">
        	<td align="center">
        	<%= BoardPage.pagingImg(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>
        	</td>
        	<%
        	if (tname.equals("board")){
        		if (session.getAttribute("id") != null && session.getAttribute("id").toString().equals("manager")){
        	%>
            <td><button type="button" class="btn btn-outline-primary" style="font-size: 13px; font-weight: bold;" onclick="location.href='./sub01Write.jsp?tname=<%= tname %>';">글쓰기
                </button></td>
        	<%
        		}
        	}
        	else{
        	%>
        	<td><button type="button" class="btn btn-outline-primary" style="font-size: 13px; font-weight: bold;" onclick="location.href='./sub01Write.jsp?tname=<%= tname %>';">글쓰기
                </button></td>
        	<%
        	}
        	%>
        </tr>
    </table>
<!-- 게시판 들어가는 부분 E -->
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>