<%@page import="board1.BoardDTO"%>
<%@page import="board1.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//테이블명을 가져온다.
String tname = request.getParameter("tname");

/* 목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99와 
같이 받아온다. 게시물 인출을 위해 파라미터를 받아온다. */
String num = request.getParameter("num");

//DAO객체 생성을 통해 오라클에 연결한다. 
BoardDAO dao = new BoardDAO(application);

//가상번호를 가져온다.
//메인에서 눌러서 들어온 게시물의 번호도 가상번호로 만들것이야
String getVirtualNum = request.getParameter("virtualNum");
String virtualNum = dao.getVirtualNum(num, tname);
//System.out.println("virtualNum: " + virtualNum);

//게시물의 조회수 증가
dao.updateVisitCount(num, tname);


//게시물의 내용을 인출하여 DTO에 저장한다. 
BoardDTO dto = dao.selectView(num, tname);

dao.close();
%>

 
<%@ include file="../include/global_head.jsp" %>

<script>
//게시물 삭제를 위한 Javascript 함수
function deletePost() {
	//confirm() 함수는 대화창에서 '예'를 누를때 true가 반환된다. 
    var confirmed = confirm("정말로 삭제하겠습니까?"); 
    if (confirmed) {
    	//<form> 태그의 name속성을 통해 DOM을 얻어온다.
        var form = document.writeFrm;      
    	//전송방식과 전송할경로를 지정한다. 
        form.method = "post";  
        form.action = "DeleteProcess.jsp";
        //submit() 함수를 통해 폼값을 전송한다. 
        form.submit();  
        //<form>태그 하위의 hidden박스에 설정된 일련번호를 전송한다. 
    }
}
</script>
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
				<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
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
<form name="writeFrm">
<input type="hidden" name="tname" value="<%= tname %>" />
<input type="hidden" name="num" value="<%= num %>" />

	<!-- DTO에 저장된 내용을 getter를 통해 웹브라우저에 출력한다. -->  
    <table class="table table-bordered" width="100%">
        <tr>
            <th style="text-align: center; vertical-align:middle;">번호</th>
            <td><%= virtualNum %></td>
            <th style="text-align: center; vertical-align:middle;">작성자</th>
            <td><%= dto.getName() %></td>
        </tr>
        <tr>
            <th style="text-align: center; vertical-align:middle;">작성일</th>
            <td><%= dto.getPostdate() %></td>
            <th style="text-align: center; vertical-align:middle;">조회수</th>
            <td><%= dto.getVisitcount() %></td>
        </tr>
        <tr>
            <th style="width: 100px; text-align: center; vertical-align:middle;">제목</th>
            <td colspan="3"><%= dto.getTitle() %></td>
        </tr>
        <tr>
            <th style="text-align: center; vertical-align:middle;">내용</th>
            <td colspan="3" height="100%">
            	<!-- 입력시 줄바꿈을 위한 엔터는 \r\n으로 입력되므로 
            	웹	브라우저에 출력시에는 <br>태그로 변경해야한다. -->
                <%= dto.getContent().replace("\r\n", "<br/>") %>
            </td> 
        </tr>
        <tr>
            <td colspan="4" align="center">
<%
/* 로그인이 된 상태에서 세션영역에 저장된 아이디가 해당 게시물을 
작성한 아이디와 일치하면 수정, 삭제 버튼을 보이게 처리한다. 
즉, 작성자 본인이 해당 게시물을 조회했을때만 수정, 삭제 버튼이 보이게
처리한다. */
if(session.getAttribute("id")!=null &&  
	dto.getId().equals(session.getAttribute("id").toString())){
%>
     <button type="button"
             onclick="location.href='sub01Edit.jsp?tname=<%= tname %>&num=<%= dto.getNum() %>';">
         수정하기</button>
         
     <!-- 삭제하기 버튼을 누르면 JS의 함수를 호출한다. 해당 함수는 
     submit()을 통해 폼값을 서버로 전송한다.  -->
     <button type="button" onclick="deletePost();">삭제하기</button> 
<%
}
%>
                <button type="button" onclick="location.href='./sub01List.jsp?tname=<%= tname %>';">
                    목록 보기
                </button>
            </td>
        </tr>
    </table>
</form>
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