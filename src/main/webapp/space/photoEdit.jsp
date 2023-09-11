<%@page import="board1.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!-- 수정페이지로 진입시 로그인을 확인한다.  -->    
<%@ include file="./IsLoggedIn.jsp"%>

<%@ include file="../include/global_head.jsp" %> 
  
<%
BoardDTO dto = (BoardDTO)request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function validateForm(form) {  
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
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
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>
				
<!-- 게시판 들어가는 부분 S -->

<!-- 수정페이지는 일반적으로 쓰기페이지를 복사해서 제작하게 되므로 
action속성값을 반드시 수정해야 한다. 만약 수정하지 않으면 게시물이 
추가되는 헤프닝이 생기게된다.  -->
<form name="writeFrm" method="post" action="../controller/photoEdit.tj"
      onsubmit="return validateForm(this);" enctype="multipart/form-data">
<input type="hidden" name="tname"s value="photoboard" />

<!-- 수정할 게시물의 일련번호 -->
<input type="hidden" name="num" value="${ dto.num }" />
<!-- 기존 등록된 파일. 만약 수정페이지에서 첨부파일을 변경하지 않는다면 여기에 등록된 파일명을 사용해서 update할 예정이다. -->
<input type="hidden" name="prevOfile" value="${ dto.ofile }" />
<input type="hidden" name="prevSfile" value="${ dto.sfile }" />

      
<!-- 게시물의 일련번호를 서버로 전송하기 위해 hidden 타입의 <input>태그가
반드시 필요하다. 이 부분이 추가되지 않으면 게시물은 수정되지 않는다. -->
<input type="hidden" name="num" value="<%= dto.getNum() %>" />
      
    <table class="table table-bordered" width="100%">
        <tr style="text-align: center; vertical-align:middle;">
            <th>제목</th>
            <td>
            	<!-- <input>태그인 경우 기존의 내용을 value속성에 
            	추가하면 된다. -->
                <input type="text" name="title" style="width: 100%;" 
                	value="<%= dto.getTitle() %>" />
            </td>
        </tr>
        <tr style="text-align: center; vertical-align:middle;">
            <th>내용</th>
            <td>
                <textarea name="content" style="width: 100%; height: 350px; resize: none;" ><%= dto.getContent() %></textarea>
            </td>
        </tr>
         <tr>
        	<th style="text-align: center; vertical-align:middle;">첨부파일</th>
        	<td>
        		<input type="file" name="ofile" />
        	</td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='../space/sub01List.jsp?tname=photoboard';">
                    목록 보기</button>
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