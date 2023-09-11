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
				<input type="hidden" name="tname" value="<%= tname %>" />
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
					else if (tname.equals("photoboard")){
					%>
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
					<%
					}
					else if (tname.equals("infoboard")){
					%>
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
					<%
					}
					%>
				</div>
				<div>
				
<!-- 게시판 들어가는 부분 S -->
<form method="get">
<input type="hidden" name="tname" value="<%= tname %>" />
    <table class="table" width="100%">
    <tr>
        <td align="center">
            <select style="width: 70px; height: 30px; border-radius: 5px;" name="searchField"> 
                <option style="font-size: 14px; width: 70px" value="title">제목</option> 
                <option style="font-size: 14px;" value="content">내용</option>
            </select>
            <input class="border" style="height: 30px; font-size: 14px; padding: 10px; outline-color: #D8D8D8; border-radius: 5%;" type="text" name="searchWord" />
            <input class="btn btn-sm" style="font-size: 14px; background-color: #EBEBEB" type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
</form>
<table class="table table-bordered" width="100%">
        <tr class="text-center" style="font-size: 14px;">
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
else if (!tname.equals("photoboard")) {
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
<tr align="center" style="font-size: 14px;">
    <td><%= virtualNum %></td>
    <td align="left"> 
        <p style="width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="./sub01View.jsp?tname=<%= tname %>&num=<%= dto.getNum() %>&virtualNum=<%= virtualNum %>" style="text-decoration: none;" >
        	<%= dto.getTitle() %></a></p>
    </td>
    <td align="center"><%= dto.getId() %></td>
    <td align="center"><%= dto.getVisitcount() %></td>
    <td align="center"><%= dto.getPostdate() %></td>  
</tr>
<%
    }
}
else {
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
<tr align="center" style="font-size: 14px;">
    <td><%= virtualNum %></td>
    <td align="left"> 
        <p style="width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="../controller/photoView.tj?photobard&num=<%= dto.getNum() %>&virtualNum=<%= virtualNum %>" style="text-decoration: none;" >
        	<%= dto.getTitle() %></a></p>
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
        <tr align="right" style="font-size: 14px;">
        	<%
        	if (tname.equals("board")){
        		if (session.getAttribute("id") != null && session.getAttribute("id").toString().equals("manager")){
        	%>
        	<td align="center" style="position: relative; left: 180px;">
        	<%= BoardPage.pagingImg(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI(), tname) %>
        	</td>
            <td align="right"><button type="button" class="btn btn-sm" style="font-size: 14px; background-color: #EBEBEB;" onclick="location.href='./sub01Write.jsp?tname=<%= tname %>';">글쓰기
                </button></td>
        	<%
        		}
        		else{
        	%>
        		<td align="center" style="padding-left: 0%;">
        		<%= BoardPage.pagingImg(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI(), tname) %>
        	</td>
        	<%
        		}
        	}
        	else if (tname.equals("photoboard")){
        	%>
        	<td align="center" style="position: relative; left: 180px;">
        	<%= BoardPage.pagingImg(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI(), tname) %>
        	</td>
        	<td align="right"><button type="button" class="btn btn-sm" style="font-size: 14px; background-color: #EBEBEB;" onclick="location.href='../controller/photoWrite.tj?tname=photoboard';">글쓰기
                </button></td>
        	<%
        	}
        	else{
        	%>
        	<td align="center" style="position: relative; left: 180px;">
        	<%= BoardPage.pagingImg(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI(), tname) %>
        	</td>
        	<td align="right"><button type="button" class="btn btn-sm" style="font-size: 14px; background-color: #EBEBEB;" onclick="location.href='./sub01Write.jsp?tname=<%= tname %>';">글쓰기
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